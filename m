From: David Howells <dhowells@redhat.com>
Subject: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Date: Wed, 02 Sep 2009 08:21:29 +0100
Message-ID: <20090902072129.3578.81364.stgit@warthog.procyon.org.uk>
References: <20090902072053.3578.69125.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <20090902072053.3578.69125.stgit@warthog.procyon.org.uk>
Sender: linux-security-module-owner@vger.kernel.org
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Implement TIF_NOTIFY_RESUME for most of those architectures in which isn't yet
available, and, whilst we're at it, have it call the appropriate tracehook.

After this patch, blackfin, m68k* and xtensa still lack support and need
alteration of assembly code to make it work.

Resume notification can then be used (by a later patch) to install a new
session keyring on the parent of a process.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-arch@vger.kernel.org
---

 arch/alpha/include/asm/thread_info.h  |    5 ++++-
 arch/alpha/kernel/signal.c            |    5 +++++
 arch/arm/include/asm/thread_info.h    |    3 +++
 arch/arm/kernel/entry-common.S        |    2 +-
 arch/arm/kernel/signal.c              |    5 +++++
 arch/avr32/include/asm/thread_info.h  |    6 +++++-
 arch/avr32/kernel/entry-avr32b.S      |    2 +-
 arch/avr32/kernel/signal.c            |    5 +++++
 arch/cris/kernel/ptrace.c             |    5 +++++
 arch/h8300/include/asm/thread_info.h  |    2 ++
 arch/h8300/kernel/signal.c            |    5 +++++
 arch/m32r/include/asm/thread_info.h   |    2 ++
 arch/m32r/kernel/signal.c             |    5 +++++
 arch/mips/include/asm/thread_info.h   |    2 ++
 arch/mips/kernel/signal.c             |    5 +++++
 arch/parisc/include/asm/thread_info.h |    4 +++-
 arch/parisc/kernel/entry.S            |    2 +-
 arch/parisc/kernel/signal.c           |    5 +++++
 18 files changed, 64 insertions(+), 6 deletions(-)


diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 60c83ab..5076a88 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -75,6 +75,7 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define TIF_UAC_SIGBUS		7
 #define TIF_MEMDIE		8
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal */
+#define TIF_NOTIFY_RESUME	10	/* callback before returning to user */
 #define TIF_FREEZE		16	/* is freezing for suspend */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -82,10 +83,12 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
+#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 /* Work to do on interrupt/exception return.  */
-#define _TIF_WORK_MASK		(_TIF_SIGPENDING | _TIF_NEED_RESCHED)
+#define _TIF_WORK_MASK		(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
+				 _TIF_NOTIFY_RESUME)
 
 /* Work to do on any return to userspace.  */
 #define _TIF_ALLWORK_MASK	(_TIF_WORK_MASK		\
diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index df65eaa..04e17c1 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -683,4 +683,9 @@ do_notify_resume(struct pt_regs *regs, struct switch_stack *sw,
 {
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs, sw, r0, r19);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 73394e5..d3a39b1 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -130,11 +130,13 @@ extern void vfp_sync_state(struct thread_info *thread);
  *  TIF_SYSCALL_TRACE	- syscall trace active
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
+ *  TIF_NOTIFY_RESUME	- callback before returning to user
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
  */
 #define TIF_SIGPENDING		0
 #define TIF_NEED_RESCHED	1
+#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
@@ -143,6 +145,7 @@ extern void vfp_sync_state(struct thread_info *thread);
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 8c3de1a..7813ab7 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -51,7 +51,7 @@ fast_work_pending:
 work_pending:
 	tst	r1, #_TIF_NEED_RESCHED
 	bne	work_resched
-	tst	r1, #_TIF_SIGPENDING
+	tst	r1, #_TIF_SIGPENDING|_TIF_NOTIFY_RESUME
 	beq	no_work_pending
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index f6bc5d4..6759f45 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -707,4 +707,9 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
 	if (thread_flags & _TIF_SIGPENDING)
 		do_signal(&current->blocked, regs, syscall);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/avr32/include/asm/thread_info.h b/arch/avr32/include/asm/thread_info.h
index fc42de5..fd0c5d7 100644
--- a/arch/avr32/include/asm/thread_info.h
+++ b/arch/avr32/include/asm/thread_info.h
@@ -84,6 +84,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_MEMDIE		6
 #define TIF_RESTORE_SIGMASK	7	/* restore signal mask in do_signal */
 #define TIF_CPU_GOING_TO_SLEEP	8	/* CPU is entering sleep 0 mode */
+#define TIF_NOTIFY_RESUME	9	/* callback before returning to user */
 #define TIF_FREEZE		29
 #define TIF_DEBUG		30	/* debugging enabled */
 #define TIF_USERSPACE		31      /* true if FS sets userspace */
@@ -96,6 +97,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_CPU_GOING_TO_SLEEP (1 << TIF_CPU_GOING_TO_SLEEP)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
 
 /* Note: The masks below must never span more than 16 bits! */
@@ -103,13 +105,15 @@ static inline struct thread_info *current_thread_info(void)
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK				\
 	((1 << TIF_SIGPENDING)			\
+	 | _TIF_NOTIFY_RESUME			\
 	 | (1 << TIF_NEED_RESCHED)		\
 	 | (1 << TIF_POLLING_NRFLAG)		\
 	 | (1 << TIF_BREAKPOINT)		\
 	 | (1 << TIF_RESTORE_SIGMASK))
 
 /* work to do on any return to userspace */
-#define _TIF_ALLWORK_MASK	(_TIF_WORK_MASK | (1 << TIF_SYSCALL_TRACE))
+#define _TIF_ALLWORK_MASK	(_TIF_WORK_MASK | (1 << TIF_SYSCALL_TRACE) | \
+				 _TIF_NOTIFY_RESUME)
 /* work to do on return from debug mode */
 #define _TIF_DBGWORK_MASK	(_TIF_WORK_MASK & ~(1 << TIF_BREAKPOINT))
 
diff --git a/arch/avr32/kernel/entry-avr32b.S b/arch/avr32/kernel/entry-avr32b.S
index 009a801..169268c 100644
--- a/arch/avr32/kernel/entry-avr32b.S
+++ b/arch/avr32/kernel/entry-avr32b.S
@@ -281,7 +281,7 @@ syscall_exit_work:
 	ld.w	r1, r0[TI_flags]
 	rjmp	1b
 
-2:	mov	r2, _TIF_SIGPENDING | _TIF_RESTORE_SIGMASK
+2:	mov	r2, _TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NOTIFY_RESUME
 	tst	r1, r2
 	breq	3f
 	unmask_interrupts
diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 2722756..62d242e 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -322,4 +322,9 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, struct thread_info *ti)
 
 	if (ti->flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs, &current->blocked, syscall);
+
+	if (ti->flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/cris/kernel/ptrace.c b/arch/cris/kernel/ptrace.c
index b326023..4f06d7f 100644
--- a/arch/cris/kernel/ptrace.c
+++ b/arch/cris/kernel/ptrace.c
@@ -36,4 +36,9 @@ void do_notify_resume(int canrestart, struct pt_regs *regs,
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(canrestart,regs);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/h8300/include/asm/thread_info.h b/arch/h8300/include/asm/thread_info.h
index 8bbc8b0..70e67e4 100644
--- a/arch/h8300/include/asm/thread_info.h
+++ b/arch/h8300/include/asm/thread_info.h
@@ -89,6 +89,7 @@ static inline struct thread_info *current_thread_info(void)
 					   TIF_NEED_RESCHED */
 #define TIF_MEMDIE		4
 #define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
+#define TIF_NOTIFY_RESUME	6	/* callback before returning to user */
 #define TIF_FREEZE		16	/* is freezing for suspend */
 
 /* as above, but as bit values */
@@ -97,6 +98,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
 
 #define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index cf3472f..56b3ab7 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -552,4 +552,9 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, u32 thread_info_flags)
 {
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs, NULL);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/m32r/include/asm/thread_info.h b/arch/m32r/include/asm/thread_info.h
index 07bb5bd..7157815 100644
--- a/arch/m32r/include/asm/thread_info.h
+++ b/arch/m32r/include/asm/thread_info.h
@@ -149,6 +149,7 @@ static inline unsigned int get_thread_fault_code(void)
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SINGLESTEP		3	/* restore singlestep on return to user mode */
 #define TIF_IRET		4	/* return with iret */
+#define TIF_NOTIFY_RESUME	5	/* callback before returning to user */
 #define TIF_RESTORE_SIGMASK	8	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
@@ -160,6 +161,7 @@ static inline unsigned int get_thread_fault_code(void)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
index 1812454..3220258 100644
--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -408,5 +408,10 @@ void do_notify_resume(struct pt_regs *regs, sigset_t *oldset,
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
 
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
+
 	clear_thread_flag(TIF_IRET);
 }
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index f9df720..01cc163 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -115,6 +115,7 @@ register struct thread_info *__current_thread_info __asm__("$28");
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SYSCALL_AUDIT	3	/* syscall auditing active */
 #define TIF_SECCOMP		4	/* secure computing */
+#define TIF_NOTIFY_RESUME	5	/* callback before returning to user */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
@@ -139,6 +140,7 @@ register struct thread_info *__current_thread_info __asm__("$28");
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 830c5ef..a3d1015 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -700,4 +700,9 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	/* deal with pending signal delivery */
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }
diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index 4ce0edf..ac775a7 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -59,6 +59,7 @@ struct thread_info {
 #define TIF_MEMDIE		5
 #define TIF_RESTORE_SIGMASK	6	/* restore saved signal mask */
 #define TIF_FREEZE		7	/* is freezing for suspend */
+#define TIF_NOTIFY_RESUME	8	/* callback before returning to user */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -67,8 +68,9 @@ struct thread_info {
 #define _TIF_32BIT		(1 << TIF_32BIT)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 
-#define _TIF_USER_WORK_MASK     (_TIF_SIGPENDING | \
+#define _TIF_USER_WORK_MASK     (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | \
                                  _TIF_NEED_RESCHED | _TIF_RESTORE_SIGMASK)
 
 #endif /* __KERNEL__ */
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index e552e54..8c4712b 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -948,7 +948,7 @@ intr_check_sig:
 	/* As above */
 	mfctl   %cr30,%r1
 	LDREG	TI_FLAGS(%r1),%r19
-	ldi	(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK), %r20
+	ldi	(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NOTIFY_RESUME), %r20
 	and,COND(<>)	%r19, %r20, %r0
 	b,n	intr_restore	/* skip past if we've nothing to do */
 
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index f825442..b3bfc43 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -645,4 +645,9 @@ void do_notify_resume(struct pt_regs *regs, long in_syscall)
 	if (test_thread_flag(TIF_SIGPENDING) ||
 	    test_thread_flag(TIF_RESTORE_SIGMASK))
 		do_signal(regs, in_syscall);
+
+	if (test_thread_flag(TIF_NOTIFY_RESUME)) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
 }

