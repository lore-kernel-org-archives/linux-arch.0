From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.5 045/200] asm-generic/futex: Re-enable preemption in futex_atomic_cmpxchg_inatomic()
Date: Mon,  2 May 2016 17:10:44 -0700
Message-ID: <20160503000556.080712447@linuxfoundation.org>
References: <20160503000554.631204776@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503000554.631204776@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Romain Perier <romain.perier@free-electrons.com>, linux-arch@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/asm-generic/futex.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -108,11 +108,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
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
