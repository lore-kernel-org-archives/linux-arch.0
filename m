From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH v5 7/7] locking-selftests: handle unexpected failures more
 strictly
Date: Thu, 20 Jun 2013 13:31:51 +0200
Message-ID: <20130620113151.4001.77963.stgit@patser>
References: <20130620112811.4001.86934.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130620112811.4001.86934.stgit@patser>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, rostedt@goodmis.org, daniel@ffwll.ch, tglx@linutronix.de, mingo@kernel.org, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When CONFIG_PROVE_LOCKING is not enabled, more tests are expected to
pass unexpectedly, but there no tests that should start to fail that
pass with CONFIG_PROVE_LOCKING enabled.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
---
 lib/locking-selftest.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index d554f3f..aad024d 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -976,16 +976,18 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	/*
 	 * Filter out expected failures:
 	 */
-	if (debug_locks != expected) {
 #ifndef CONFIG_PROVE_LOCKING
+	if (expected == FAILURE && debug_locks) {
 		expected_testcase_failures++;
 		printk("failed|");
-#else
+	}
+	else
+#endif
+	if (debug_locks != expected) {
 		unexpected_testcase_failures++;
 		printk("FAILED|");
 
 		dump_stack();
-#endif
 	} else {
 		testcase_successes++;
 		printk("  ok  |");
