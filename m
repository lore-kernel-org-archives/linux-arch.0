From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 05/19] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Sat, 18 Jun 2016 02:54:14 +0300
Message-ID: <1466207668-10549-6-git-send-email-ynorov@caviumnetworks.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-70764-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
List-Id: linux-arch.vger.kernel.org

From: Andrew Pinski <apinski@cavium.com>

In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.

From now, AARCH32_EL0 (former COMPAT) config option means the support of
AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
and COMPAT indicates that one of them, or both, is enabled.

Where needed, CONFIG_COMPAT is changed over to use CONFIG_AARCH32_EL0 instead

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig                   | 10 ++++++++--
 arch/arm64/include/asm/fpsimd.h      |  2 +-
 arch/arm64/include/asm/hwcap.h       |  4 ++--
 arch/arm64/include/asm/processor.h   |  6 +++---
 arch/arm64/include/asm/ptrace.h      |  2 +-
 arch/arm64/include/asm/signal32.h    |  6 ++++--
 arch/arm64/include/asm/unistd.h      |  2 +-
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/asm-offsets.c      |  2 +-
 arch/arm64/kernel/cpufeature.c       |  8 ++++----
 arch/arm64/kernel/cpuinfo.c          | 20 +++++++++++---------
 arch/arm64/kernel/entry.S            |  6 +++---
 arch/arm64/kernel/head.S             |  2 +-
 arch/arm64/kernel/ptrace.c           |  8 ++++----
 arch/arm64/kernel/traps.c            |  2 +-
 arch/arm64/kernel/vdso.c             |  4 ++--
 drivers/clocksource/arm_arch_timer.c |  2 +-
 17 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691..aea8e61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -385,7 +385,7 @@ config ARM64_ERRATUM_834220
 
 config ARM64_ERRATUM_845719
 	bool "Cortex-A53: 845719: a load might read incorrect data"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	default y
 	help
 	  This option adds an alternative code sequence to work around ARM
@@ -701,7 +701,7 @@ config FORCE_MAX_ZONEORDER
 
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
-	depends on COMPAT
+	depends on AARCH32_EL0
 	help
 	  Legacy software support may require certain instructions
 	  that have been deprecated or obsoleted in the architecture.
@@ -971,8 +971,14 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	bool
+	depends on AARCH32_EL0
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
+	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
+	select COMPAT
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 50f559f..63b19f1 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -52,7 +52,7 @@ struct fpsimd_partial_state {
 };
 
 
-#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+#if defined(__KERNEL__) && defined(CONFIG_AARCH32_EL0)
 /* Masks for extracting the FPSR and FPCR from the FPSCR */
 #define VFP_FPSCR_STAT_MASK	0xf800009f
 #define VFP_FPSCR_CTRL_MASK	0x07f79f00
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 400b80b..2c7fc5d 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -46,7 +46,7 @@
  */
 #define ELF_HWCAP		(elf_hwcap)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
 #define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
@@ -54,7 +54,7 @@ extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 
 enum {
 	CAP_HWCAP = 1,
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	CAP_COMPAT_HWCAP,
 	CAP_COMPAT_HWCAP2,
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index cef1cf3..5bbdbb4 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -81,7 +81,7 @@ struct cpu_context {
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
 	unsigned long		tp_value;	/* TLS register */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
@@ -90,7 +90,7 @@ struct thread_struct {
 	struct debug_info	debug;		/* debugging */
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
@@ -121,7 +121,7 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 	regs->sp = sp;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index a307eb6..4c730c3 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -121,7 +121,7 @@ struct pt_regs {
 
 #define arch_has_single_step()	(1)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define compat_thumb_mode(regs) \
 	(((regs)->pstate & COMPAT_PSR_T_BIT))
 #else
diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index eeaa975..e68fcce 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -17,7 +17,9 @@
 #define __ASM_SIGNAL32_H
 
 #ifdef __KERNEL__
-#ifdef CONFIG_COMPAT
+
+#ifdef CONFIG_AARCH32_EL0
+
 #include <linux/compat.h>
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
@@ -47,6 +49,6 @@ static inline int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t
 static inline void compat_setup_restart_syscall(struct pt_regs *regs)
 {
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 #endif /* __KERNEL__ */
 #endif /* __ASM_SIGNAL32_H */
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index e78ac26..fe9d6c1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2173149..631a118 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -25,7 +25,7 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o		\
 					   ../../arm/kernel/opcodes.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index f8e5d47..06090db 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -53,7 +53,7 @@ int main(void)
   DEFINE(S_X7,			offsetof(struct pt_regs, regs[7]));
   DEFINE(S_LR,			offsetof(struct pt_regs, regs[30]));
   DEFINE(S_SP,			offsetof(struct pt_regs, sp));
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
   DEFINE(S_COMPAT_SP,		offsetof(struct pt_regs, compat_sp));
 #endif
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 811773d..9f2fd84 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -32,7 +32,7 @@
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #define COMPAT_ELF_HWCAP_DEFAULT	\
 				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
 				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
@@ -834,7 +834,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 };
 
 static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
@@ -850,7 +850,7 @@ static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	case CAP_HWCAP:
 		elf_hwcap |= cap->hwcap;
 		break;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
 		compat_elf_hwcap |= (u32)cap->hwcap;
 		break;
@@ -873,7 +873,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 	case CAP_HWCAP:
 		rc = (elf_hwcap & cap->hwcap) != 0;
 		break;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
 		rc = (compat_elf_hwcap & (u32)cap->hwcap) != 0;
 		break;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c173d32..af200a8 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -134,15 +134,17 @@ static int c_show(struct seq_file *m, void *v)
 		 */
 		seq_puts(m, "Features\t:");
 		if (compat) {
-#ifdef CONFIG_COMPAT
-			for (j = 0; compat_hwcap_str[j]; j++)
-				if (compat_elf_hwcap & (1 << j))
-					seq_printf(m, " %s", compat_hwcap_str[j]);
-
-			for (j = 0; compat_hwcap2_str[j]; j++)
-				if (compat_elf_hwcap2 & (1 << j))
-					seq_printf(m, " %s", compat_hwcap2_str[j]);
-#endif /* CONFIG_COMPAT */
+#ifdef CONFIG_AARCH32_EL0
+			if (personality(current->personality) == PER_LINUX32) {
+				for (j = 0; compat_hwcap_str[j]; j++)
+					if (compat_elf_hwcap & (1 << j))
+						seq_printf(m, " %s", compat_hwcap_str[j]);
+
+				for (j = 0; compat_hwcap2_str[j]; j++)
+					if (compat_elf_hwcap2 & (1 << j))
+						seq_printf(m, " %s", compat_hwcap2_str[j]);
+			}
+#endif /* CONFIG_AARCH32_EL0 */
 		} else {
 			for (j = 0; hwcap_str[j]; j++)
 				if (elf_hwcap & (1 << j))
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec8bb48..21a0624 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -260,7 +260,7 @@ ENTRY(vectors)
 	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
 	ventry	el0_error_invalid		// Error 64-bit EL0
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	ventry	el0_sync_compat			// Synchronous 32-bit EL0
 	ventry	el0_irq_compat			// IRQ 32-bit EL0
 	ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
@@ -300,7 +300,7 @@ el0_error_invalid:
 	inv_entry 0, BAD_ERROR
 ENDPROC(el0_error_invalid)
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 el0_fiq_invalid_compat:
 	inv_entry 0, BAD_FIQ, 32
 ENDPROC(el0_fiq_invalid_compat)
@@ -463,7 +463,7 @@ el0_sync:
 	b.ge	el0_dbg
 	b	el0_inv
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	.align	6
 el0_sync_compat:
 	kernel_entry 0, 32
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c6e598..4d16787 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -567,7 +567,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
 1:
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3f6cd5c..aa79e81 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -82,7 +82,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 		.si_addr	= (void __user *)(bkpt->trigger),
 	};
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	int i;
 
 	if (!is_compat_task())
@@ -657,7 +657,7 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 #include <linux/compat.h>
 
 enum compat_regset {
@@ -1192,11 +1192,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	/*
 	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
 	 * user_aarch32_view compatible with arm32. Native ptrace requests on
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ab066d1..973faec 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -409,7 +409,7 @@ long compat_arm_syscall(struct pt_regs *regs);
 
 asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	long ret;
 	if (is_compat_task()) {
 		ret = compat_arm_syscall(regs);
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 9fefb00..2a0de6f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -49,7 +49,7 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = &vdso_data_store.data;
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
@@ -108,7 +108,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 static struct vm_special_mapping vdso_spec[2];
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4814446..bc5f13d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -321,7 +321,7 @@ static void arch_timer_evtstrm_enable(int divider)
 			| ARCH_TIMER_VIRT_EVT_EN;
 	arch_timer_set_cntkctl(cntkctl);
 	elf_hwcap |= HWCAP_EVTSTRM;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_AARCH32_EL0
 	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
 #endif
 }
-- 
2.7.4
