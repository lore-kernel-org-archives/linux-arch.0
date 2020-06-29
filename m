From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 03/41] x86: kill dump_fpu()
Date: Mon, 29 Jun 2020 19:25:50 +0100
Message-ID: <20200629182628.529995-3-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

dead since the removal of aout coredump support...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/fpu/internal.h |  1 -
 arch/x86/kernel/fpu/regset.c        | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f45bf9c..0c85a08176c0 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -34,7 +34,6 @@ extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
-extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 
 /*
  * Boot time FPU initialization functions:
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index bd1d0649f8ce..91f80aca27fb 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -356,20 +356,4 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
-/*
- * FPU state for core dumps.
- * This is only used for a.out dumps now.
- * It is declared generically using elf_fpregset_t (which is
- * struct user_i387_struct) but is in fact only used for 32-bit
- * dumps, so on 64-bit it is really struct user_i387_ia32_struct.
- */
-int dump_fpu(struct pt_regs *regs, struct user_i387_struct *ufpu)
-{
-	struct task_struct *tsk = current;
-
-	return !fpregs_get(tsk, NULL, 0, sizeof(struct user_i387_ia32_struct),
-			   ufpu, NULL);
-}
-EXPORT_SYMBOL(dump_fpu);
-
 #endif	/* CONFIG_X86_32 || CONFIG_IA32_EMULATION */
-- 
2.11.0
