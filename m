Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42824 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1726026AbfK0G4h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Wed, 27 Nov 2019 01:56:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1]) by
 mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAR6pX56022636
 for <linux-arch@vger.kernel.org>; Wed, 27 Nov 2019 01:56:36 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99]) by
 mx0b-001b2d01.pphosted.com with ESMTP id 2whh31nh3k-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Wed, 27 Nov 2019 01:56:35 -0500
Received: from localhost by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>; Wed, 27 Nov 2019
 06:56:34 -0000
Date: Wed, 27 Nov 2019 08:56:25 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
References: <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
 <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
 <20191126164026.GA8026@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126164026.GA8026@lst.de>
Message-ID: <20191127065624.GB16913@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
Message-ID: <20191127065625.P_LPsuyeqq7xqKVOdddp_MTMB18Q97quY5ih-nggRDM@z>

On Tue, Nov 26, 2019 at 05:40:26PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 26, 2019 at 12:26:38PM +0100, Christian Zigotzky wrote:
> > Hello Christoph,
> >
> > The PCI TV card works with your patch! I was able to patch your Git kernel 
> > with the patch above.
> >
> > I haven't found any error messages in the dmesg yet.
> 
> Thanks.  Unfortunately this is a bit of a hack as we need to set
> the mask based on runtime information like the magic FSL PCIe window.
> Let me try to draft something better up, and thanks already for testing
> this one!

Maybe we'll simply force bottom up allocation before calling
swiotlb_init()? Anyway, it's the last memblock allocation.


diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 62f74b1b33bd..771e6cf7e2b9 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -286,14 +286,15 @@ void __init mem_init(void)
 	/*
 	 * book3s is limited to 16 page sizes due to encoding this in
 	 * a 4-bit field for slices.
 	 */
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);

 #ifdef CONFIG_SWIOTLB
+	memblock_set_bottom_up(true);
 	swiotlb_init(0);
 #endif

 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	set_max_mapnr(max_pfn);
 	memblock_free_all();




-- 
Sincerely yours,
Mike.
