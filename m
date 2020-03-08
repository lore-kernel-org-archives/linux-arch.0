From: guoren@kernel.org
Subject: [RFC PATCH V3 10/11] riscv: Add ptrace support
Date: Sun,  8 Mar 2020 17:49:53 +0800
Message-ID: <20200308094954.13258-11-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com, greentime.hu@sifive.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add new regset for vector and the implementation is similar to
fpu.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/uapi/asm/elf.h |  1 +
 arch/riscv/kernel/ptrace.c        | 41 +++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h          |  1 +
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..099434d075a7 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -23,6 +23,7 @@ typedef struct user_regs_struct elf_gregset_t;
 typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
+#define ELF_NVREG  (sizeof(struct __riscv_v_state) / sizeof(elf_greg_t))
 
 #if __riscv_xlen == 64
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 407464201b91..0e3c3543476c 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -26,6 +26,9 @@ enum riscv_regset {
 #ifdef CONFIG_FPU
 	REGSET_F,
 #endif
+#ifdef CONFIG_VECTOR
+	REGSET_V,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -92,6 +95,34 @@ static int riscv_fpr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_VECTOR
+static int riscv_vr_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	int ret;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, vstate, 0,
+				  offsetof(struct __riscv_v_state, vtype));
+	return ret;
+}
+
+static int riscv_vr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct __riscv_v_state *vstate = &target->thread.vstate;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate, 0,
+				 offsetof(struct __riscv_v_state, vtype));
+	return ret;
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -111,6 +142,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = &riscv_fpr_set,
 	},
 #endif
+#ifdef CONFIG_VECTOR
+	[REGSET_V] = {
+		.core_note_type = NT_RISCV_VECTOR,
+		.n = ELF_NVREG,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.get = &riscv_vr_get,
+		.set = &riscv_vr_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..e428f9e8710a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -428,6 +428,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_VECTOR	0x900		/* RISC-V vector registers */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
-- 
2.17.0
