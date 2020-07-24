Return-Path: <SRS0=oaWr=BD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgGXHAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:38 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0DC0619E7
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t3so845346wrr.5
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
Date: Fri, 24 Jul 2020 09:00:06 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-ID: <20200724070008.1389205-7-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
Subject: [PATCH v2 6/8] instrumented.h: Introduce read-write instrumentation hooks
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200724070006.USUYyIlAyIMG9vzVXGr1gwbeZrmImp1seadrmWoo_N8@z>

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea591975..42faebbaa202 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -42,6 +42,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 	kcsan_check_write(v, size);
 }
 
+/**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  *
@@ -72,6 +87,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 	kcsan_check_atomic_write(v, size);
 }
 
+/**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
-- 
2.28.0.rc0.142.g3c755180ce-goog
