From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
Date: Thu, 19 Nov 2015 17:35:14 +0100
Message-ID: <4559060.7YuVHsgd4d@wuerfel>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl> <5663971.11WtULN11Y@wuerfel> <20151119161843.GA8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119161843.GA8644@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Chen Gang <xili_gchen_5257@hotmail.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "jonas@southpole.se" <jonas@southpole.se>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 19 November 2015 16:18:43 Russell King - ARM Linux wrote:
> On Thu, Nov 19, 2015 at 12:25:45PM +0100, Arnd Bergmann wrote:
> > On Thursday 19 November 2015 03:40:25 Chen Gang wrote:
> > > diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> > > index 37d1fe2..67cfb7d 100644
> > > --- a/include/asm-generic/page.h
> > > +++ b/include/asm-generic/page.h
> > > @@ -24,9 +24,6 @@
> > >  
> > >  #ifndef __ASSEMBLY__
> > >  
> > > -#define get_user_page(vaddr)           __get_free_page(GFP_KERNEL)
> > > -#define free_user_page(page, addr)     free_page(addr)
> > > -
> > >  #define clear_page(page)       memset((page), 0, PAGE_SIZE)
> > >  #define copy_page(to,from)     memcpy((to), (from), PAGE_SIZE)
> > >  
> > > 
> > 
> > Looks good. I can take the asm-generic portion when you split it up, and
> > I can also help you merge the remaining patches in case some of
> > the arch maintainers fail to pick them up. I think all five of them
> > are actively maintained though, so the patches should just go through
> > the respective architecture trees.
> 
> Or we just ack the patch and have it go through one tree, which I think
> is the most sensible.  I can't imagine that there would be any major
> conflicts here, surely no one is constantly changing their asm/page.h ?

Yes, good point, there is really very little potential for conflicts
here. I've applied it into my asm-generic tree for now, but will
revert it if we get regressions or NAKs.

For some reason, the patch was whitespace broken, but I managed to
extract it from the attachment.

	Arnd
