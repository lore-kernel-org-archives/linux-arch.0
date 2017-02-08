Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbdBHSBX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Feb 2017 13:01:23 -0500
From: Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/mutex,rwsem: Reduce vcpu_is_preempted() calling frequency
Date: Wed,  8 Feb 2017 13:00:25 -0500
Message-ID: <1486576825-17058-2-git-send-email-longman@redhat.com>
In-Reply-To: <1486576825-17058-1-git-send-email-longman@redhat.com>
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Waiman Long <longman@redhat.com>
Message-ID: <20170208180025.Yu9AAx3cvu1uct5oE1kZ3Kz5L4ZCQR1doVKKcD7jRvg@z>

As the vcpu_is_preempted() call is pretty costly compared with other
checks within mutex_spin_on_owner() and rwsem_spin_on_owner(), they
are done at a reduce frequency of once every 256 iterations.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mutex.c      | 5 ++++-
 kernel/locking/rwsem-xadd.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index ad2d9e2..2ece0c4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -423,6 +423,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 			 struct ww_acquire_ctx *ww_ctx, struct mutex_waiter *waiter)
 {
 	bool ret = true;
+	int loop = 0;
 
 	rcu_read_lock();
 	while (__mutex_owner(lock) == owner) {
@@ -436,9 +437,11 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		/*
 		 * Use vcpu_is_preempted to detect lock holder preemption issue.
+		 * As vcpu_is_preempted is more costly to use, it is called at
+		 * a reduced frequencey (once every 256 iterations).
 		 */
 		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		   (!(++loop & 0xff) &&	vcpu_is_preempted(task_cpu(owner)))) {
 			ret = false;
 			break;
 		}
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 2ad8d8d..7a884a6 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -351,6 +351,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
+	int loop = 0;
 
 	if (!rwsem_owner_is_writer(owner))
 		goto out;
@@ -367,10 +368,11 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 		/*
 		 * abort spinning when need_resched or owner is not running or
-		 * owner's cpu is preempted.
+		 * owner's cpu is preempted. The preemption check is done at
+		 * a lower frequencey because of its high cost.
 		 */
 		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		   (!(++loop & 0xff) &&	vcpu_is_preempted(task_cpu(owner)))) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
1.8.3.1

