Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34724 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab2IGQ17 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:59 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 27/31] arm64: Loadable modules
Date: Fri,  7 Sep 2012 17:27:02 +0100
Message-ID: <1347035226-18649-28-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162702.MjJ5Iyn2p8a0nGNeUwkqnNAch_br-gJuWOEulc8v6LE@z>

From: Will Deacon <will.deacon@arm.com>

This patch adds support for loadable modules. Loadable modules are
loaded 64MB below the kernel image due to branch relocation restrictions
(see Documentation/arm64/memory.txt).

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/module.h |   23 ++
 arch/arm64/kernel/module.c      |  456 +++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 479 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/module.h
 create mode 100644 arch/arm64/kernel/module.c

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/modul=
e.h
new file mode 100644
index 0000000..e80e232
--- /dev/null
+++ b/arch/arm64/include/asm/module.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_MODULE_H
+#define __ASM_MODULE_H
+
+#include <asm-generic/module.h>
+
+#define MODULE_ARCH_VERMAGIC=09"aarch64"
+
+#endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
new file mode 100644
index 0000000..ca0e3d5
--- /dev/null
+++ b/arch/arm64/kernel/module.c
@@ -0,0 +1,456 @@
+/*
+ * AArch64 loadable module support.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/elf.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/moduleloader.h>
+#include <linux/vmalloc.h>
+
+void *module_alloc(unsigned long size)
+{
+=09return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+=09=09=09=09    GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
+=09=09=09=09    __builtin_return_address(0));
+}
+
+enum aarch64_reloc_op {
+=09RELOC_OP_NONE,
+=09RELOC_OP_ABS,
+=09RELOC_OP_PREL,
+=09RELOC_OP_PAGE,
+};
+
+static u64 do_reloc(enum aarch64_reloc_op reloc_op, void *place, u64 val)
+{
+=09switch (reloc_op) {
+=09case RELOC_OP_ABS:
+=09=09return val;
+=09case RELOC_OP_PREL:
+=09=09return val - (u64)place;
+=09case RELOC_OP_PAGE:
+=09=09return (val & ~0xfff) - ((u64)place & ~0xfff);
+=09case RELOC_OP_NONE:
+=09=09return 0;
+=09}
+
+=09pr_err("do_reloc: unknown relocation operation %d\n", reloc_op);
+=09return 0;
+}
+
+static int reloc_data(enum aarch64_reloc_op op, void *place, u64 val, int =
len)
+{
+=09u64 imm_mask =3D (1 << len) - 1;
+=09s64 sval =3D do_reloc(op, place, val);
+
+=09switch (len) {
+=09case 16:
+=09=09*(s16 *)place =3D sval;
+=09=09break;
+=09case 32:
+=09=09*(s32 *)place =3D sval;
+=09=09break;
+=09case 64:
+=09=09*(s64 *)place =3D sval;
+=09=09break;
+=09default:
+=09=09pr_err("Invalid length (%d) for data relocation\n", len);
+=09=09return 0;
+=09}
+
+=09/*
+=09 * Extract the upper value bits (including the sign bit) and
+=09 * shift them to bit 0.
+=09 */
+=09sval =3D (s64)(sval & ~(imm_mask >> 1)) >> (len - 1);
+
+=09/*
+=09 * Overflow has occurred if the value is not representable in
+=09 * len bits (i.e the bottom len bits are not sign-extended and
+=09 * the top bits are not all zero).
+=09 */
+=09if ((u64)(sval + 1) > 2)
+=09=09return -ERANGE;
+
+=09return 0;
+}
+
+enum aarch64_imm_type {
+=09INSN_IMM_MOVNZ,
+=09INSN_IMM_MOVK,
+=09INSN_IMM_ADR,
+=09INSN_IMM_26,
+=09INSN_IMM_19,
+=09INSN_IMM_16,
+=09INSN_IMM_14,
+=09INSN_IMM_12,
+=09INSN_IMM_9,
+};
+
+static u32 encode_insn_immediate(enum aarch64_imm_type type, u32 insn, u64=
 imm)
+{
+=09u32 immlo, immhi, lomask, himask, mask;
+=09int shift;
+
+=09switch (type) {
+=09case INSN_IMM_MOVNZ:
+=09=09/*
+=09=09 * For signed MOVW relocations, we have to manipulate the
+=09=09 * instruction encoding depending on whether or not the
+=09=09 * immediate is less than zero.
+=09=09 */
+=09=09insn &=3D ~(3 << 29);
+=09=09if ((s64)imm >=3D 0) {
+=09=09=09/* >=3D0: Set the instruction to MOVZ (opcode 10b). */
+=09=09=09insn |=3D 2 << 29;
+=09=09} else {
+=09=09=09/*
+=09=09=09 * <0: Set the instruction to MOVN (opcode 00b).
+=09=09=09 *     Since we've masked the opcode already, we
+=09=09=09 *     don't need to do anything other than
+=09=09=09 *     inverting the new immediate field.
+=09=09=09 */
+=09=09=09imm =3D ~imm;
+=09=09}
+=09case INSN_IMM_MOVK:
+=09=09mask =3D BIT(16) - 1;
+=09=09shift =3D 5;
+=09=09break;
+=09case INSN_IMM_ADR:
+=09=09lomask =3D 0x3;
+=09=09himask =3D 0x7ffff;
+=09=09immlo =3D imm & lomask;
+=09=09imm >>=3D 2;
+=09=09immhi =3D imm & himask;
+=09=09imm =3D (immlo << 24) | (immhi);
+=09=09mask =3D (lomask << 24) | (himask);
+=09=09shift =3D 5;
+=09=09break;
+=09case INSN_IMM_26:
+=09=09mask =3D BIT(26) - 1;
+=09=09shift =3D 0;
+=09=09break;
+=09case INSN_IMM_19:
+=09=09mask =3D BIT(19) - 1;
+=09=09shift =3D 5;
+=09=09break;
+=09case INSN_IMM_16:
+=09=09mask =3D BIT(16) - 1;
+=09=09shift =3D 5;
+=09=09break;
+=09case INSN_IMM_14:
+=09=09mask =3D BIT(14) - 1;
+=09=09shift =3D 5;
+=09=09break;
+=09case INSN_IMM_12:
+=09=09mask =3D BIT(12) - 1;
+=09=09shift =3D 10;
+=09=09break;
+=09case INSN_IMM_9:
+=09=09mask =3D BIT(9) - 1;
+=09=09shift =3D 12;
+=09=09break;
+=09default:
+=09=09pr_err("encode_insn_immediate: unknown immediate encoding %d\n",
+=09=09=09type);
+=09=09return 0;
+=09}
+
+=09/* Update the immediate field. */
+=09insn &=3D ~(mask << shift);
+=09insn |=3D (imm & mask) << shift;
+
+=09return insn;
+}
+
+static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
+=09=09=09   int lsb, enum aarch64_imm_type imm_type)
+{
+=09u64 imm, limit =3D 0;
+=09s64 sval;
+=09u32 insn =3D *(u32 *)place;
+
+=09sval =3D do_reloc(op, place, val);
+=09sval >>=3D lsb;
+=09imm =3D sval & 0xffff;
+
+=09/* Update the instruction with the new encoding. */
+=09*(u32 *)place =3D encode_insn_immediate(imm_type, insn, imm);
+
+=09/* Shift out the immediate field. */
+=09sval >>=3D 16;
+
+=09/*
+=09 * For unsigned immediates, the overflow check is straightforward.
+=09 * For signed immediates, the sign bit is actually the bit past the
+=09 * most significant bit of the field.
+=09 * The INSN_IMM_16 immediate type is unsigned.
+=09 */
+=09if (imm_type !=3D INSN_IMM_16) {
+=09=09sval++;
+=09=09limit++;
+=09}
+
+=09/* Check the upper bits depending on the sign of the immediate. */
+=09if ((u64)sval > limit)
+=09=09return -ERANGE;
+
+=09return 0;
+}
+
+static int reloc_insn_imm(enum aarch64_reloc_op op, void *place, u64 val,
+=09=09=09  int lsb, int len, enum aarch64_imm_type imm_type)
+{
+=09u64 imm, imm_mask;
+=09s64 sval;
+=09u32 insn =3D *(u32 *)place;
+
+=09/* Calculate the relocation value. */
+=09sval =3D do_reloc(op, place, val);
+=09sval >>=3D lsb;
+
+=09/* Extract the value bits and shift them to bit 0. */
+=09imm_mask =3D (BIT(lsb + len) - 1) >> lsb;
+=09imm =3D sval & imm_mask;
+
+=09/* Update the instruction's immediate field. */
+=09*(u32 *)place =3D encode_insn_immediate(imm_type, insn, imm);
+
+=09/*
+=09 * Extract the upper value bits (including the sign bit) and
+=09 * shift them to bit 0.
+=09 */
+=09sval =3D (s64)(sval & ~(imm_mask >> 1)) >> (len - 1);
+
+=09/*
+=09 * Overflow has occurred if the upper bits are not all equal to
+=09 * the sign bit of the value.
+=09 */
+=09if ((u64)(sval + 1) >=3D 2)
+=09=09return -ERANGE;
+
+=09return 0;
+}
+
+int apply_relocate_add(Elf64_Shdr *sechdrs,
+=09=09       const char *strtab,
+=09=09       unsigned int symindex,
+=09=09       unsigned int relsec,
+=09=09       struct module *me)
+{
+=09unsigned int i;
+=09int ovf;
+=09bool overflow_check;
+=09Elf64_Sym *sym;
+=09void *loc;
+=09u64 val;
+=09Elf64_Rela *rel =3D (void *)sechdrs[relsec].sh_addr;
+
+=09for (i =3D 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+=09=09/* loc corresponds to P in the AArch64 ELF document. */
+=09=09loc =3D (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+=09=09=09+ rel[i].r_offset;
+
+=09=09/* sym is the ELF symbol we're referring to. */
+=09=09sym =3D (Elf64_Sym *)sechdrs[symindex].sh_addr
+=09=09=09+ ELF64_R_SYM(rel[i].r_info);
+
+=09=09/* val corresponds to (S + A) in the AArch64 ELF document. */
+=09=09val =3D sym->st_value + rel[i].r_addend;
+
+=09=09/* Check for overflow by default. */
+=09=09overflow_check =3D true;
+
+=09=09/* Perform the static relocation. */
+=09=09switch (ELF64_R_TYPE(rel[i].r_info)) {
+=09=09/* Null relocations. */
+=09=09case R_ARM_NONE:
+=09=09case R_AARCH64_NONE:
+=09=09=09ovf =3D 0;
+=09=09=09break;
+
+=09=09/* Data relocations. */
+=09=09case R_AARCH64_ABS64:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_data(RELOC_OP_ABS, loc, val, 64);
+=09=09=09break;
+=09=09case R_AARCH64_ABS32:
+=09=09=09ovf =3D reloc_data(RELOC_OP_ABS, loc, val, 32);
+=09=09=09break;
+=09=09case R_AARCH64_ABS16:
+=09=09=09ovf =3D reloc_data(RELOC_OP_ABS, loc, val, 16);
+=09=09=09break;
+=09=09case R_AARCH64_PREL64:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_data(RELOC_OP_PREL, loc, val, 64);
+=09=09=09break;
+=09=09case R_AARCH64_PREL32:
+=09=09=09ovf =3D reloc_data(RELOC_OP_PREL, loc, val, 32);
+=09=09=09break;
+=09=09case R_AARCH64_PREL16:
+=09=09=09ovf =3D reloc_data(RELOC_OP_PREL, loc, val, 16);
+=09=09=09break;
+
+=09=09/* MOVW instruction relocations. */
+=09=09case R_AARCH64_MOVW_UABS_G0_NC:
+=09=09=09overflow_check =3D false;
+=09=09case R_AARCH64_MOVW_UABS_G0:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
+=09=09=09=09=09      INSN_IMM_16);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_UABS_G1_NC:
+=09=09=09overflow_check =3D false;
+=09=09case R_AARCH64_MOVW_UABS_G1:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
+=09=09=09=09=09      INSN_IMM_16);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_UABS_G2_NC:
+=09=09=09overflow_check =3D false;
+=09=09case R_AARCH64_MOVW_UABS_G2:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
+=09=09=09=09=09      INSN_IMM_16);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_UABS_G3:
+=09=09=09/* We're using the top bits so we can't overflow. */
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 48,
+=09=09=09=09=09      INSN_IMM_16);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_SABS_G0:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_SABS_G1:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_SABS_G2:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G0_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
+=09=09=09=09=09      INSN_IMM_MOVK);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G0:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G1_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
+=09=09=09=09=09      INSN_IMM_MOVK);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G1:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G2_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
+=09=09=09=09=09      INSN_IMM_MOVK);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G2:
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+=09=09case R_AARCH64_MOVW_PREL_G3:
+=09=09=09/* We're using the top bits so we can't overflow. */
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_movw(RELOC_OP_PREL, loc, val, 48,
+=09=09=09=09=09      INSN_IMM_MOVNZ);
+=09=09=09break;
+
+=09=09/* Immediate instruction relocations. */
+=09=09case R_AARCH64_LD_PREL_LO19:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
+=09=09=09=09=09     INSN_IMM_19);
+=09=09=09break;
+=09=09case R_AARCH64_ADR_PREL_LO21:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
+=09=09=09=09=09     INSN_IMM_ADR);
+=09=09=09break;
+=09=09case R_AARCH64_ADR_PREL_PG_HI21_NC:
+=09=09=09overflow_check =3D false;
+=09=09case R_AARCH64_ADR_PREL_PG_HI21:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
+=09=09=09=09=09     INSN_IMM_ADR);
+=09=09=09break;
+=09=09case R_AARCH64_ADD_ABS_LO12_NC:
+=09=09case R_AARCH64_LDST8_ABS_LO12_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_ABS, loc, val, 0, 12,
+=09=09=09=09=09     INSN_IMM_12);
+=09=09=09break;
+=09=09case R_AARCH64_LDST16_ABS_LO12_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_ABS, loc, val, 1, 11,
+=09=09=09=09=09     INSN_IMM_12);
+=09=09=09break;
+=09=09case R_AARCH64_LDST32_ABS_LO12_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_ABS, loc, val, 2, 10,
+=09=09=09=09=09     INSN_IMM_12);
+=09=09=09break;
+=09=09case R_AARCH64_LDST64_ABS_LO12_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_ABS, loc, val, 3, 9,
+=09=09=09=09=09     INSN_IMM_12);
+=09=09=09break;
+=09=09case R_AARCH64_LDST128_ABS_LO12_NC:
+=09=09=09overflow_check =3D false;
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_ABS, loc, val, 4, 8,
+=09=09=09=09=09     INSN_IMM_12);
+=09=09=09break;
+=09=09case R_AARCH64_TSTBR14:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 14,
+=09=09=09=09=09     INSN_IMM_14);
+=09=09=09break;
+=09=09case R_AARCH64_CONDBR19:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
+=09=09=09=09=09     INSN_IMM_19);
+=09=09=09break;
+=09=09case R_AARCH64_JUMP26:
+=09=09case R_AARCH64_CALL26:
+=09=09=09ovf =3D reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 26,
+=09=09=09=09=09     INSN_IMM_26);
+=09=09=09break;
+
+=09=09default:
+=09=09=09pr_err("module %s: unsupported RELA relocation: %llu\n",
+=09=09=09       me->name, ELF64_R_TYPE(rel[i].r_info));
+=09=09=09return -ENOEXEC;
+=09=09}
+
+=09=09if (overflow_check && ovf =3D=3D -ERANGE)
+=09=09=09goto overflow;
+
+=09}
+
+=09return 0;
+
+overflow:
+=09pr_err("module %s: overflow in relocation type %d val %Lx\n",
+=09       me->name, (int)ELF64_R_TYPE(rel[i].r_info), val);
+=09return -ENOEXEC;
+}

