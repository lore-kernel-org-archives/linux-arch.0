From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing
 commands
Date: Thu, 10 Jun 2010 17:42:48 +0100
Message-ID: <1276188168.24535.96.camel@e102109-lin.cambridge.arm.com>
References: <20100610160212.18091.29856.stgit@e102109-lin.cambridge.arm.com>
	 <4C110EDD.2010409@kernel.org>
	 <1276187002.24535.88.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45104 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752289Ab0FJQm7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Jun 2010 12:42:59 -0400
In-Reply-To: <1276187002.24535.88.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, 2010-06-10 at 17:23 +0100, Catalin Marinas wrote:
> On Thu, 2010-06-10 at 17:12 +0100, Tejun Heo wrote:
> > On 06/10/2010 06:02 PM, Catalin Marinas wrote:
> > > The data in the cmd_block buffers may reach the main memory after the
> > > writel() to the device ports. This patch introduces two calls to wmb()
> > > to ensure the relative ordering.
> > >
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Tested-by: Colin Tuckley <colin.tuckley@arm.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Jeff Garzik <jeff@garzik.org>
> >
> > I suppose you have tested and verified that this is actually
> > necessary, right? 
> 
> Yes, otherwise we get random failures with this device on ARM.
> 
> > I've been looking through the docs but couldn't
> > find anything which described the ordering between writes to main
> > memory and write[bwl]()'s.  One thing that kind of bothers me is that
> > r/wmb()'s are for ordering memory accesses among CPUs which
> > participate in cache coherency protocol and although it may work right
> > in the above case I'm not really sure whether this is the right thing
> > to do.  Do you have more information on the subject?
> 
> The mb() are not for ordering accesses among CPUs (though they would
> cover this case as well). For inter-CPU ordering, we have smp_mb() and
> friends. For all other cases, we have the mandatory barriers mb() and
> friends and DMA is one of them.
> 
> Apart from the memory-barriers.txt document, there is the Device I/O
> docbook which mentions something about DMA buffers, though not very
> clear on which barriers to use (something like just make sure that the
> writes to the buffer reached the memory).

It was actually the DMA-API.txt (rather than deviceiobook) in the
description of dma_alloc_coherent().

-- 
Catalin
