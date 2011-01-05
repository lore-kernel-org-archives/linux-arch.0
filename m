From: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Wed, 05 Jan 2011 16:16:48 -0500
Message-ID: <1294262208.2952.4.camel@heimdal.trondhjem.org>
References: <1294254337.16957.13.camel@mulgrave.site>
	 <AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
	 <1294256169.16957.18.camel@mulgrave.site>
	 <20110105200008.GJ8638@n2100.arm.linux.org.uk>
	 <1294259637.16957.25.camel@mulgrave.site>
	 <AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
	 <20110105210448.GM8638@n2100.arm.linux.org.uk>
	 <AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-01-05 at 13:08 -0800, Linus Torvalds wrote: 
> On Wed, Jan 5, 2011 at 1:04 PM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > On Wed, Jan 05, 2011 at 12:48:32PM -0800, Linus Torvalds wrote:
> >> (You can also force the problem with vmalloc() an then following the
> >> kernel page tables, but I hope nobody does that any more. I suspect
> >> I'm wrong, though, there's probably code that mixes vmalloc and
> >> physical page accesses in various drivers)
> >
> > Should vmalloc_to_page() (84 users)/vmalloc_to_pfn() (17 users) be
> > deprecated then? ;)
> 
> I do think that the "modern" way of doing it is
> "vmap()"/"vm_map_ram()" and friends, and it should be preferred over
> using vmalloc() and then looking up the pages.
> 
> But in the end, the two approaches really are equivalent, so it's not
> like it really matters. So I don't think we need to deprecate things
> officially, but obviously we should make people more aware of the
> whole virtual alias thing that crops up whenever you use any of these
> approaches.

So what should be the preferred way to ensure data gets flushed when
you've written directly to a page, and then want to read through the
vm_map_ram() virtual range? Should we be adding new semantics to
flush_kernel_dcache_page()?

-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org
www.netapp.com

--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
