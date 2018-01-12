From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/2] mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
Date: Fri, 12 Jan 2018 14:31:34 -0600
Message-ID: <20180112203135.4669-1-ebiederm@xmission.com>
References: <87vag6zupo.fsf@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:41719 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeALUcw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 15:32:52 -0500
In-Reply-To: <87vag6zupo.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Masakazu Urade <urade.masakazu@jp.panasonic.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>

Setting si_code to 0 is the same a setting si_code to SI_USER which is definitely
not correct.  With si_code set to SI_USER si_pid and si_uid will be copied to
userspace instead of si_addr.  Which is very wrong.

So fix this by using a sensible si_code (SEGV_MAPERR) for this failure.

Cc: stable@vger.kernel.org
Fixes: b920de1b77b7 ("mn10300: add the MN10300/AM33 architecture to the kernel")
Cc: David Howells <dhowells@redhat.com>
Cc: Masakazu Urade <urade.masakazu@jp.panasonic.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mn10300/mm/misalignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mn10300/mm/misalignment.c b/arch/mn10300/mm/misalignment.c
index b39a388825ae..8ace89617c1c 100644
--- a/arch/mn10300/mm/misalignment.c
+++ b/arch/mn10300/mm/misalignment.c
@@ -437,7 +437,7 @@ asmlinkage void misalignment(struct pt_regs *regs, enum exception_code code)
 
 	info.si_signo	= SIGSEGV;
 	info.si_errno	= 0;
-	info.si_code	= 0;
+	info.si_code	= SEGV_MAPERR;
 	info.si_addr	= (void *) regs->pc;
 	force_sig_info(SIGSEGV, &info, current);
 	return;
-- 
2.14.1
