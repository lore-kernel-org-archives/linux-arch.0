Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 27 Feb 2005 20:12:08 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Changing  update_mmu_cache()
Message-Id: <20050227201208.7e0a5217.davem@davemloft.net>
In-Reply-To: <20050227185537.GB32383@linux-sh.org>
References: <1109047997.5327.70.camel@gaston>
	<20050222090741.B16786@flint.arm.linux.org.uk>
	<20050222100858.27d05a86.davem@davemloft.net>
	<20050225201538.B27842@flint.arm.linux.org.uk>
	<20050225170905.4d98d934.davem@davemloft.net>
	<20050227185537.GB32383@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 27 Feb 2005 20:55:37 +0200
Paul Mundt <lethal@linux-sh.org> wrote:

> Looks good, thanks. flush_icache_user_range() needed one minor change:
 ...
>  void flush_icache_user_range(struct vm_area_struct *vma,
>  			     struct page *page, unsigned long addr, int len)
>  {
> -	__flush_cache_page(vma, addr, PHYSADDR(page_address(page)));
> +	flush_cache_page(vma, addr, page_to_pfn(page));
>  }

What are you patching against?  In the patch I sent, which are you
replying to, I made flush_icache_user_range() in this file be:

void flush_icache_user_range(struct vm_area_struct *vma,
                             struct page *page, unsigned long addr, int len)
{
        __flush_cache_page(vma, addr,
                           PHYSADDR(page_address(page)) >> PAGE_SHIFT);
}

> > I'll push this off to Linus when 2.6.12 opens up.  If folks could
> > build test this against current 2.6.x and report any failures that
> > need fixing, I would appreciate that.
> > 
> You missed fs/binfmt_elf.c, this gets it working..

Again, what the heck are you patching against?
It's definitely not the patch I posted which you are
replying to.  The tree would not have built for me
on 4 platforms with this error :-)

> On another note, for sh64 we don't need to actually keep
> sh64_dcache_purge_virt_page() around for anything after this change..
> flush_cache_page() was the only user of it anyways, so it makes more
> sense to just have it call sh64_dcache_purge_phy_page() directly.
> 
> Here's a patch for arch/sh64/mm/cache.c that you can use in-place of the
> one you have now, builds and boots.

Again, what are you patching against?  None of your patches are against
my patch at all.
