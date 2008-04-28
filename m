From: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Subject: [RFC PATCH] make dma_declare_coherent_memory API use cacheable
	memory
Date: Mon, 28 Apr 2008 10:51:38 -0400
Message-ID: <1209394298.3367.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This one is up for discussion because a recent change in x86:

commit 6371b495991debfd1417b17c2bc4f7d7bae05739
Author: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
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
 
