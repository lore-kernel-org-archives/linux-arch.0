From: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC patch 02/15] x86/entry: Remove _TIF_NOHZ from
 _TIF_WORK_SYSCALL_ENTRY
Date: Thu, 19 Sep 2019 17:03:16 +0200
Message-ID: <20190919150808.617944343@linutronix.de>
References: <20190919150314.054351477@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
is not only pointless, it's actually counterproductive:

 1) Context tracking code is invoked unconditionally before that flag is
    evaluated.

 2) If the flag is set the slow path is invoked for nothing due to #1

Remove it.  

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/thread_info.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -133,14 +133,10 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/*
- * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
- * enter_from_user_mode()
- */
+/* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_NOHZ)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE						\
