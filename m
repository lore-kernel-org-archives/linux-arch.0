Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:44238 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDTOkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 10:40:43 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 20 Apr 2018 09:37:55 -0500
Message-ID: <20180420143811.9994-6-ebiederm@xmission.com>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Subject: [REVIEW][PATCH 06/22] signal/microblaze: Remove the commented out force_sig_info in do_page_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Michal Simek <monstr@monstr.eu>
Message-ID: <20180420143755.m_SLrzqsGZwLfuVk5SlUtpKA2TwAxXOZG9S-s6ZoVBY@z>

Remove the commented out call to force_sig_info right after a call to
_exception in do_page_fault.  The function _exception does exactly the
work the commented out code does so there is no reason for the
commented out code.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/microblaze/mm/fault.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 43d92167012a..1251d380df47 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -268,11 +268,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
 		_exception(SIGSEGV, regs, code, address);
-/*		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = code;
-		info.si_addr = (void *) address;
-		force_sig_info(SIGSEGV, &info, current);*/
 		return;
 	}
 
-- 
2.14.1
