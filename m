From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V5 08/15] x86/entry: Move user return notifier out of loop
Date: Thu, 23 Jul 2020 00:00:02 +0200
Message-ID: <20200722220520.159112003@linutronix.de>
References: <20200722215954.464281930@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:52552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbgGVWLe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:34 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>

From: Thomas Gleixner <tglx@linutronix.de>

Guests and user space share certain MSRs. KVM sets these MSRs to guest
values once and does not set them back to user space values on every VM
exit to spare the costly MSR operations.

User return notifiers ensure that these MSRs are set back to the correct
values before returning to user space in exit_to_usermode_loop().

There is no reason to evaluate the TIF flag indicating that user return
notifiers need to be invoked in the loop. The important point is that they
are invoked before returning to user space.

Move the invocation out of the loop into the section which does the last
preperatory steps before returning to user space. That section is not
preemptible and runs with interrupts disabled until the actual return.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
V4: New patch
---
 arch/x86/entry/common.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -208,7 +208,7 @@ static long syscall_trace_enter(struct p
 
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
@@ -242,9 +242,6 @@ static void exit_to_usermode_loop(struct
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
-		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-			fire_user_return_notifiers();
-
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
@@ -273,6 +270,9 @@ static void __prepare_exit_to_usermode(s
 	/* Reload ti->flags; we may have rescheduled above. */
 	cached_flags = READ_ONCE(ti->flags);
 
+	if (cached_flags & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
 	if (unlikely(cached_flags & _TIF_IO_BITMAP))
 		tss_update_io_bitmap();
 
