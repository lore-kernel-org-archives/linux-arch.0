From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Wed, 5 Jan 2011 20:00:08 +0000
Message-ID: <20110105200008.GJ8638@n2100.arm.linux.org.uk>
References: <1294254337.16957.13.camel@mulgrave.site> <AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com> <1294256169.16957.18.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294256169.16957.18.camel-0iu6Cu4xQGLYCGPCin2YbQ@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 05, 2011 at 01:36:09PM -0600, James Bottomley wrote:
> On Wed, 2011-01-05 at 11:18 -0800, Linus Torvalds wrote:
> > On Wed, Jan 5, 2011 at 11:05 AM, James Bottomley
> > <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org> wrote:
> > >
> > > I think the solution for the kernel direct mapping problem is to take
> > > the expected flushes and invalidates into kmap/kunmap[_atomic].
> > 
> > No, we really can't do that. Most of the time, the kmap() is the only
> > way we access the page anyway, so flushing things would just be
> > stupid. Why waste time and energy on doing something pointless?
> 
> It's hardly pointless.  The kmap sets up an inequivalent alias in the
> cache.

No it doesn't.  For pages which are inaccessible, it sets up a mapping
for those pages.  On aliasing cache architectures, when you tear down
such a mapping, you have to flush the cache before you do so (otherwise
you can end up with cache lines existing in the cache for inaccessible
mappings.)

For lowmem pages, kmap() (should always) bypass the 'setup mapping' stage
because all lowmem pages are already accessible.  So kunmap() doesn't
do anything - just like the !HIGHMEM implementation for these macros.

So, for highmem-enabled systems:

	low_addr = kmap_atomic(lowmem_page);
	high_addr = kmap_atomic(highmem_page);

results in low_addr in the kernel direct-mapped region, and high_addr
in the kmap_atomic region.
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
