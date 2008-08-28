From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Export kmap_atomic_pfn for DRM-GEM.
Date: Thu, 28 Aug 2008 10:22:14 +1000
Message-ID: <200808281022.14296.nickpiggin@yahoo.com.au>
References: <1219779789-8368-1-git-send-email-eric@anholt.net> <200808272336.05736.nickpiggin@yahoo.com.au> <1219855961.4994.6.camel@vonnegut.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:39773 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752786AbYH1AWW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Aug 2008 20:22:22 -0400
In-Reply-To: <1219855961.4994.6.camel@vonnegut.anholt.net>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Anholt <eric@anholt.net>
Cc: Dave Airlie <airlied@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 28 August 2008 02:52, Eric Anholt wrote:
> On Wed, 2008-08-27 at 23:36 +1000, Nick Piggin wrote:
> > On Wednesday 27 August 2008 05:43, Eric Anholt wrote:
> > > The driver would like to map IO space directly for copying data in when
> > > appropriate, to avoid CPU cache flushing for streaming writes.
> > > kmap_atomic_pfn lets us avoid IPIs associated with ioremap for this
> > > process.
> > >
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > ---
> > >  arch/x86/mm/highmem_32.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/highmem_32.c b/arch/x86/mm/highmem_32.c
> > > index 165c871..d52e91d 100644
> > > --- a/arch/x86/mm/highmem_32.c
> > > +++ b/arch/x86/mm/highmem_32.c
> > > @@ -137,6 +137,7 @@ void *kmap_atomic_pfn(unsigned long pfn, enum
> > > km_type type)
> > >
> > >  	return (void*) vaddr;
> > >  }
> > > +EXPORT_SYMBOL(kmap_atomic_pfn);
> > >
> > >  struct page *kmap_atomic_to_page(void *ptr)
> > >  {
> >
> > I wonder if you ever tested my vmap rework patches with this issue? It
> > seems somewhat x86 specific and also not conceptually so clean to use
> > kmap_atomic_pfn for this. vmap may not be used by all architectures but
> > I think it might be able to cover some of them.
> >
> > As I said, there are some other possible improvements that can be made
> > to my vmap rewrite if performance isn't good enough, but I simply have
> > not seen numbers...
>
> The consumer of this is a driver for Intel platforms, so being
> x86-specific is not a worry this patch series.

It would help verify and improve the new vmap code, and it would be
"doing the right thing" to begin with. It would avoid some nasty
ifdefery in your driver too. And what about 64 bit x86 that doesn't
have kmap_atomic_pfn? Or x86 builds without highmem?


> However, when other DRM drivers get around to doing memory management,
> I'm sure they'll also be interested in an ioremap_wc that doesn't eat
> ipi costs.  For us, the ipis for flushing were eating over 10% of CPU
> time.  If your patch series cuts that cost, we could drop this piece at
> that point.

It can cut the cost quite significantly on normal vmap/vunmap loads I
tested. Whether it will work as well on your workload, I don't know
but I would have liked to find out. I raised this issue quite a while
back, so I'm disappointed it had not been tried...
