From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 07/16] mm/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:14 +0100
Message-ID: <1394121083-2507-8-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:47470 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbaCFPvd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:33 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 89B8F17D8062
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:52:07 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpIbR1311084
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:18 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpSO9017454
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:30 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Convert all compat system call functions where all parameter types
have a size of four or less than four bytes, or are pointer types
to COMPAT_SYSCALL_DEFINE.
The implicit casts within COMPAT_SYSCALL_DEFINE will perform proper
zero and sign extension to 64 bit of all parameters if needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 mm/mempolicy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ae3c8f3595d4..eeb2e3d2c962 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1556,10 +1556,10 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 
 #ifdef CONFIG_COMPAT
 
-asmlinkage long compat_sys_get_mempolicy(int __user *policy,
-				     compat_ulong_t __user *nmask,
-				     compat_ulong_t maxnode,
-				     compat_ulong_t addr, compat_ulong_t flags)
+COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
+		       compat_ulong_t __user *, nmask,
+		       compat_ulong_t, maxnode,
+		       compat_ulong_t, addr, compat_ulong_t, flags)
 {
 	long err;
 	unsigned long __user *nm = NULL;
@@ -1586,8 +1586,8 @@ asmlinkage long compat_sys_get_mempolicy(int __user *policy,
 	return err;
 }
 
-asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
-				     compat_ulong_t maxnode)
+COMPAT_SYSCALL_DEFINE3(set_mempolicy, int, mode, compat_ulong_t __user *, nmask,
+		       compat_ulong_t, maxnode)
 {
 	long err = 0;
 	unsigned long __user *nm = NULL;
@@ -1609,9 +1609,9 @@ asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
 	return sys_set_mempolicy(mode, nm, nr_bits+1);
 }
 
-asmlinkage long compat_sys_mbind(compat_ulong_t start, compat_ulong_t len,
-			     compat_ulong_t mode, compat_ulong_t __user *nmask,
-			     compat_ulong_t maxnode, compat_ulong_t flags)
+COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
+		       compat_ulong_t, mode, compat_ulong_t __user *, nmask,
+		       compat_ulong_t, maxnode, compat_ulong_t, flags)
 {
 	long err = 0;
 	unsigned long __user *nm = NULL;
-- 
1.8.4.5
