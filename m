From: Marco Elver <elver@google.com>
Subject: [PATCH v2 3/8] kcsan: Skew delay to be longer for certain access types
Date: Fri, 24 Jul 2020 09:00:03 +0200
Message-ID: <20200724070008.1389205-4-elver@google.com>
References: <20200724070008.1389205-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

For compound instrumentation and assert accesses, skew the watchpoint
delay to be longer if randomized. This is useful to improve race
detection for such accesses.

For compound accesses we should increase the delay as we've aggregated
both read and write instrumentation. By giving up 1 call into the
runtime, we're less likely to set up a watchpoint and thus less likely
to detect a race. We can balance this by increasing the watchpoint
delay.

For assert accesses, we know these are of increased interest, and we
wish to increase our chances of detecting races for such checks.

Note that, kcsan_udelay_{task,interrupt} define the upper bound delays.
When randomized, delays are uniformly distributed between [0, delay].
Skewing the delay does not break this promise as long as the defined
upper bounds are still adhered to. The current skew results in delays
uniformly distributed between [delay/2, delay].

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Commit message rewording.
---
 kernel/kcsan/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index fb52de2facf3..4633baebf84e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -283,11 +283,15 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(void)
+static inline unsigned int get_delay(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
+	/* For certain access types, skew the random delay to be longer. */
+	unsigned int skew_delay_order =
+		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
+
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay) :
+				prandom_u32_max(delay >> skew_delay_order) :
 				0);
 }
 
@@ -449,7 +453,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay());
+	udelay(get_delay(type));
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
-- 
2.28.0.rc0.142.g3c755180ce-goog
