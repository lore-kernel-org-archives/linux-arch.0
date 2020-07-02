From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 04/21] um: host: implement os_initcalls and os_exitcalls
Date: Thu,  2 Jul 2020 23:06:58 +0900
Message-ID: <9e12b717709d74821a1432467e6800d7741e35b9.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgGBOIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC9C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d194so10149915pga.13
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:21 -0700 (PDT)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Octavian Purdila <tavi@cs.pub.ro>

From: Octavian Purdila <tavi@cs.pub.ro>

This patch implements the init and exit calls for host code. It uses
the automatic __start_<section> and __stop_<section> variables that
are defined by gcc / ld when using custom sections.

Note that this patch should be merged with "um: move arch/um/os-Linux
dir to tools/um" but for now it is separate to make the review easier.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 tools/um/uml/util.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index ecf2f390fad2..4011b36fee7e 100644
--- a/tools/um/uml/util.c
+++ b/tools/um/uml/util.c
@@ -186,3 +186,29 @@ void os_warn(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+extern void (*__start_os_exitcalls)(void);
+extern void (*__stop_os_exitcalls)(void);
+
+void os_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__stop_os_exitcalls;
+	while (--call >= &__start_os_exitcalls)
+		(*call)();
+}
+
+extern int (*__start_os_initcalls)(void);
+extern int (*__stop_os_initcalls)(void);
+
+int os_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__stop_os_initcalls;
+	while (--call >= &__start_os_initcalls)
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)
