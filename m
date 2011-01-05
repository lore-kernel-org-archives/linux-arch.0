From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Wed, 5 Jan 2011 21:04:48 +0000
Message-ID: <20110105210448.GM8638@n2100.arm.linux.org.uk>
References: <1294254337.16957.13.camel@mulgrave.site> <AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com> <1294256169.16957.18.camel@mulgrave.site> <20110105200008.GJ8638@n2100.arm.linux.org.uk> <1294259637.16957.25.camel@mulgrave.site> <AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 05, 2011 at 12:48:32PM -0800, Linus Torvalds wrote:
> (You can also force the problem with vmalloc() an then following the
> kernel page tables, but I hope nobody does that any more. I suspect
> I'm wrong, though, there's probably code that mixes vmalloc and
> physical page accesses in various drivers)

Should vmalloc_to_page() (84 users)/vmalloc_to_pfn() (17 users) be
deprecated then? ;)

However, we seem have new ways of doing this - rather than asking
vmalloc() for some memory, and then getting at the pages by following
the page tables, we now have ways to create mappings using arrays of
struct pages and access them via their already known mappings:

- vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t prot)
- map_kernel_range_noflush(unsigned long addr, unsigned long size, pgprot_t prot, struct page **pages)
- map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
- vmap(struct page **pages, unsigned int count, unsigned long flags, pgprot_t prot)

So really it's the same problem, just created by some other easier
to use methods.
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
