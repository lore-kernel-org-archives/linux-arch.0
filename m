From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 69/93] asm-generic/futex: Re-enable preemption in futex_atomic_cmpxchg_inatomic()
Date: Tue, 26 Apr 2016 11:17:09 -0700
Message-ID: <1461694653-29506-70-git-send-email-kamal@canonical.com>
References: <1461694653-29506-1-git-send-email-kamal@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461694653-29506-1-git-send-email-kamal@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Romain Perier <romain.perier@free-electrons.com>, linux-arch@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Kamal Mostafa <kamal@canonical.com>
List-Id: linux-arch.vger.kernel.org

4.2.8-ckt9 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Romain Perier <romain.perier@free-electrons.com>

commit fba7cd681b6155e2d93e7862fcd6f970336b83c3 upstream.

The recent decoupling of pagefault disable and preempt disable added an
explicit preempt_disable/enable() pair to the futex_atomic_cmpxchg_inatomic()
implementation in asm-generic/futex.h. But it forgot to add preempt_enable()
calls to the error handling code pathes, which results in a preemption count
imbalance.

This is observable on boot when the test for atomic_cmpxchg() is calling
futex_atomic_cmpxchg_inatomic() on a NULL pointer.

Add the missing preempt_enable() calls to the error handling code pathes.

[ tglx: Massaged changelog ]

Fixes: d9b9ff8c1889 ("sched/preempt, futex: Disable preemption in UP futex_atomic_cmpxchg_inatomic() explicitly")
Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1460640963-690-1-git-send-email-romain.perier@free-electrons.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 include/asm-generic/futex.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index e56272c..bf2d34c 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -108,11 +108,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	u32 val;
 
 	preempt_disable();
-	if (unlikely(get_user(val, uaddr) != 0))
+	if (unlikely(get_user(val, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}
 
-	if (val == oldval && unlikely(put_user(newval, uaddr) != 0))
+	if (val == oldval && unlikely(put_user(newval, uaddr) != 0)) {
+		preempt_enable();
 		return -EFAULT;
+	}
 
 	*uval = val;
 	preempt_enable();
-- 
2.7.4
