Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:43092 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767542AbXECRiu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2007 13:38:50 -0400
Received: from localhost.localdomain ([127.0.0.1]:17578 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021924AbXECRiu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 May 2007 18:38:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l43HcgNV011146
	for <linux-arch@vger.kernel.org>; Thu, 3 May 2007 18:38:42 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l43HcgYH011145
	for linux-arch@vger.kernel.org; Thu, 3 May 2007 18:38:42 +0100
Date: Thu, 3 May 2007 18:38:42 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: gcc generating calls to __udivdi3
Message-ID: <20070503173842.GC10249@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Forwarding this to linux-arch mostly as a heads up to other arch maintainers
and discussion.  With gcc's optimizer getting increasingly smarter I'm not
so sure if below patch is the right thing.  In timespec_add_ns we would
normally except the loop to be interated once at most and gcc should make
this assumption due to the unlikely() hint.  Anyway, we have to be
prepared for more such code transformations to happen so adding a __udivdi3
implementation is probably the defensive approach.

  Ralf

From:	Thiemo Seufer <ths@networkno.de>
Date:	Tue, 1 May 2007 19:11:21 +0100
Subject: [PATCH] Use do_div for a subtract loop

Hello All,

this patch switches the subtract loop in timespec_add_ns to use
do_div. The latest GCC SVN version grew intelligent enough to
optimize the loop to a division which calls libgcc's __udivdi3,
which breaks kernel builds.

Tested by building and booting a little endian qemu MIPS kernel.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/linux/time.h b/include/linux/time.h
index 8ea8dea..e1a11d7 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 # include <linux/seqlock.h>
+# include <asm/div64.h>
 #endif
 
 #ifndef _STRUCT_TIMESPEC
@@ -169,9 +170,10 @@ extern struct timeval ns_to_timeval(const s64 nsec);
 static inline void timespec_add_ns(struct timespec *a, u64 ns)
 {
 	ns += a->tv_nsec;
-	while(unlikely(ns >= NSEC_PER_SEC)) {
-		ns -= NSEC_PER_SEC;
-		a->tv_sec++;
+	if(unlikely(ns >= NSEC_PER_SEC)) {
+		u64 tmp = ns;
+		ns = do_div(tmp, NSEC_PER_SEC);
+		a->tv_sec += tmp;
 	}
 	a->tv_nsec = ns;
 }

