Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:46048 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934233AbYD1Ovm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Apr 2008 10:51:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 825D18443
	for <linux-arch@vger.kernel.org>; Mon, 28 Apr 2008 09:51:41 -0500 (CDT)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eusXoek+XMvs for <linux-arch@vger.kernel.org>;
	Mon, 28 Apr 2008 09:51:40 -0500 (CDT)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id CBC3D8441
	for <linux-arch@vger.kernel.org>; Mon, 28 Apr 2008 09:51:39 -0500 (CDT)
Subject: [RFC PATCH] make dma_declare_coherent_memory API use cacheable
	memory
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 10:51:38 -0400
Message-ID: <1209394298.3367.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Message-ID: <20080428145138.yfViMKEto7R2upVqqpbhsb1vjpuKbKIqm7VpuaG_Bbo@z>

This one is up for discussion because a recent change in x86:

commit 6371b495991debfd1417b17c2bc4f7d7bae05739
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jan 30 13:33:40 2008 +0100

    x86: change ioremap() to default to uncached

Changed the way the memory the x86 implementation obtains via ioremap is
cached.

Fortunately, since dma_declare_coherent_memory() is architecturally
implemented, the caching doesn't have to be the same on all
architectures.  However, its worth thinking about what the architectures
want.  For the x86 use, which is actually on a MCA bus, I want the
caching because the memory is slow to access.  It has been pointed out
to me that any similar memory behind a PCI bridge would have to be
uncached by default, so perhaps the issue is moot on newer systems.

An alternative might be to extend the API to get the user to hint
whether they want cached memory or not.

James

---

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 388b113..df83ffd 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -214,7 +214,7 @@ int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 
 	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
 
-	mem_base = ioremap(bus_addr, size);
+	mem_base = ioremap_cache(bus_addr, size);
 	if (!mem_base)
 		goto out;
 


