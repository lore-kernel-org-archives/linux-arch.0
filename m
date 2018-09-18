Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:40030 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRXdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 19:33:14 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:44 +0200
Message-ID: <20180918175850.4437-3-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 3/9] signal/powerpc: Call _exception_pkey directly from bad_key_fault_exception
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918175844.vp24Z4N630U5pOXqcDhIDM68sMP0Tl6ge7CI7dmK1IM@z>

This removes the need for other code paths to deal with pkey exceptions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e5725fa96a48..5afc1ee55043 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -145,7 +145,17 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
 				    int pkey)
 {
-	return __bad_area_nosemaphore(regs, address, SEGV_PKUERR, pkey);
+	/*
+	 * If we are in kernel mode, bail out with a SEGV, this will
+	 * be caught by the assembly which will restore the non-volatile
+	 * registers before calling bad_page_fault()
+	 */
+	if (!user_mode(regs))
+		return SIGSEGV;
+
+	_exception_pkey(SIGSEGV, regs, SEGV_PKUERR, address, pkey);
+
+	return 0;
 }
 
 static noinline int bad_access(struct pt_regs *regs, unsigned long address)
-- 
2.17.1
