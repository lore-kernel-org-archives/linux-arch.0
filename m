From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] swiotlb: enlarge iotlb buffer on demand
Date: Sun, 1 Aug 2010 12:03:11 +0900
Message-ID: <20100801120224F.fujita.tomonori@lab.ntt.co.jp>
References: <20100731003643E.fujita.tomonori@lab.ntt.co.jp>
	<20100730202724.GA920@andromeda.dapyr.net>
	<20100731010706.GA30319@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:33798 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab0HADHu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 31 Jul 2010 23:07:50 -0400
In-Reply-To: <20100731010706.GA30319@andromeda.dapyr.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: konrad@kernel.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, konrad.wilk@oracle.com, akataria@vmware.com

On Fri, 30 Jul 2010 21:07:06 -0400
Konrad Rzeszutek Wilk <konrad@kernel.org> wrote:

> I took your patch and was trying to fit it over the
> stable/swiotlb-0.8.4 branch and when I did so a found couple of things..
> 
> 
> > > @@ -215,14 +222,14 @@ swiotlb_late_init_with_default_size(size_t default_size)
> > >  	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> 
> You should also initialize the __io_tlb_start array first:

Yeah, I know. As I wrote, this patchset breaks IA64.

I really merge to swiotlb's two memory allocator mechanisms
(swiotlb_init_with_default_size and
swiotlb_late_init_with_default_size). I need to look at the x86 memory
boot code after memblock surgery finishes.

And as you know, I've not fixed the error path and swiotlb_free. I'll
do later if people are not against swiotlb dynamic allocation.

Thanks,
