From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 30 Nov 2018 11:53:46 +0100
Message-ID: <20181130105346.GB26765@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de> <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-arch.vger.kernel.org

Hi Christian,

for such a diverse architecture like powerpc we'll have to rely on
users / non core developers like you to help with testing.

Can you try the patch below for he cyrus config?

For the nemo one I have no idea yet, there is no chance I could trick
you into a git bisect to see which patch caused the problem, is there?


diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 7b70dcbce1b9..2f0ca6560e47 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -47,7 +47,7 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
+	void		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index bded4127791a..2587eb0f3fde 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -22,11 +22,10 @@
 #include <asm/swiotlb.h>
 #include <asm/dma.h>
 
-bool arch_dma_set_mask(struct device *dev, u64 dma_mask)
+void arch_dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!ppc_md.dma_set_mask)
-		return 0;
-	return ppc_md.dma_set_mask(dev, dma_mask);
+	if (ppc_md.dma_set_mask)
+		ppc_md.dma_set_mask(dev, dma_mask);
 }
 EXPORT_SYMBOL(arch_dma_set_mask);
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9584765dbe3b..8582a418516b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -134,7 +134,7 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
 static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
 #endif
 
-static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
+static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	/*
 	 * Fix up PCI devices that are able to DMA to the large inbound
@@ -144,8 +144,6 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 		dev->bus_dma_mask = 0;
 		dev->archdata.dma_offset = pci64_dma_offset;
 	}
-
-	return 0;
 }
 
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8dd19e66c0e5..94a4db5f7ec3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -599,17 +599,16 @@ static inline int dma_supported(struct device *dev, u64 mask)
 }
 
 #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
-bool arch_dma_set_mask(struct device *dev, u64 mask);
+void arch_dma_set_mask(struct device *dev, u64 mask);
 #else
-#define arch_dma_set_mask(dev, mask)		true
+#define arch_dma_set_mask(dev, mask)	do { } while (0)
 #endif
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
-	if (!arch_dma_set_mask(dev, mask))
-		return -EIO;
+	arch_dma_set_mask(dev, mask);
 	dma_check_mask(dev, mask);
 
 	*dev->dma_mask = mask;
