From: Marco Elver <elver@google.com>
Subject: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
Date: Mon, 20 Jan 2020 15:19:27 +0100
Message-ID: <20200120141927.114373-5-elver@google.com>
References: <20200120141927.114373-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f73.google.com ([209.85.221.73]:37587 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgATOTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:19:55 -0500
Received: by mail-wr1-f73.google.com with SMTP id z14so14316989wrs.4
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:19:54 -0800 (PST)
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: paulmck@kernel.org, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org

This replaces the KASAN instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
 lib/usercopy.c          | 14 ++++++++-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..d3f2d9a8cae3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <linux/kasan-checks.h>
 
 #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
 
@@ -58,18 +58,26 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	kasan_check_write(to, n);
+	unsigned long res;
+
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_pre(to, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_post(to, n, res);
+	return res;
 }
 
 /**
@@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
-	kasan_check_read(from, n);
+	unsigned long res;
+
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
-	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_pre(from, n);
+	res = raw_copy_to_user(to, from, n);
+	instrument_copy_to_user_post(from, n, res);
+	return res;
 }
 
 #ifdef INLINE_COPY_FROM_USER
@@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
 static inline __must_check unsigned long
 _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
+
 	might_fault();
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 #else
 extern __must_check unsigned long
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..1c20d4423b86 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
+#include <linux/uaccess.h>
 
 /* out-of-line parts */
 
@@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user_pre(to, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
 #ifndef INLINE_COPY_TO_USER
 unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(to, n))) {
-		kasan_check_read(from, n);
-		n = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = raw_copy_to_user(to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 EXPORT_SYMBOL(_copy_to_user);
 #endif
-- 
2.25.0.341.g760bfbb309-goog
