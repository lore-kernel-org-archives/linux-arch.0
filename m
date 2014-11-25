Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:36860 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbaKYLnk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Nov 2014 06:43:40 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 11:43:38 -0000
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [RFC 1/2] powerpc/fsl-pci: atomic get_user when pagefault_disabled
Date: Tue, 25 Nov 2014 12:43:25 +0100
Message-ID: <1416915806-24757-2-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, dahi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <20141125114325.M0LqJK6F9LhusWEBXoJGhYN3fZ8ETJa_sa7ANAk5OpE@z>

Whenever we have pagefaults disabled, we have to use the atomic variants of
(set|get)_user and copy_(from|to)_user.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 65d2ed4..c0af4ef 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1025,7 +1025,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 	if (is_in_pci_mem_space(addr)) {
 		if (user_mode(regs)) {
 			pagefault_disable();
-			ret = get_user(regs->nip, &inst);
+			ret = __get_user_inatomic(regs->nip, &inst);
 			pagefault_enable();
 		} else {
 			ret = probe_kernel_address(regs->nip, inst);
-- 
1.8.5.5

