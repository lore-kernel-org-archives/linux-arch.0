Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Mar 2005 21:15:52 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Changing  update_mmu_cache()
Message-Id: <20050305211552.61f2bda6.davem@davemloft.net>
In-Reply-To: <20050228091843.GA5709@linux-sh.org>
References: <1109047997.5327.70.camel@gaston>
	<20050222090741.B16786@flint.arm.linux.org.uk>
	<20050222100858.27d05a86.davem@davemloft.net>
	<20050225201538.B27842@flint.arm.linux.org.uk>
	<20050225170905.4d98d934.davem@davemloft.net>
	<20050227185537.GB32383@linux-sh.org>
	<20050227201208.7e0a5217.davem@davemloft.net>
	<20050228091843.GA5709@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 28 Feb 2005 11:18:43 +0200
Paul Mundt <lethal@linux-sh.org> wrote:

> On Sun, Feb 27, 2005 at 08:12:08PM -0800, David S. Miller wrote:
> > What are you patching against?  In the patch I sent, which are you
> > replying to, I made flush_icache_user_range() in this file be:
> > 
> > void flush_icache_user_range(struct vm_area_struct *vma,
> >                              struct page *page, unsigned long addr, int len)
> > {
> >         __flush_cache_page(vma, addr,
> >                            PHYSADDR(page_address(page)) >> PAGE_SHIFT);
> > }
> > 
> Yes, you're right, wrong tree, sorry for the confusion. Here are the
> fixes against your patch:

Applied, thanks Paul.
