
build/final.o:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <q15_axpy_ref>:
}

void q15_axpy_ref(const int16_t *a, const int16_t *b,
                  int16_t *y, int n, int16_t alpha)
{
    for (int i = 0; i < n; ++i) {
   0:	04d05163          	blez	a3,42 <.L1>
   4:	0686                	slli	a3,a3,0x1

0000000000000006 <.LBB29>:
    if (v >  32767) return  32767;
   6:	6321                	lui	t1,0x8
   8:	00d508b3          	add	a7,a0,a3
   c:	fff30e13          	addi	t3,t1,-1 # 7fff <.LLST9+0x7ce3>
    if (v < -32768) return -32768;
  10:	7ee1                	lui	t4,0xffff8

0000000000000012 <.L4>:
        int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
  12:	00059783          	lh	a5,0(a1)
  16:	00051803          	lh	a6,0(a0)

000000000000001a <.LBB37>:
    if (v >  32767) return  32767;
  1a:	86f2                	mv	a3,t3

000000000000001c <.LBE37>:
        int32_t acc = (int32_t)a[i] + (int32_t)alpha * (int32_t)b[i];
  1c:	02e787bb          	mulw	a5,a5,a4
  20:	010787bb          	addw	a5,a5,a6

0000000000000024 <.LBB38>:
    if (v >  32767) return  32767;
  24:	0067d863          	bge	a5,t1,34 <.L3>
    if (v < -32768) return -32768;
  28:	01d7ce63          	blt	a5,t4,44 <.L7>
    return (int16_t)v;
  2c:	0107969b          	slliw	a3,a5,0x10
  30:	4106d69b          	sraiw	a3,a3,0x10

0000000000000034 <.L3>:
        y[i] = sat_q15_scalar(acc);
  34:	00d61023          	sh	a3,0(a2)

0000000000000038 <.LBE29>:
    for (int i = 0; i < n; ++i) {
  38:	0509                	addi	a0,a0,2

000000000000003a <.LVL6>:
  3a:	0589                	addi	a1,a1,2
  3c:	0609                	addi	a2,a2,2
  3e:	fd151ae3          	bne	a0,a7,12 <.L4>

0000000000000042 <.L1>:
    }
}
  42:	8082                	ret

0000000000000044 <.L7>:
    if (v < -32768) return -32768;
  44:	76e1                	lui	a3,0xffff8
  46:	b7fd                	j	34 <.L3>

0000000000000048 <q15_axpy_rvv>:
#include <riscv_vector.h>  // v1.0 test macro & header inclusion

// -------------------- RVV implementation (mentees edit only here) ---------
void q15_axpy_rvv(const int16_t *a, const int16_t *b,
                  int16_t *y, int n, int16_t alpha)
{
  48:	1101                	addi	sp,sp,-32
  4a:	00000897          	auipc	a7,0x0
  4e:	0008b883          	ld	a7,0(a7) # 4a <q15_axpy_rvv+0x2>
  52:	ec06                	sd	ra,24(sp)
  54:	0008b783          	ld	a5,0(a7)
  58:	e43e                	sd	a5,8(sp)
  5a:	4781                	li	a5,0
    size_t vl;
    for (; n > 0; n -= vl) {
  5c:	02d05863          	blez	a3,8c <.L10>

0000000000000060 <.L12>:
        // Set vl based on input size (16-bit) and input LMUL as m4
        vl = __riscv_vsetvl_e16m4(n); 
  60:	0ca6f7d7          	vsetvli	a5,a3,e16,m4,ta,ma

0000000000000064 <.LVL11>:

        // Load inputs LMUL m4
        vint16m4_t va = __riscv_vle16_v_i16m4(a, vl);
        vint16m4_t vb = __riscv_vle16_v_i16m4(b, vl);
  64:	0205dc07          	vle16.v	v24,(a1)
        vint16m4_t vy = __riscv_vnclip_wx_i16m4(v_acc, 0, vl);

        // Store LMUL m4
        __riscv_vse16_v_i16m4(y, vy, vl);

        a += vl; b += vl; y += vl;
  68:	00179813          	slli	a6,a5,0x1
        vint16m4_t va = __riscv_vle16_v_i16m4(a, vl);
  6c:	02055407          	vle16.v	v8,(a0)
        vint32m8_t v_acc = __riscv_vwmul_vx_i32m8(vb, alpha, vl);
  70:	ef876857          	vwmul.vx	v16,v24,a4

0000000000000074 <.LBE42>:
    for (; n > 0; n -= vl) {
  74:	9e9d                	subw	a3,a3,a5

0000000000000076 <.LBB43>:
        v_acc = __riscv_vwadd_wv_i32m8(v_acc, va, vl);
  76:	d7042c57          	vwadd.wv	v24,v16,v8
        vint16m4_t vy = __riscv_vnclip_wx_i16m4(v_acc, 0, vl);
  7a:	bf803c57          	vnclip.wi	v24,v24,0
        __riscv_vse16_v_i16m4(y, vy, vl);
  7e:	02065c27          	vse16.v	v24,(a2)
        a += vl; b += vl; y += vl;
  82:	9542                	add	a0,a0,a6

0000000000000084 <.LVL16>:
  84:	95c2                	add	a1,a1,a6

0000000000000086 <.LVL17>:
  86:	9642                	add	a2,a2,a6

0000000000000088 <.LBE43>:
    for (; n > 0; n -= vl) {
  88:	fcd04ce3          	bgtz	a3,60 <.L12>

000000000000008c <.L10>:
    }
}
  8c:	6722                	ld	a4,8(sp)
  8e:	0008b783          	ld	a5,0(a7)
  92:	8fb9                	xor	a5,a5,a4
  94:	4701                	li	a4,0

0000000000000096 <.LVL20>:
  96:	e781                	bnez	a5,9e <.L16>
  98:	60e2                	ld	ra,24(sp)
  9a:	6105                	addi	sp,sp,32
  9c:	8082                	ret

000000000000009e <.L16>:
  9e:	00000097          	auipc	ra,0x0
  a2:	000080e7          	jalr	ra # 9e <.L16>

Disassembly of section .text.startup:

0000000000000000 <main>:

#if defined(__riscv)
static inline uint64_t rdcycle(void) { uint64_t c; asm volatile ("rdcycle %0" : "=r"(c)); return c; }
#endif

int main(void) {
   0:	715d                	addi	sp,sp,-80
    int ok = 1;
    const int N = 4096;
    int16_t *a  = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
   2:	6589                	lui	a1,0x2
   4:	04000513          	li	a0,64
int main(void) {
   8:	e486                	sd	ra,72(sp)
   a:	e0a2                	sd	s0,64(sp)
   c:	fc26                	sd	s1,56(sp)
   e:	f84a                	sd	s2,48(sp)
  10:	f44e                	sd	s3,40(sp)
  12:	f052                	sd	s4,32(sp)
  14:	ec56                	sd	s5,24(sp)
  16:	e85a                	sd	s6,16(sp)
  18:	e45e                	sd	s7,8(sp)
  1a:	e062                	sd	s8,0(sp)
    int16_t *a  = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  1c:	00000097          	auipc	ra,0x0
  20:	000080e7          	jalr	ra # 1c <main+0x1c>

0000000000000024 <.LVL23>:
  24:	89aa                	mv	s3,a0
    int16_t *b  = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  26:	6589                	lui	a1,0x2
  28:	04000513          	li	a0,64

000000000000002c <.LVL24>:
  2c:	00000097          	auipc	ra,0x0
  30:	000080e7          	jalr	ra # 2c <.LVL24>

0000000000000034 <.LVL25>:
  34:	8aaa                	mv	s5,a0
    int16_t *y0 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  36:	6589                	lui	a1,0x2
  38:	04000513          	li	a0,64

000000000000003c <.LVL26>:
  3c:	00000097          	auipc	ra,0x0
  40:	000080e7          	jalr	ra # 3c <.LVL26>

0000000000000044 <.LVL27>:
    int16_t *y1 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  44:	6589                	lui	a1,0x2
    int16_t *y0 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  46:	8a2a                	mv	s4,a0
    int16_t *y1 = (int16_t*)aligned_alloc(64, N * sizeof(int16_t));
  48:	04000513          	li	a0,64

000000000000004c <.LVL28>:
  4c:	00000097          	auipc	ra,0x0
  50:	000080e7          	jalr	ra # 4c <.LVL28>

0000000000000054 <.LVL29>:
  54:	8b2a                	mv	s6,a0
  56:	6909                	lui	s2,0x2

    // Deterministic integer data (no libm)
    srand(1234);
  58:	4d200513          	li	a0,1234

000000000000005c <.LBB65>:
    for (int i = 0; i < N; ++i) {
        a[i] = (int16_t)((rand() % 65536) - 32768);
  5c:	6441                	lui	s0,0x10

000000000000005e <.LBE65>:
    srand(1234);
  5e:	00000097          	auipc	ra,0x0
  62:	000080e7          	jalr	ra # 5e <.LBE65>

0000000000000066 <.LBB66>:
    for (int i = 0; i < N; ++i) {
  66:	8bce                	mv	s7,s3
  68:	8c56                	mv	s8,s5
  6a:	994e                	add	s2,s2,s3
        a[i] = (int16_t)((rand() % 65536) - 32768);
  6c:	147d                	addi	s0,s0,-1 # ffff <.LLST9+0xfce3>
  6e:	74e1                	lui	s1,0xffff8

0000000000000070 <.L18>:
  70:	00000097          	auipc	ra,0x0
  74:	000080e7          	jalr	ra # 70 <.L18>

0000000000000078 <.LVL33>:
  78:	41f5579b          	sraiw	a5,a0,0x1f
  7c:	0107d79b          	srliw	a5,a5,0x10
  80:	9d3d                	addw	a0,a0,a5
  82:	8d61                	and	a0,a0,s0
  84:	9d1d                	subw	a0,a0,a5
  86:	9d25                	addw	a0,a0,s1
  88:	00ab9023          	sh	a0,0(s7)
        b[i] = (int16_t)((rand() % 65536) - 32768);
  8c:	00000097          	auipc	ra,0x0
  90:	000080e7          	jalr	ra # 8c <.LVL33+0x14>

0000000000000094 <.LVL34>:
  94:	41f5571b          	sraiw	a4,a0,0x1f
  98:	0107571b          	srliw	a4,a4,0x10
  9c:	00a707bb          	addw	a5,a4,a0
  a0:	8fe1                	and	a5,a5,s0
  a2:	9f99                	subw	a5,a5,a4
  a4:	9fa5                	addw	a5,a5,s1
  a6:	00fc1023          	sh	a5,0(s8)

00000000000000aa <.LVL35>:
    for (int i = 0; i < N; ++i) {
  aa:	0b89                	addi	s7,s7,2

00000000000000ac <.LVL36>:
  ac:	0c09                	addi	s8,s8,2
  ae:	fd2b91e3          	bne	s7,s2,70 <.L18>

00000000000000b2 <.LBB67>:
static inline uint64_t rdcycle(void) { uint64_t c; asm volatile ("rdcycle %0" : "=r"(c)); return c; }
  b2:	c0002473          	rdcycle	s0

00000000000000b6 <.LBE67>:
    }

    const int16_t alpha = 3; // example scalar gain

    uint32_t c0 = rdcycle();
    q15_axpy_ref(a, b, y0, N, alpha);
  b6:	470d                	li	a4,3
  b8:	6685                	lui	a3,0x1
  ba:	8652                	mv	a2,s4
  bc:	85d6                	mv	a1,s5
  be:	854e                	mv	a0,s3
  c0:	00000097          	auipc	ra,0x0
  c4:	000080e7          	jalr	ra # c0 <.LBE67+0xa>

00000000000000c8 <.LBB69>:
static inline uint64_t rdcycle(void) { uint64_t c; asm volatile ("rdcycle %0" : "=r"(c)); return c; }
  c8:	c0002673          	rdcycle	a2

00000000000000cc <.LBB71>:
}

__fortify_function int
printf (const char *__restrict __fmt, ...)
{
  return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
  cc:	00000597          	auipc	a1,0x0
  d0:	00058593          	mv	a1,a1
  d4:	9e01                	subw	a2,a2,s0

00000000000000d6 <.LVL41>:
  d6:	4509                	li	a0,2
  d8:	00000097          	auipc	ra,0x0
  dc:	000080e7          	jalr	ra # d8 <.LVL41+0x2>

00000000000000e0 <.LBB73>:
  e0:	c00024f3          	rdcycle	s1

00000000000000e4 <.LBE73>:

    int32_t md = 0;

#if defined(__riscv)
    c0 = rdcycle();
    q15_axpy_rvv(a, b, y1, N, alpha);
  e4:	470d                	li	a4,3
  e6:	6685                	lui	a3,0x1
  e8:	865a                	mv	a2,s6
  ea:	85d6                	mv	a1,s5
  ec:	854e                	mv	a0,s3
    c0 = rdcycle();
  ee:	2481                	sext.w	s1,s1

00000000000000f0 <.LVL44>:
    q15_axpy_rvv(a, b, y1, N, alpha);
  f0:	00000097          	auipc	ra,0x0
  f4:	000080e7          	jalr	ra # f0 <.LVL44>

00000000000000f8 <.LBB75>:
static inline uint64_t rdcycle(void) { uint64_t c; asm volatile ("rdcycle %0" : "=r"(c)); return c; }
  f8:	c0002973          	rdcycle	s2
  fc:	6889                	lui	a7,0x2

00000000000000fe <.LBE75>:
    c1 = rdcycle();
  fe:	2901                	sext.w	s2,s2

0000000000000100 <.LBB77>:
    for (int i = 0; i < n; ++i) {
 100:	8752                	mv	a4,s4
 102:	85da                	mv	a1,s6
 104:	98d2                	add	a7,a7,s4

0000000000000106 <.LBE79>:
    int ok = 1;
 106:	4405                	li	s0,1
    int32_t md = 0;
 108:	4681                	li	a3,0

000000000000010a <.L22>:
        int32_t d = (int32_t)ref[i] - (int32_t)test[i];
 10a:	00071603          	lh	a2,0(a4)
 10e:	00059803          	lh	a6,0(a1) # cc <.LBB71>

0000000000000112 <.LBE80>:
    for (int i = 0; i < n; ++i) {
 112:	0709                	addi	a4,a4,2

0000000000000114 <.LBB81>:
        if (d > md) md = d;
 114:	8536                	mv	a0,a3
        int32_t d = (int32_t)ref[i] - (int32_t)test[i];
 116:	410607bb          	subw	a5,a2,a6

000000000000011a <.LVL50>:
        if (d < 0) d = -d;
 11a:	0007d463          	bgez	a5,122 <.L19>
 11e:	40c807bb          	subw	a5,a6,a2

0000000000000122 <.L19>:
        if (d != 0) ok = 0;
 122:	0017b613          	seqz	a2,a5
 126:	40c00633          	neg	a2,a2
        if (d > md) md = d;
 12a:	00f6d363          	bge	a3,a5,130 <.L20>
 12e:	853e                	mv	a0,a5

0000000000000130 <.L20>:
 130:	0005069b          	sext.w	a3,a0

0000000000000134 <.LVL52>:
        if (d != 0) ok = 0;
 134:	8c71                	and	s0,s0,a2

0000000000000136 <.LBE81>:
    for (int i = 0; i < n; ++i) {
 136:	0589                	addi	a1,a1,2
 138:	fce899e3          	bne	a7,a4,10a <.L22>

000000000000013c <.LBE77>:
    ok = verify_equal(y0, y1, N, &md);
    printf("Verify RVV: %s (max diff = %d)\n", ok ? "OK" : "FAIL", md);
 13c:	00000617          	auipc	a2,0x0
 140:	00060613          	mv	a2,a2
 144:	c409                	beqz	s0,14e <.L23>
 146:	00000617          	auipc	a2,0x0
 14a:	00060613          	mv	a2,a2

000000000000014e <.L23>:
 14e:	00000597          	auipc	a1,0x0
 152:	00058593          	mv	a1,a1
 156:	4509                	li	a0,2
 158:	00000097          	auipc	ra,0x0
 15c:	000080e7          	jalr	ra # 158 <.L23+0xa>

0000000000000160 <.LBB85>:
    printf("Cycles RVV: %llu\n", (unsigned long long)(c1 - c0));
 160:	4099063b          	subw	a2,s2,s1

0000000000000164 <.LBB88>:
 164:	1602                	slli	a2,a2,0x20
 166:	9201                	srli	a2,a2,0x20
 168:	00000597          	auipc	a1,0x0
 16c:	00058593          	mv	a1,a1
 170:	4509                	li	a0,2
 172:	00000097          	auipc	ra,0x0
 176:	000080e7          	jalr	ra # 172 <.LBB88+0xe>

000000000000017a <.LBE88>:
#endif

    free(a); free(b); free(y0); free(y1);
 17a:	854e                	mv	a0,s3
 17c:	00000097          	auipc	ra,0x0
 180:	000080e7          	jalr	ra # 17c <.LBE88+0x2>

0000000000000184 <.LVL58>:
 184:	8556                	mv	a0,s5
 186:	00000097          	auipc	ra,0x0
 18a:	000080e7          	jalr	ra # 186 <.LVL58+0x2>

000000000000018e <.LVL59>:
 18e:	8552                	mv	a0,s4
 190:	00000097          	auipc	ra,0x0
 194:	000080e7          	jalr	ra # 190 <.LVL59+0x2>

0000000000000198 <.LVL60>:
 198:	855a                	mv	a0,s6
 19a:	00000097          	auipc	ra,0x0
 19e:	000080e7          	jalr	ra # 19a <.LVL60+0x2>

00000000000001a2 <.LVL61>:
    return ok ? 0 : 1;
}
 1a2:	60a6                	ld	ra,72(sp)
 1a4:	00144513          	xori	a0,s0,1
 1a8:	6406                	ld	s0,64(sp)

00000000000001aa <.LVL62>:
 1aa:	74e2                	ld	s1,56(sp)

00000000000001ac <.LVL63>:
 1ac:	7942                	ld	s2,48(sp)

00000000000001ae <.LVL64>:
 1ae:	79a2                	ld	s3,40(sp)

00000000000001b0 <.LVL65>:
 1b0:	7a02                	ld	s4,32(sp)

00000000000001b2 <.LVL66>:
 1b2:	6ae2                	ld	s5,24(sp)

00000000000001b4 <.LVL67>:
 1b4:	6b42                	ld	s6,16(sp)

00000000000001b6 <.LVL68>:
 1b6:	6ba2                	ld	s7,8(sp)
 1b8:	6c02                	ld	s8,0(sp)
 1ba:	2501                	sext.w	a0,a0

00000000000001bc <.LVL69>:
 1bc:	6161                	addi	sp,sp,80
 1be:	8082                	ret
