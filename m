From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 08/15] mips: switch to generic version of pte allocation
Date: Sun, 5 May 2019 09:17:37 +0300
Message-ID: <20190505061737.GD15755@rapoport-lnx>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-9-git-send-email-rppt@linux.ibm.com>
 <20190502190945.rrrxfxo3rbhgc3cx@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502190945.rrrxfxo3rbhgc3cx@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, linux-arch@vger.ke
List-Id: linux-arch.vger.kernel.org

On Thu, May 02, 2019 at 07:09:47PM +0000, Paul Burton wrote:
> Hi Mike,
> 
> On Thu, May 02, 2019 at 06:28:35PM +0300, Mike Rapoport wrote:
> > MIPS allocates kernel PTE pages with
> > 
> > 	__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)
> > 
> > and user PTE pages with
> > 
> > 	alloc_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)
> 
> That bit isn't quite true - we don't use __GFP_ZERO in pte_alloc_one() &
> instead call clear_highpage() on the allocated page. Not that I have a
> problem with using __GFP_ZERO - it seems like the more optimal choice.
> It just might be worth mentioning the change & expected equivalent
> behavior.

You are right, I'll fix the changelog.
 
> Otherwise:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>

Thanks.

> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.
