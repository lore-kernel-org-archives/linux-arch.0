From: Marco Elver <elver@google.com>
Subject: [PATCH 6/8] instrumented.h: Introduce read-write instrumentation hooks
Date: Tue, 21 Jul 2020 12:30:14 +0200
Message-ID: <20200721103016.3287832-7-elver@google.com>
References: <20200721103016.3287832-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGUKap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63691C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t36so13943686qtc.16
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:45 -0700 (PDT)
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

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
2.28.0.rc0.105.gf9edc3c819-goog
