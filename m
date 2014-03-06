From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 08/16] security/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:15 +0100
Message-ID: <1394121083-2507-9-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:44221 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaCFPvf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:35 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5E76A17D805A
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:52:08 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpJAG63307934
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:19 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpTSm017490
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
 security/keys/compat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/compat.c b/security/keys/compat.c
index bbd32c729dbb..347896548ad3 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -65,8 +65,8 @@ no_payload:
  * taking a 32-bit syscall are zero.  If you can, you should call sys_keyctl()
  * directly.
  */
-asmlinkage long compat_sys_keyctl(u32 option,
-				  u32 arg2, u32 arg3, u32 arg4, u32 arg5)
+COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
+		       u32, arg2, u32, arg3, u32, arg4, u32, arg5)
 {
 	switch (option) {
 	case KEYCTL_GET_KEYRING_ID:
-- 
1.8.4.5
