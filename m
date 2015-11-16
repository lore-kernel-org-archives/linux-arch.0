From: Benjamin Serebrin <serebrin@google.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Sun, 15 Nov 2015 22:56:12 -0800
Message-ID: <CAN+hb0WXVsrrbBNWSsa8thL30fZNrTkBQdgTdjOMYL_aSJBrhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34627 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbKPG4N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 01:56:13 -0500
Received: by wmvv187 with SMTP id v187so160553504wmv.1
        for <linux-arch@vger.kernel.org>; Sun, 15 Nov 2015 22:56:12 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc: David Miller <davem@davemloft.net>, Joerg Roedel <jroedel@suse.de>, dwmw2@infradead.org, benh@kernel.crashing.org, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, hch@lst.de, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org

We looked into Intel IOMMU performance a while ago and learned a few
useful things.  We generally did a parallel 200 thread TCP_RR test, as
this churns through mappings quickly and uses all available cores.

First, the main bottleneck was software performance[1].  This study
preceded the recent patch to break the locks into pools ("Break up
monolithic iommu table/lock into finer graularity pools and lock").
There were several points of lock contention:
- the RB tree is per device (and in the network test, there's one
device).  Every dma_map and unmap holds the lock.
- the RB tree lock is held during invalidations as well.  There's a
250-entry queue for invalidations that doesn't do any batching
intelligence (for example, promote to larger-range invalidations,
flush entire device, etc).  RB tree locks may be held while waiting
for invalidation drains.  Invalidations have even worse behavior with
ATS enabled for a given device.
- the RB tree has one entry per dma_map call (that entry is deleted by
the corresponding dma_unmap).  If we had merged all adjacent entries
when we could, we would have not lost any information that's actually
used by the code today.  (There could be a check that a dma_unmap
actually covers the entire region that was mapped, but there isn't.)
At boot (without network traffic), two common NICs' drivers show tens
of thousands of static dma_maps that never go away; this means the RB
tree is ~14-16 levels deep.  A rbtree walk (holding that big lock) has
a 14-16 level pointer chase through mostly cache-cold entries.  I
wrote a modification to the RB tree handling that merges nodes that
represent abutting IOVA ranges (and unmerges them on dma_unmap), and
the same drivers created around 7 unique entries.  Steady state grew
to a few hundreds and maybe a thousand, but the fragmentation didn't
get worse than that.  This optimization got about a third of the
performance back.

Omer's paper (https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf)
has some promising approaches.  The magazine avoids the RB tree issue.

I'm interested in seeing if the dynamic 1:1 with a mostly-lock-free
page table cleanup algorithm could do well.

There are correctness fixes and optimizations left in the invalidation
path: I want strict-ish semantics (a page doesn't go back into the
freelist until the last IOTLB/IOMMU TLB entry is invalidated) with
good performance, and that seems to imply that an additional page
reference should be gotten at dma_map time and put back at the
completion of the IOMMU flush routine.  (This is worthy of much
discussion.)

Additionally, we can find ways to optimize the flush routine by
realizing that if we have frequent maps and unmaps, it may be because
the device creates and destroys buffers a lot; these kind of workloads
use an IOVA for one event and then never come back.  Maybe TLBs don't
do much good and we could just flush the entire IOMMU TLB [and ATS
cache] for that BDF.

We'll try to get free time to do some of these things soon.

Ben


1: We verified that the IOMMU costs are almost entirely software
overheads by forcing software 1:1 mode, where we create page tables
for all physical addresses.  We tested using leaf nodes of size 4KB,
of 2MB, and of 1GB.  In call cases, there is zero runtime maintenance
of the page tables, and no IOMMU invalidations.  We did piles of DMA
maximizing x16 PCIe bandwidth on multiple lanes, to random DRAM
addresses.  At 4KB page size, we could see some bandwidth slowdown,
but at 2MB and 1GB, there was < 1% performance loss as compared with
IOMMU off.
