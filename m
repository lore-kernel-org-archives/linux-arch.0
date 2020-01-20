Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wr1-f73.google.com ([209.85.221.73]:51204 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgATOTw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:19:52 -0500
Received: by mail-wr1-f73.google.com with SMTP id c6so14113693wrm.18
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:19:51 -0800 (PST)
Date: Mon, 20 Jan 2020 15:19:26 +0100
In-Reply-To: <20200120141927.114373-1-elver@google.com>
Message-ID: <20200120141927.114373-4-elver@google.com>
Mime-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
Subject: [PATCH 4/5] iov_iter: Use generic instrumented.h
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: paulmck@kernel.org, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org
Message-ID: <20200120141926.-R-7gp4iObwTXqdqISQIRsqfG1m8Q7DKnYKCDF3wceg@z>

This replaces the kasan instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/iov_iter.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb29c02c6a3c..f06f6f1dd686 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -8,6 +8,7 @@
 #include <linux/splice.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
+#include <linux/instrumented.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -137,20 +138,26 @@
 
 static int copyout(void __user *to, const void *from, size_t n)
 {
+	size_t res = n;
+
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
 
 static int copyin(void *to, const void __user *from, size_t n)
 {
+	size_t res = n;
+
 	if (access_ok(from, n)) {
-		kasan_check_write(to, n);
-		n = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_pre(to, n);
+		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_post(to, n, res);
 	}
-	return n;
+	return res;
 }
 
 static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
@@ -638,11 +645,14 @@ EXPORT_SYMBOL(_copy_to_iter);
 #ifdef CONFIG_ARCH_HAS_UACCESS_MCSAFE
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
+	size_t res = n;
+
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
-		n = copy_to_user_mcsafe((__force void *) to, from, n);
+		instrument_copy_to_user_pre(from, n);
+		res = copy_to_user_mcsafe((__force void *) to, from, n);
+		instrument_copy_to_user_post(from, n, res);
 	}
-	return n;
+	return res;
 }
 
 static unsigned long memcpy_mcsafe_to_page(struct page *page, size_t offset,
-- 
2.25.0.341.g760bfbb309-goog
