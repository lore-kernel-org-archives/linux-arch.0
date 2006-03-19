Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:23520 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750925AbWCSXkK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 18:40:10 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060319.140124.69326977.davem@davemloft.net>
References: <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	 <20060319.132511.116548328.davem@davemloft.net>
	 <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
	 <20060319.140124.69326977.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 17:39:36 -0600
Message-Id: <1142811577.3240.75.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 14:01 -0800, David S. Miller wrote:
> I don't dispute how the parisc cache behaves, you know that better
> than me, but I do want to know what in the world does the size of the
> cache have to do with deciding whether to design the hardware to flush
> all the matching lines or not?

> It's a CAM lookup on bus snoop.  That can search all physical tags in
> one CAM cycle, which will thus set the invalid bit on all matching
> cache lines regardless of virtual index.

Well ... CAM designs are really only appropriate to highly associative
cache designs, which the parisc cache isn't.  I just mentioned the size
because the cache size divided by the page size and divided by the
associativity gives a significantly large number in the PA cache, which
is what makes implementing a CAM design for it hard (or actually not
realistic).

> How is a virtual address getting into this equation at all?  The IOMMU
> sits on some other bus agent such as the PCI controller, right?  So
> coherency transactions, even if translated by the IOMMU from a PCI bus
> virtual address to a physical main memory address, looks like a
> physical address cache transation to the cpu caches on a bus snoop.

as part of the IOMMU set up and tear down in dma_map/unmap_sg require
this thing called a coherence index for each page; we simply work it out
from the kernel virtual address.  This is basically just a disguised
virtual index of the cache, but it's required for each iotlb entry.
When the IOMMU participates in the coherence protocol, it places the
coherence index as well as the physical address on the bus so the CPUs
know which lines to flush.

> What am I missing?

Nothing; it's always irked me that we need all these extra coherence
protocols for the PA VIPT cache because it's so large with such low
associativity.  But it also makes us a good test case for the linux
API ...

James


