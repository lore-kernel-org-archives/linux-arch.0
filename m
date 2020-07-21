Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgGUKai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBF8C0619DA
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s5so13499710qkj.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:38 -0700 (PDT)
Date: Tue, 21 Jul 2020 12:30:11 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-ID: <20200721103016.3287832-4-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
Subject: [PATCH 3/8] kcsan: Skew delay to be longer for certain access types
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200721103011.Xbc_rwmWXG5WyGGSdrv6YNo09zollIHAo83cSteBm1Y@z>

For compound instrumentation and assert accesses, skew the watchpoint
delay to be longer. We still shouldn't exceed the maximum delays, but it
is safe to skew the delay for these accesses.

Signed-off-by: Marco Elver <elver@google.com>
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
2.28.0.rc0.105.gf9edc3c819-goog
