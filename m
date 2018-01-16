From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/22] signal: Document all of the signals that use the _sigfault union member
Date: Mon, 15 Jan 2018 18:39:48 -0600
Message-ID: <20180116004009.31036-1-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46414 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPAla (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:41:30 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index e447283b8f52..cbe1b0cc7a6a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -85,7 +85,7 @@ typedef struct siginfo {
 			__ARCH_SI_CLOCK_T _stime;
 		} _sigchld;
 
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 		struct {
 			void __user *_addr; /* faulting insn/memory ref. */
 #ifdef __ARCH_SI_TRAPNO
-- 
2.14.1
