From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 02/16] compat: add COMPAT_SYSCALL_DEFINE0 macro
Date: Thu,  6 Mar 2014 16:51:09 +0100
Message-ID: <1394121083-2507-3-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:33368 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaCFPvd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:33 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3B3B1B08040
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:12 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpGAH49938500
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:16 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpQFl017340
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:27 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

For consistency reason add a COMPAT_SYSCALL_DEFINE0 macro.
This macro should be used for compat system calls with zero parameters.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/compat.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index beded18f992d..4c42df3fce37 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -27,6 +27,9 @@
 #define __SC_DELOUSE(t,v) ((t)(unsigned long)(v))
 #endif
 
+#define COMPAT_SYSCALL_DEFINE0(name) \
+	asmlinkage long compat_sys_##name(void)
+
 #define COMPAT_SYSCALL_DEFINE1(name, ...) \
         COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
 #define COMPAT_SYSCALL_DEFINE2(name, ...) \
-- 
1.8.4.5
