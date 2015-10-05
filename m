Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50059 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbJEJ6h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2015 05:58:37 -0400
From: Manjeet Pawar <manjeet.p@samsung.com>
Subject: [PATCH] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
Date: Mon, 05 Oct 2015 15:26:09 +0530
Message-ID: <1444038969-14112-1-git-send-email-manjeet.p@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, Manjeet Pawar <manjeet.p@samsung.com>, Akhilesh Kumar <akhilesh.k@samsung.com>, Rohit Thapliyal <r.thapliyal@samsung.com>
Message-ID: <20151005095609.qCv9WJzlHPglDdaWAn6sPoMKxJGrT0oN4yWLlRq6qI0@z>

MINSIGSTKSZ and SIGSTKSZ for ARM64 are not correctly set in latest kernel.
This patch fixes this issue.

This issue is reported in LTP (testcase: sigaltstack02.c).
Testcase failed when sigaltstack() called with stack size "MINSIGSTKSZ - 1"
Since in Glibc-2.22, MINSIGSTKSZ is set to 5120 but in kernel
it is set to 2048 so testcase gets failed.

Testcase Output:
sigaltstack02 1  TPASS  :  stgaltstack() fails, Invalid Flag value,errno:22
sigaltstack02 2  TFAIL  :  sigaltstack() returned 0, expected -1,errno:12

Reported Issue in Glibc Bugzilla:
https://sourceware.org/bugzilla/show_bug.cgi?id=16850

Bugfix in Glibc-2.22:
https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=blob;f=sysdeps/unix/
sysv/linux/aarch64/bits/sigstack.h;h=8f2fb76e3e81734ef8a9cf9ae40daf4705
f31c35;hb=b763f6ae859ecea70a5dacb8ad45c71d5f667e2e

Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
---
 include/uapi/asm-generic/signal.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 9df61f1..2ffbe38 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -80,8 +80,13 @@
  *	SA_RESTORER	0x04000000
  */
 
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
+#ifdef CONFIG_ARM64
+#define MINSIGSTKSZ 5120
+#define SIGSTKSZ    16384
+#else
+#define MINSIGSTKSZ 2048
+#define SIGSTKSZ    8192
+#endif
 
 #ifndef __ASSEMBLY__
 typedef struct {
-- 
1.7.1

