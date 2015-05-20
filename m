From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: [PATCH v2] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
Date: Wed, 20 May 2015 18:18:29 +0200
Message-ID: <555CB3D5.7000307@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>
List-Id: linux-arch.vger.kernel.org

=46rom: Andr=E9 Hentschel <nerv@dawncrow.de>

Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeabl=
e TLS
register on ARM is preserved per thread.

This patch does it analogous to the ARM patch, but for compat mode on A=
RM64.

Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>

---
This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa=
74a031)

v2: Trying to address suggestions by Will Deacon

@Will Deacon: 	The macro you suggested is not helpful it seems, instead=
 i introduced
		static functions. They also could be macros i guess, but it seems
		much cleaner to me to use functions as it only affects one file.
Should the final version be send to rmk's patchtracker or will someone =
else pick it up?


 arch/arm64/include/asm/processor.h |  3 +++
 arch/arm64/kernel/process.c        | 41 +++++++++++++++++++++++++++++-=
--------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/as=
m/processor.h
index d2c37a1..466a851 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -79,6 +79,9 @@ struct cpu_context {
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
 	unsigned long		tp_value;
+#ifdef CONFIG_COMPAT
+	unsigned long		tp_compat;
+#endif
 	struct fpsimd_state	fpsimd_state;
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..630f44b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -58,6 +58,22 @@ unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
=20
+static unsigned long get_tp_compat(struct thread_struct *p)
+{
+#ifdef CONFIG_COMPAT
+	return p->tp_compat;
+#else
+	return 0;
+#endif
+}
+
+static void set_tp_compat(struct thread_struct *p, unsigned long tpidr=
)
+{
+#ifdef CONFIG_COMPAT
+	p->tp_compat =3D tpidr;
+#endif
+}
+
 void soft_restart(unsigned long addr)
 {
 	setup_mm_for_reboot();
@@ -219,6 +235,7 @@ static void tls_thread_flush(void)
=20
 	if (is_compat_task()) {
 		current->thread.tp_value =3D 0;
+		set_tp_compat(&current->thread, 0);
=20
 		/*
 		 * We need to ensure ordering between the shadow state and the
@@ -259,17 +276,22 @@ int copy_thread(unsigned long clone_flags, unsign=
ed long stack_start,
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
=20
 	if (likely(!(p->flags & PF_KTHREAD))) {
+		unsigned long tpidr;
 		*childregs =3D *current_pt_regs();
 		childregs->regs[0] =3D 0;
+		/*
+		 * Read the current TLS pointer from tpidr_el0 as it may be
+		 * out-of-sync with the saved value.
+		 */
+		asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
 		if (is_compat_thread(task_thread_info(p))) {
+			set_tp_compat(&p->thread, tpidr);
+
 			if (stack_start)
 				childregs->compat_sp =3D stack_start;
 		} else {
-			/*
-			 * Read the current TLS pointer from tpidr_el0 as it may be
-			 * out-of-sync with the saved value.
-			 */
-			asm("mrs %0, tpidr_el0" : "=3Dr" (tls));
+			tls =3D tpidr;
+
 			if (stack_start) {
 				/* 16-byte aligned stack mandatory on AArch64 */
 				if (stack_start & 15)
@@ -302,13 +324,14 @@ static void tls_thread_switch(struct task_struct =
*next)
 {
 	unsigned long tpidr, tpidrro;
=20
-	if (!is_compat_task()) {
-		asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
+	asm("mrs %0, tpidr_el0" : "=3Dr" (tpidr));
+	if (is_compat_task())
+		set_tp_compat(&current->thread, tpidr);
+	else
 		current->thread.tp_value =3D tpidr;
-	}
=20
 	if (is_compat_thread(task_thread_info(next))) {
-		tpidr =3D 0;
+		tpidr =3D get_tp_compat(&next->thread);
 		tpidrro =3D next->thread.tp_value;
 	} else {
 		tpidr =3D next->thread.tp_value;
