Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:45535 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRXdJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 19:33:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:43 +0200
Message-ID: <20180918175850.4437-2-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 2/9] signal/powerpc: Remove pkey parameter from __bad_area
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918175843.MRd3JRDA92ZrQkxX3qBNFgaISkSzwJrGnU_xCmONBiA@z>

There are no callers of __bad_area that pass in a pkey parameter so it makes
no sense to take one.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 22d7f8748cd7..e5725fa96a48 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -124,8 +124,7 @@ static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long add
 	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR, 0);
 }
 
-static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code,
-			int pkey)
+static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
 {
 	struct mm_struct *mm = current->mm;
 
@@ -135,12 +134,12 @@ static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code,
 	 */
 	up_read(&mm->mmap_sem);
 
-	return __bad_area_nosemaphore(regs, address, si_code, pkey);
+	return __bad_area_nosemaphore(regs, address, si_code, 0);
 }
 
 static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 {
-	return __bad_area(regs, address, SEGV_MAPERR, 0);
+	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
 static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
@@ -151,7 +150,7 @@ static int bad_key_fault_exception(struct pt_regs *regs, unsigned long address,
 
 static noinline int bad_access(struct pt_regs *regs, unsigned long address)
 {
-	return __bad_area(regs, address, SEGV_ACCERR, 0);
+	return __bad_area(regs, address, SEGV_ACCERR);
 }
 
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
-- 
2.17.1
