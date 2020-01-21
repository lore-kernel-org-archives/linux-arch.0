Return-Path: <SRS0=zjVl=3K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wm1-f73.google.com ([209.85.128.73]:33370 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgAUQFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 11:05:37 -0500
Received: by mail-wm1-f73.google.com with SMTP id l11so844463wmi.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 08:05:36 -0800 (PST)
Date: Tue, 21 Jan 2020 17:05:11 +0100
In-Reply-To: <20200121160512.70887-1-elver@google.com>
Message-ID: <20200121160512.70887-4-elver@google.com>
Mime-Version: 1.0
References: <20200121160512.70887-1-elver@google.com>
Subject: [PATCH v2 4/5] iov_iter: Use generic instrumented.h
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: paulmck@kernel.org, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, dja@axtens.net, christophe.leroy@c-s.fr, mpe@ellerman.id.au, mhiramat@kernel.org, rostedt@goodmis.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, keescook@chromium.org, cyphar@cyphar.com, linux-arch@vger.kernel.org
Message-ID: <20200121160511.41S-soHQQmQ4SiB8j8m59jgKoVaDGq0zRO8z8gVJMe8@z>

This replaces the kasan instrumentation with generic instrumentation,
implicitly adding KCSAN instrumentation support.

For KASAN no functional change is intended.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use updated instrumented.h, removing post-hooks for user-copies.
---
 lib/iov_iter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb29c02c6a3c..614b6999d2da 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -8,6 +8,7 @@
 #include <linux/splice.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
+#include <linux/instrumented.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -138,7 +139,7 @@
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
@@ -147,7 +148,7 @@ static int copyout(void __user *to, const void *from, size_t n)
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (access_ok(from, n)) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		n = raw_copy_from_user(to, from, n);
 	}
 	return n;
@@ -639,7 +640,7 @@ EXPORT_SYMBOL(_copy_to_iter);
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = copy_to_user_mcsafe((__force void *) to, from, n);
 	}
 	return n;
-- 
2.25.0.341.g760bfbb309-goog
