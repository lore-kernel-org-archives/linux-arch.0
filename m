From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v4 9/9] x86: convert dma_map_ops to support mapping a
 __pfn_t.
Date: Tue, 9 Jun 2015 09:47:09 -0400
Message-ID: <20150609134708.GC15200@x230>
References: <20150605205052.20751.77149.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150605211955.20751.15047.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609065854.GD10167@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51279 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbbFINvQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 09:51:16 -0400
Content-Disposition: inline
In-Reply-To: <20150609065854.GD10167@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, axboe@kernel.dk, boaz@plexistor.com, david@fromorbit.com, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, arnd@arndb.de, ross.zwisler@linux.intel.com, benh@kernel.crashing.org, linux-nvdimm@ml01.01.org, heiko.carstens@de.ibm.com, tj@kernel.org, paulus@samba.org, hpa@zytor.com, schwidefsky@de.ibm.com, willy@linux.intel.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@kernel.org

On Tue, Jun 09, 2015 at 08:58:54AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 05, 2015 at 05:19:55PM -0400, Dan Williams wrote:
> > As long as a dma_map_sg() implementation avoids sg_page() conversions it
> > can support scatterlists that carry "page-less" __pfn_t entries.
> > However, a couple implementations require that __pfn_t_has_page() is
> > always true. The Xen swiotlb implementation's entanglements with ARM and
> > the Calgary MMUs requirement to have a pre-existing virtual mapping make
> > them unable to support this conversion (i.e. these now have 'depends on
> > !HAVE_DMA_PFN').
> 
> That's why we really need a whole kernel conversion and not just a piecemail
> one.  Given how trivial this patch is that doesn't look like a too big
> task ayway.

Aye, and the SWIOTLB (baremetal), Xen SWIOTLB (x86), Xen SWIOTLB (ARM)
can surely be easily tested by the Xen folks if you have patches. Please
just CC the xen-devel@lists.xenproject.org on the patches and shout
out for testing help.
