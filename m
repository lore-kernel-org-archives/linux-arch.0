Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:39113 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262061AbUB2P4Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 29 Feb 2004 10:56:24 -0500
Subject: [RFC] Implement dma_boundary in the generic device
From: James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: multipart/mixed; boundary="=-KesX/6l46AhZsiqoGSmt"
Date: 29 Feb 2004 09:56:21 -0600
Message-Id: <1078070182.1756.11.camel@mulgrave>
Mime-Version: 1.0
To: linux-arch@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>


--=-KesX/6l46AhZsiqoGSmt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Problem:

Currently, the block layer assumes the queue dma_boundary represents a
fundamental limit of the system which the IOMMU implicitly observes (it
was really set up for the DAC 4GB boundary).  However, it can usefully
be used by devices, like IDE, that have a DMA boundary as part of their
design (For IDE, all DMA's may not cross a 64k boundary).  This would
allow the elimination of the IDE reprocessing of the sg list after
pci_map_sg.

Solution:

Add dma_boundary to the generic device so that if the driver needs to
set a limit different from the fundamental system one, it can be relayed
to the IOMMU to respect.

I've attached two patches: one is the generic implementation, which is
simple (including updating SCSI to use it), and the second is an
illustrative platform implementation of the limit in the parisc CCIO
IOMMU.  The PA implementation turns out to be quite simple, since we
have a huge IOMMU address space (1GB) and we always allocate on a power
of 2 boundary.  However, I can see implementations that simply find a
covering free region having difficulty (since you can end up with an
extra unexpected segment because of alignment), so I think the rule for
them will have to be that if the total sg length is greater than the
dma_boundary, then the transaction *must* begin aligned on the
dma_boundary.

I tested this out by artificially lowering the dma_boundary of my root
device to 8k on a parisc C360.

James


--=-KesX/6l46AhZsiqoGSmt
Content-Disposition: attachment; filename=dma_boundary_generic.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dma_boundary_generic.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D Documentation/DMA-API.txt 1.5 vs edited =3D=3D=3D=3D=3D
--- 1.5/Documentation/DMA-API.txt	Wed Feb  4 08:01:19 2004
+++ edited/Documentation/DMA-API.txt	Sun Feb 29 09:12:13 2004
@@ -410,3 +410,12 @@
 boundaries when doing this.
=20
=20
+void
+dma_set_boundary(struct device *dev, u64 boundary)
+
+Set the device boundary for a DMA transfer.  This only applies to
+platforms which can do virtual merging (i.e. have an IOMMU).  It sets
+a boundary across which a merge must not be done.   i.e. for IDE,
+which has a 64k boundary, the IOMMU may not merge two adjacent 64k
+regions into one contiguous 128k region.  This parameter represents a
+fundamental DMA transfer limit of the device.
=3D=3D=3D=3D=3D drivers/base/core.c 1.81 vs edited =3D=3D=3D=3D=3D
--- 1.81/drivers/base/core.c	Mon Feb  9 17:40:25 2004
+++ edited/drivers/base/core.c	Sat Feb 28 18:53:07 2004
@@ -195,6 +195,8 @@
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
+	/* default dma boundary to 4GB */
+	dev->dma_boundary =3D 0xFFFFFFFFULL;
 }
=20
 /**
=3D=3D=3D=3D=3D drivers/scsi/hosts.c 1.96 vs edited =3D=3D=3D=3D=3D
--- 1.96/drivers/scsi/hosts.c	Mon Dec 29 15:38:10 2003
+++ edited/drivers/scsi/hosts.c	Sun Feb 29 09:08:09 2004
@@ -111,6 +111,9 @@
 	if (!shost->shost_gendev.parent)
 		shost->shost_gendev.parent =3D dev ? dev : &platform_bus;
=20
+	if(dev)
+		dma_set_boundary(dev, shost->dma_boundary);
+
 	error =3D device_add(&shost->shost_gendev);
 	if (error)
 		goto out;
=3D=3D=3D=3D=3D include/linux/device.h 1.115 vs edited =3D=3D=3D=3D=3D
--- 1.115/include/linux/device.h	Mon Feb  9 17:40:25 2004
+++ edited/include/linux/device.h	Sat Feb 28 18:51:34 2004
@@ -285,6 +285,7 @@
 					   detached from its driver. */
=20
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	u64		dma_boundary;	/* The default dma boundary */
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
=20
 	void	(*release)(struct device * dev);
=3D=3D=3D=3D=3D include/linux/dma-mapping.h 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/include/linux/dma-mapping.h	Sat Dec 21 22:37:05 2002
+++ edited/include/linux/dma-mapping.h	Sun Feb 29 09:12:02 2004
@@ -12,6 +12,15 @@
=20
 #include <asm/dma-mapping.h>
=20
+#ifndef ARCH_HAS_DMA_SET_BOUNDARY
+static inline void
+dma_set_boundary(struct device *dev, u64 boundary)
+{
+	dev->dma_boundary =3D boundary;
+}
+#endif
+
+
 #endif
=20
=20

--=-KesX/6l46AhZsiqoGSmt
Content-Disposition: attachment; filename=dma_boundary_ccio.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dma_boundary_ccio.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D drivers/parisc/ccio-dma.c 1.15 vs edited =3D=3D=3D=3D=3D
--- 1.15/drivers/parisc/ccio-dma.c	Tue Feb  3 23:42:34 2004
+++ edited/drivers/parisc/ccio-dma.c	Sun Feb 29 09:15:55 2004
@@ -944,7 +944,8 @@
 */
=20
 static CCIO_INLINE int
-ccio_coalesce_chunks(struct ioc *ioc, struct scatterlist *startsg, int nen=
ts)
+ccio_coalesce_chunks(struct device *dev, struct ioc *ioc,
+		     struct scatterlist *startsg, int nents)
 {
 	struct scatterlist *vcontig_sg;    /* VCONTIG chunk head */
 	unsigned long vcontig_len;         /* len of VCONTIG chunk */
@@ -991,6 +992,17 @@
 				   IOVP_SIZE) > DMA_CHUNK_SIZE)
 				break;
=20
+			/* next check to see if this will coalesce
+			 * over the dma boundary.  This is very simple
+			 * for us, since all allocations begin on a
+			 * power of two boundary, just check that the
+			 * length doesn't go over the dma_boundary
+			 * mask */
+			if(dma_len + dma_offset + startsg->length > (dev->dma_boundary + 1)) {
+				printk("CCIO DMA: refusing to coalesce %lx and %lx\n", dma_len + dma_o=
ffset, dma_len + dma_offset + startsg->length);
+				break;
+			}
+
 			/*
 			** Append the next transaction?
 			*/
@@ -1082,7 +1094,7 @@
 	** w/o this association, we wouldn't have coherent DMA!
 	** Access to the virtual address is what forces a two pass algorithm.
 	*/
-	coalesced =3D ccio_coalesce_chunks(ioc, sglist, nents);
+	coalesced =3D ccio_coalesce_chunks(dev, ioc, sglist, nents);
=20
 	/*
 	** Program the I/O Pdir
@@ -1098,6 +1110,14 @@
=20
 	ASSERT(coalesced =3D=3D filled);
 	DBG_RUN_SG("%s() DONE %d mappings\n", __FUNCTION__, filled);
+
+	/* JEJB DEBUG */
+	for(nents =3D 0; nents < filled; nents++) {
+		if((sg_dma_address(&sglist[nents]) & ~dev->dma_boundary)
+		   !=3D ((sg_dma_address(&sglist[nents]) + sg_dma_len(&sglist[nents]) - =
1) & ~dev->dma_boundary))
+			printk(KERN_ERR "CCIO ERROR, sglist entry start %lx and end %lx cross d=
ma boundary %lx\n", sg_dma_address(&sglist[nents]), sg_dma_address(&sglist[=
nents]) + sg_dma_len(&sglist[nents]), dev->dma_boundary);
+	}
+			      =20
=20
 	return filled;
 }

--=-KesX/6l46AhZsiqoGSmt--
