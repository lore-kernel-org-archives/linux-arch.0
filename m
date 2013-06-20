From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH v5 5/7] mutex: add more tests to lib/locking-selftest.c
Date: Thu, 20 Jun 2013 13:31:30 +0200
Message-ID: <20130620113130.4001.45423.stgit@patser>
References: <20130620112811.4001.86934.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20130620112811.4001.86934.stgit@patser>
Sender: linux-media-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, rostedt@goodmis.org, daniel@ffwll.ch, tglx@linutronix.de, mingo@kernel.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

None of the ww_mutex codepaths should be taken in the 'normal'
mutex calls. The easiest way to verify this is by using the
normal mutex calls, and making sure o.ctx is unmodified.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
---
 lib/locking-selftest.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 9962262..37faefd 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1162,6 +1162,67 @@ static void ww_test_fail_acquire(void)
 #endif
 }
 
+static void ww_test_normal(void)
+{
+	int ret;
+
+	WWAI(&t);
+
+	/*
+	 * None of the ww_mutex codepaths should be taken in the 'normal'
+	 * mutex calls. The easiest way to verify this is by using the
+	 * normal mutex calls, and making sure o.ctx is unmodified.
+	 */
+
+	/* mutex_lock (and indirectly, mutex_lock_nested) */
+	o.ctx = (void *)~0UL;
+	mutex_lock(&o.base);
+	mutex_unlock(&o.base);
+	WARN_ON(o.ctx != (void *)~0UL);
+
+	/* mutex_lock_interruptible (and *_nested) */
+	o.ctx = (void *)~0UL;
+	ret = mutex_lock_interruptible(&o.base);
+	if (!ret)
+		mutex_unlock(&o.base);
+	else
+		WARN_ON(1);
+	WARN_ON(o.ctx != (void *)~0UL);
+
+	/* mutex_lock_killable (and *_nested) */
+	o.ctx = (void *)~0UL;
+	ret = mutex_lock_killable(&o.base);
+	if (!ret)
+		mutex_unlock(&o.base);
+	else
+		WARN_ON(1);
+	WARN_ON(o.ctx != (void *)~0UL);
+
+	/* trylock, succeeding */
+	o.ctx = (void *)~0UL;
+	ret = mutex_trylock(&o.base);
+	WARN_ON(!ret);
+	if (ret)
+		mutex_unlock(&o.base);
+	else
+		WARN_ON(1);
+	WARN_ON(o.ctx != (void *)~0UL);
+
+	/* trylock, failing */
+	o.ctx = (void *)~0UL;
+	mutex_lock(&o.base);
+	ret = mutex_trylock(&o.base);
+	WARN_ON(ret);
+	mutex_unlock(&o.base);
+	WARN_ON(o.ctx != (void *)~0UL);
+
+	/* nest_lock */
+	o.ctx = (void *)~0UL;
+	mutex_lock_nest_lock(&o.base, &t);
+	mutex_unlock(&o.base);
+	WARN_ON(o.ctx != (void *)~0UL);
+}
+
 static void ww_test_two_contexts(void)
 {
 	WWAI(&t);
@@ -1415,6 +1476,7 @@ static void ww_tests(void)
 
 	print_testname("ww api failures");
 	dotest(ww_test_fail_acquire, SUCCESS, LOCKTYPE_WW);
+	dotest(ww_test_normal, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_unneeded_slow, FAILURE, LOCKTYPE_WW);
 	printk("\n");
 
