Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:17856 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261238AbUCAL5H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 06:57:07 -0500
Subject: Re: [RFC] Implement dma_boundary in the generic device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040229164630.GH25779@parcelfarce.linux.theplanet.co.uk>
References: <1078070182.1756.11.camel@mulgrave>
	 <20040229164630.GH25779@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1078141601.21578.90.camel@gaston>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 22:46:42 +1100
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

Ok, I have a ppc64 implementation that appear to work after a quick
test, I'll have to hammer it more tomorrow though and will send a patch.

One thing we discussed on irc but I want to raise here so we all agree
about the "limitation" and can wire it deep into the documentation:

The boundary stuff is only respected as long as the segment doesn't
start with an "offset". If I have a 64k boundary and get passed a
64k segment but which start with an "offset" in the first page, I
will _not_ break it up. Same as without iommu, I don't break
existing segments. I just prevent merging and align big segments
properly so they stay within the boundary.

Oh ... and I would still have liked (both at the struct device and
the BIO layer) a separate "max_seg_size" .... I just figured out that
stupid DBDMA controller used all over the place on Macs (though only
for CD/DVD ATA/100 and sound driver on G5s with an iommu) has a limit
of 64k ... -1 ! (0xffff is the max, 0 does NOT mean 64k shit !)

Right now, I work around that in IDE since I can allocate a larger
DMA descriptor table that the normal IDE PRD, so I allocate 512 of
them... (drivers/ide doesn't have hooks to let the low lever driver
set different queus sizes, sg list sizes, boundaries etc... I have
to mimmic the "legacy" ones).

But maybe it's not worth bothering...

Ben.
