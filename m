From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [RFC PATCH 3/5] signal: Always keep real_blocked in sync with blocked
Date: Fri, 07 Jun 2019 16:42:38 -0500
Message-ID: <8736klax81.fsf_-_@xmission.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
	<20190529161157.GA27659@redhat.com>
	<20190604134117.GA29963@redhat.com>
	<20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Fri, 07 Jun 2019 16:39:54 -0500")
Sender: owner-linux-aio@kvack.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Except where we temporarily override blocked always keep real_blocked
in sync with blocked.

By always setting real_blocked when we set blocked this allows
some slight efficiency and simplifications, by not having
to save blocked.

This also preparse the code for the removal of saved_sigmask.  That
should result in a massive simplification.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c     |  1 +
 kernel/signal.c     | 14 ++++++++++----
 virt/kvm/kvm_main.c |  8 --------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..6507d700d70f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -968,6 +968,7 @@ int ptrace_request(struct task_struct *child, long request,
 		 */
 		spin_lock_irq(&child->sighand->siglock);
 		child->blocked = new_set;
+		child->real_blocked = new_set;
 		spin_unlock_irq(&child->sighand->siglock);
 
 		clear_tsk_restore_sigmask(child);
diff --git a/kernel/signal.c b/kernel/signal.c
index bfa36320a4f7..fcd84f4a93c9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2878,6 +2878,9 @@ void set_current_blocked(sigset_t *newset)
 {
 	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	__set_current_blocked(newset);
+
+	/* Lockless, only current can change ->real_blocked, never from irq */
+	current->real_blocked = *newset;
 }
 
 void __set_current_blocked(const sigset_t *newset)
@@ -2928,15 +2931,20 @@ int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 	}
 
 	__set_current_blocked(&newset);
+
+	/* Lockless, only current can change ->real_blocked, never from irq */
+	tsk->real_blocked = newset;
 	return 0;
 }
 EXPORT_SYMBOL(sigprocmask);
 
-static int set_sigmask(sigset_t *kmask)
+static int set_sigmask(sigset_t *newset)
 {
 	set_restore_sigmask();
 	current->saved_sigmask = current->blocked;
-	set_current_blocked(kmask);
+
+	sigdelsetmask(newset, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	__set_current_blocked(newset);
 
 	return 0;
 }
@@ -3440,7 +3448,6 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		 * they arrive. Unblocking is always fine, we can avoid
 		 * set_current_blocked().
 		 */
-		tsk->real_blocked = tsk->blocked;
 		sigandsets(&tsk->blocked, &tsk->blocked, &mask);
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
@@ -3450,7 +3457,6 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 							 HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
-		sigemptyset(&tsk->real_blocked);
 		sig = dequeue_signal(tsk, &mask, info);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8575a1010bfc..4bfed018574a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2234,13 +2234,6 @@ void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 	if (!vcpu->sigset_active)
 		return;
 
-	/*
-	 * This does a lockless modification of ->real_blocked, which is fine
-	 * because, only current can change ->real_blocked and all readers of
-	 * ->real_blocked don't care as long ->real_blocked is always a subset
-	 * of ->blocked.
-	 */
-	current->real_blocked = current->blocked;
 	__set_current_blocked(&vcpu->sigset);
 }
 
@@ -2250,7 +2243,6 @@ void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 		return;
 
 	__set_current_blocked(&current->real_blocked);
-	sigemptyset(&current->real_blocked);
 }
 
 static void grow_halt_poll_ns(struct kvm_vcpu *vcpu)
-- 
2.21.0.dirty

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
