Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:56467 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263168AbUCSATE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Mar 2004 19:19:04 -0500
Date: Fri, 19 Mar 2004 11:14:48 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: pci_map_single return value
Message-ID: <20040319001448.GP28212@krispykreme>
References: <20031212155752.GD17683@krispykreme> <20031212175104.07dc8444.ak@suse.de> <20031212192131.GF17683@krispykreme> <20031213220444.4c526afa.davem@redhat.com> <20040102120121.GT28023@krispykreme> <20040102133454.22daa451.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102133454.22daa451.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> > @@ -210,7 +222,10 @@
> >  Returns: the number of physical segments mapped (this may be shorted
> >  than <nents> passed in if the block layer determines that some
> >  elements of the scatter/gather list are physically adjacent and thus
> > -may be mapped with a single entry).
> > +may be mapped with a single entry). 
> 
> Another addition here:
> 
> Please note that the sg cannot be mapped again if it has been mapped once.
> The mapping process is allowed to destroy information in the sg.
> 
> [some drivers do this currently and it causes problems]
> 
> > +As with the other mapping interfaces, dma_map_sg can fail. When it
> > +does, 0 is returned and a driver should take appropriate action.
> 
> Please make this stronger. A block driver should definitely abort the
> request, otherwise you can kiss your super block good-bye.

Better late than never. Andrew does this look OK to you?

Anton

--

Introduce dma_error() and pci_dma_error() which is used to detect
failures in pci_map_single.

--

===== Documentation/DMA-API.txt 1.5 vs edited =====
--- 1.5/Documentation/DMA-API.txt	Thu Feb  5 01:01:19 2004
+++ edited/Documentation/DMA-API.txt	Fri Mar 19 11:09:16 2004
@@ -279,6 +279,18 @@
 cache width is.
 
 int
+dma_error(dma_addr_t dma_addr)
+
+int
+pci_dma_error(dma_addr_t dma_addr)
+
+In some circumstances dma_map_single and dma_map_page will fail to create
+a mapping. A driver can check for these errors by testing the returned
+dma address with dma_error(). A non zero return value means the mapping
+could not be created and the driver should take appropriate action (eg
+reduce current DMA mapping usage or delay and try again later).
+
+int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	   enum dma_data_direction direction)
 int
@@ -290,7 +302,16 @@
 Returns: the number of physical segments mapped (this may be shorted
 than <nents> passed in if the block layer determines that some
 elements of the scatter/gather list are physically adjacent and thus
-may be mapped with a single entry).
+may be mapped with a single entry). 
+
+Please note that the sg cannot be mapped again if it has been mapped once.
+The mapping process is allowed to destroy information in the sg.
+
+As with the other mapping interfaces, dma_map_sg can fail. When it
+does, 0 is returned and a driver must take appropriate action. It is
+critical that the driver do something, in the case of a block driver
+aborting the request or even oopsing is better than doing nothing and
+corrupting the filesystem.
 
 void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
===== Documentation/DMA-mapping.txt 1.18 vs edited =====
--- 1.18/Documentation/DMA-mapping.txt	Sun Mar 14 17:54:58 2004
+++ edited/Documentation/DMA-mapping.txt	Fri Mar 19 10:55:33 2004
@@ -519,7 +519,7 @@
 ends and the second one starts on a page boundary - in fact this is a huge
 advantage for cards which either cannot do scatter-gather or have very
 limited number of scatter-gather entries) and returns the actual number
-of sg entries it mapped them to.
+of sg entries it mapped them to. On failure 0 is returned.
 
 Then you should loop count times (note: this can be less than nents times)
 and use sg_dma_address() and sg_dma_len() macros where you previously
@@ -841,6 +841,27 @@
    deleted.
 
 2) More to come...
+
+			Handling Errors
+
+DMA address space is limited on some architectures and an allocation
+failure can be determined by:
+
+- checking if pci_alloc_consistent returns NULL or pci_map_sg returns 0
+
+- checking the returned dma_addr_t of pci_map_single and pci_map_page
+  by using pci_dma_error():
+
+	dma_addr_t dma_handle;
+
+	dma_handle = pci_map_single(dev, addr, size, direction);
+	if (pci_dma_error(dma_handle)) {
+		/*
+		 * reduce current DMA mapping usage, 
+		 * delay and try again later or 
+		 * reset driver.
+		 */
+	}
 
 			   Closing
 
===== include/asm-generic/dma-mapping.h 1.5 vs edited =====
--- 1.5/include/asm-generic/dma-mapping.h	Sun Mar 14 17:54:58 2004
+++ edited/include/asm-generic/dma-mapping.h	Fri Mar 19 10:55:33 2004
@@ -140,6 +140,12 @@
 	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
 }
 
+static inline int
+dma_error(dma_addr_t dma_addr)
+{
+	return pci_dma_error(dma_addr);
+}
+
 /* Now for the API extensions over the pci_ one */
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
===== include/asm-generic/pci-dma-compat.h 1.4 vs edited =====
--- 1.4/include/asm-generic/pci-dma-compat.h	Sun Mar 14 17:54:58 2004
+++ edited/include/asm-generic/pci-dma-compat.h	Fri Mar 19 10:55:33 2004
@@ -98,4 +98,10 @@
 	dma_sync_sg_for_device(hwdev == NULL ? NULL : &hwdev->dev, sg, nelems, (enum dma_data_direction)direction);
 }
 
+static inline int
+pci_dma_error(dma_addr_t dma_addr)
+{
+	return dma_error(dma_addr);
+}
+
 #endif
===== include/asm-i386/dma-mapping.h 1.3 vs edited =====
--- 1.3/include/asm-i386/dma-mapping.h	Sun Mar 14 17:54:58 2004
+++ edited/include/asm-i386/dma-mapping.h	Fri Mar 19 10:55:33 2004
@@ -109,6 +109,12 @@
 {
 	flush_write_buffers();
 }
+	
+static inline int
+dma_error(dma_addr_t dma_addr)
+{
+	return 0;
+}
 
 static inline int
 dma_supported(struct device *dev, u64 mask)
