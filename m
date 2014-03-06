From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 16/16] s390/compat: build error for large compat syscall args
Date: Thu,  6 Mar 2014 16:51:23 +0100
Message-ID: <1394121083-2507-17-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114]:50509 "EHLO
	e06smtp18.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaCFPvj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:39 -0500
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:38 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E0E12190041
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:32 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpOJc54329358
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:24 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpYGh017761
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:35 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Enforce 32 bit types for all compat syscall argument types.

This way we can make sure that all arguments get correct sign
or zero extension. Otherwise incorrect code would be generated.

E.g. for a 'long' type the COMPAT_SYSCALL_DEFINE macro wouldn't
generate code that would cause sign extension of the passed in 32
bit user space parameter.
This can cause quite subtle bugs like e.g. the one that was fixed
with dfd948e32af2e "fs/compat: fix parameter handling for compat
readv/writev syscalls".

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/compat.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 5d7e8cf83bd6..d350ed9d0fbb 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -8,7 +8,11 @@
 #include <linux/thread_info.h>
 
 #define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p(typeof(0?(t)0:0ULL), u64))
-#define __SC_DELOUSE(t,v) (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v))
+
+#define __SC_DELOUSE(t,v) ({ \
+	BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
+	(t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
+})
 
 #define PSW32_MASK_PER		0x40000000UL
 #define PSW32_MASK_DAT		0x04000000UL
-- 
1.8.4.5
