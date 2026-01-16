
build/main.o:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <q15_axpy_ref>:
   0:	02d05f63          	blez	a3,3e <.L1>
   4:	0686                	slli	a3,a3,0x1
   6:	6e21                	lui	t3,0x8
   8:	00d50833          	add	a6,a0,a3
   c:	7361                	lui	t1,0xffff8
   e:	68a1                	lui	a7,0x8
  10:	3e7d                	addiw	t3,t3,-1 # 7fff <.L22+0x7da9>

0000000000000012 <.L5>:
  12:	00059783          	lh	a5,0(a1)
  16:	00051683          	lh	a3,0(a0)
  1a:	0589                	addi	a1,a1,2
  1c:	02e787bb          	mulw	a5,a5,a4
  20:	0509                	addi	a0,a0,2
  22:	9ebd                	addw	a3,a3,a5
  24:	87b6                	mv	a5,a3
  26:	0066d463          	bge	a3,t1,2e <.L3>
  2a:	77e1                	lui	a5,0xffff8
  2c:	76e1                	lui	a3,0xffff8

000000000000002e <.L3>:
  2e:	0116c363          	blt	a3,a7,34 <.L4>
  32:	87f2                	mv	a5,t3

0000000000000034 <.L4>:
  34:	00f61023          	sh	a5,0(a2)
  38:	0609                	addi	a2,a2,2
  3a:	fca81ce3          	bne	a6,a0,12 <.L5>

000000000000003e <.L1>:
  3e:	8082                	ret

0000000000000040 <q15_axpy_rvv>:
  40:	1101                	addi	sp,sp,-32
  42:	00000897          	auipc	a7,0x0
  46:	0008b883          	ld	a7,0(a7) # 42 <q15_axpy_rvv+0x2>
  4a:	ec06                	sd	ra,24(sp)
  4c:	0008b783          	ld	a5,0(a7)
  50:	e43e                	sd	a5,8(sp)
  52:	4781                	li	a5,0
  54:	02d05863          	blez	a3,84 <.L9>

0000000000000058 <.L11>:
  58:	0ca6f7d7          	vsetvli	a5,a3,e16,m4,ta,ma
  5c:	0205dc07          	vle16.v	v24,(a1)
  60:	00179813          	slli	a6,a5,0x1
  64:	02055407          	vle16.v	v8,(a0)
  68:	ef876857          	vwmul.vx	v16,v24,a4
  6c:	9e9d                	subw	a3,a3,a5
  6e:	d7042c57          	vwadd.wv	v24,v16,v8
  72:	bf803c57          	vnclip.wi	v24,v24,0
  76:	02065c27          	vse16.v	v24,(a2)
  7a:	9542                	add	a0,a0,a6
  7c:	95c2                	add	a1,a1,a6
  7e:	9642                	add	a2,a2,a6
  80:	fcd04ce3          	bgtz	a3,58 <.L11>

0000000000000084 <.L9>:
  84:	6722                	ld	a4,8(sp)
  86:	0008b783          	ld	a5,0(a7)
  8a:	8fb9                	xor	a5,a5,a4
  8c:	4701                	li	a4,0
  8e:	e781                	bnez	a5,96 <.L15>
  90:	60e2                	ld	ra,24(sp)
  92:	6105                	addi	sp,sp,32
  94:	8082                	ret

0000000000000096 <.L15>:
  96:	00000097          	auipc	ra,0x0
  9a:	000080e7          	jalr	ra # 96 <.L15>

Disassembly of section .text.startup:

0000000000000000 <main>:
   0:	715d                	addi	sp,sp,-80
   2:	00000517          	auipc	a0,0x0
   6:	00050513          	mv	a0,a0
   a:	e486                	sd	ra,72(sp)
   c:	e0a2                	sd	s0,64(sp)
   e:	fc26                	sd	s1,56(sp)
  10:	f84a                	sd	s2,48(sp)
  12:	f44e                	sd	s3,40(sp)
  14:	f052                	sd	s4,32(sp)
  16:	ec56                	sd	s5,24(sp)
  18:	e85a                	sd	s6,16(sp)
  1a:	e45e                	sd	s7,8(sp)
  1c:	00000097          	auipc	ra,0x0
  20:	000080e7          	jalr	ra # 1c <main+0x1c>
  24:	6605                	lui	a2,0x1
  26:	00000597          	auipc	a1,0x0
  2a:	00058593          	mv	a1,a1
  2e:	4509                	li	a0,2
  30:	00000097          	auipc	ra,0x0
  34:	000080e7          	jalr	ra # 30 <main+0x30>
  38:	6509                	lui	a0,0x2
  3a:	00000097          	auipc	ra,0x0
  3e:	000080e7          	jalr	ra # 3a <main+0x3a>
  42:	842a                	mv	s0,a0
  44:	6509                	lui	a0,0x2
  46:	00000097          	auipc	ra,0x0
  4a:	000080e7          	jalr	ra # 46 <main+0x46>
  4e:	89aa                	mv	s3,a0
  50:	6509                	lui	a0,0x2
  52:	00000097          	auipc	ra,0x0
  56:	000080e7          	jalr	ra # 52 <main+0x52>
  5a:	892a                	mv	s2,a0
  5c:	6509                	lui	a0,0x2
  5e:	00000097          	auipc	ra,0x0
  62:	000080e7          	jalr	ra # 5e <main+0x5e>
  66:	84aa                	mv	s1,a0
  68:	8622                	mv	a2,s0
  6a:	86ce                	mv	a3,s3
  6c:	4701                	li	a4,0
  6e:	06400e13          	li	t3,100
  72:	03200313          	li	t1,50
  76:	6505                	lui	a0,0x1

0000000000000078 <.L18>:
  78:	03c767bb          	remw	a5,a4,t3
  7c:	00177893          	andi	a7,a4,1
  80:	17c2                	slli	a5,a5,0x30
  82:	93c1                	srli	a5,a5,0x30
  84:	0267683b          	remw	a6,a4,t1
  88:	40f005bb          	negw	a1,a5
  8c:	2705                	addiw	a4,a4,1
  8e:	00089563          	bnez	a7,98 <.L17>
  92:	03059793          	slli	a5,a1,0x30
  96:	93c1                	srli	a5,a5,0x30

0000000000000098 <.L17>:
  98:	00f61023          	sh	a5,0(a2) # 1000 <.L22+0xdaa>
  9c:	01069023          	sh	a6,0(a3) # ffffffffffff8000 <.L22+0xffffffffffff7daa>
  a0:	0609                	addi	a2,a2,2
  a2:	0689                	addi	a3,a3,2
  a4:	fca71ae3          	bne	a4,a0,78 <.L18>
  a8:	470d                	li	a4,3
  aa:	6685                	lui	a3,0x1
  ac:	864a                	mv	a2,s2
  ae:	85ce                	mv	a1,s3
  b0:	8522                	mv	a0,s0
  b2:	00000097          	auipc	ra,0x0
  b6:	000080e7          	jalr	ra # b2 <.L17+0x1a>
  ba:	c0002bf3          	rdcycle	s7
  be:	c0202b73          	rdinstret	s6
  c2:	470d                	li	a4,3
  c4:	6685                	lui	a3,0x1
  c6:	864a                	mv	a2,s2
  c8:	85ce                	mv	a1,s3
  ca:	8522                	mv	a0,s0
  cc:	00000097          	auipc	ra,0x0
  d0:	000080e7          	jalr	ra # cc <.L17+0x34>
  d4:	c0202a73          	rdinstret	s4
  d8:	c0002af3          	rdcycle	s5
  dc:	00000517          	auipc	a0,0x0
  e0:	00050513          	mv	a0,a0
  e4:	00000097          	auipc	ra,0x0
  e8:	000080e7          	jalr	ra # e4 <.L17+0x4c>
  ec:	417a8ab3          	sub	s5,s5,s7
  f0:	8656                	mv	a2,s5
  f2:	00000597          	auipc	a1,0x0
  f6:	00058593          	mv	a1,a1
  fa:	4509                	li	a0,2
  fc:	00000097          	auipc	ra,0x0
 100:	000080e7          	jalr	ra # fc <.L17+0x64>
 104:	416a0a33          	sub	s4,s4,s6
 108:	8652                	mv	a2,s4
 10a:	00000597          	auipc	a1,0x0
 10e:	00058593          	mv	a1,a1
 112:	4509                	li	a0,2
 114:	00000097          	auipc	ra,0x0
 118:	000080e7          	jalr	ra # 114 <.L17+0x7c>
 11c:	470d                	li	a4,3
 11e:	6685                	lui	a3,0x1
 120:	8626                	mv	a2,s1
 122:	85ce                	mv	a1,s3
 124:	8522                	mv	a0,s0
 126:	00000097          	auipc	ra,0x0
 12a:	000080e7          	jalr	ra # 126 <.L17+0x8e>
 12e:	c0002bf3          	rdcycle	s7
 132:	c0202b73          	rdinstret	s6
 136:	470d                	li	a4,3
 138:	6685                	lui	a3,0x1
 13a:	8626                	mv	a2,s1
 13c:	85ce                	mv	a1,s3
 13e:	8522                	mv	a0,s0
 140:	00000097          	auipc	ra,0x0
 144:	000080e7          	jalr	ra # 140 <.L17+0xa8>
 148:	c0202473          	rdinstret	s0
 14c:	c00029f3          	rdcycle	s3
 150:	00000517          	auipc	a0,0x0
 154:	00050513          	mv	a0,a0
 158:	00000097          	auipc	ra,0x0
 15c:	000080e7          	jalr	ra # 158 <.L17+0xc0>
 160:	417989b3          	sub	s3,s3,s7
 164:	864e                	mv	a2,s3
 166:	00000597          	auipc	a1,0x0
 16a:	00058593          	mv	a1,a1
 16e:	4509                	li	a0,2
 170:	00000097          	auipc	ra,0x0
 174:	000080e7          	jalr	ra # 170 <.L17+0xd8>
 178:	41640433          	sub	s0,s0,s6
 17c:	8622                	mv	a2,s0
 17e:	00000597          	auipc	a1,0x0
 182:	00058593          	mv	a1,a1
 186:	4509                	li	a0,2
 188:	00000097          	auipc	ra,0x0
 18c:	000080e7          	jalr	ra # 188 <.L17+0xf0>
 190:	00000517          	auipc	a0,0x0
 194:	00050513          	mv	a0,a0
 198:	00000097          	auipc	ra,0x0
 19c:	000080e7          	jalr	ra # 198 <.L17+0x100>
 1a0:	d23af753          	fcvt.d.lu	fa4,s5
 1a4:	d239f7d3          	fcvt.d.lu	fa5,s3
 1a8:	00000597          	auipc	a1,0x0
 1ac:	00058593          	mv	a1,a1
 1b0:	4509                	li	a0,2
 1b2:	1af777d3          	fdiv.d	fa5,fa4,fa5
 1b6:	4981                	li	s3,0
 1b8:	4a91                	li	s5,4
 1ba:	00000b17          	auipc	s6,0x0
 1be:	000b0b13          	mv	s6,s6
 1c2:	e2078653          	fmv.x.d	a2,fa5
 1c6:	00000097          	auipc	ra,0x0
 1ca:	000080e7          	jalr	ra # 1c6 <.L17+0x12e>
 1ce:	d23a7753          	fcvt.d.lu	fa4,s4
 1d2:	d23477d3          	fcvt.d.lu	fa5,s0
 1d6:	00000597          	auipc	a1,0x0
 1da:	00058593          	mv	a1,a1
 1de:	4509                	li	a0,2
 1e0:	1af777d3          	fdiv.d	fa5,fa4,fa5
 1e4:	4401                	li	s0,0
 1e6:	6a05                	lui	s4,0x1
 1e8:	e2078653          	fmv.x.d	a2,fa5
 1ec:	00000097          	auipc	ra,0x0
 1f0:	000080e7          	jalr	ra # 1ec <.L17+0x154>
 1f4:	a031                	j	200 <.L21>

00000000000001f6 <.L19>:
 1f6:	2405                	addiw	s0,s0,1
 1f8:	0909                	addi	s2,s2,2
 1fa:	0489                	addi	s1,s1,2
 1fc:	03440763          	beq	s0,s4,22a <.L27>

0000000000000200 <.L21>:
 200:	00091683          	lh	a3,0(s2)
 204:	00049703          	lh	a4,0(s1)
 208:	fee687e3          	beq	a3,a4,1f6 <.L19>
 20c:	2985                	addiw	s3,s3,1
 20e:	ff3ac4e3          	blt	s5,s3,1f6 <.L19>
 212:	8622                	mv	a2,s0
 214:	85da                	mv	a1,s6
 216:	4509                	li	a0,2
 218:	2405                	addiw	s0,s0,1
 21a:	00000097          	auipc	ra,0x0
 21e:	000080e7          	jalr	ra # 21a <.L21+0x1a>
 222:	0909                	addi	s2,s2,2
 224:	0489                	addi	s1,s1,2
 226:	fd441de3          	bne	s0,s4,200 <.L21>

000000000000022a <.L27>:
 22a:	02099663          	bnez	s3,256 <.L22>
 22e:	00000517          	auipc	a0,0x0
 232:	00050513          	mv	a0,a0
 236:	00000097          	auipc	ra,0x0
 23a:	000080e7          	jalr	ra # 236 <.L27+0xc>

000000000000023e <.L23>:
 23e:	60a6                	ld	ra,72(sp)
 240:	6406                	ld	s0,64(sp)
 242:	74e2                	ld	s1,56(sp)
 244:	7942                	ld	s2,48(sp)
 246:	79a2                	ld	s3,40(sp)
 248:	7a02                	ld	s4,32(sp)
 24a:	6ae2                	ld	s5,24(sp)
 24c:	6b42                	ld	s6,16(sp)
 24e:	6ba2                	ld	s7,8(sp)
 250:	4501                	li	a0,0
 252:	6161                	addi	sp,sp,80
 254:	8082                	ret

0000000000000256 <.L22>:
 256:	864e                	mv	a2,s3
 258:	00000597          	auipc	a1,0x0
 25c:	00058593          	mv	a1,a1
 260:	4509                	li	a0,2
 262:	00000097          	auipc	ra,0x0
 266:	000080e7          	jalr	ra # 262 <.L22+0xc>
 26a:	bfd1                	j	23e <.L23>
