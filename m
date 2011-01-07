From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: still nfs problems [Was: Linux 2.6.37-rc8]
Date: Fri, 7 Jan 2011 19:02:29 +0000
Message-ID: <20110107190229.GX31708@n2100.arm.linux.org.uk>
References: <20110105210448.GM8638@n2100.arm.linux.org.uk> <AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com> <1294262208.2952.4.camel@heimdal.trondhjem.org> <AANLkTi=3Gu-rz=-OdNtUXn4qw60Df6=YePnzvB=s-+Ov@mail.gmail.com> <1294268808.2952.18.camel@heimdal.trondhjem.org> <1294270104.16957.73.camel@mulgrave.site> <1294335614.22825.154.camel@mulgrave.site> <1294336054.2905.1.camel@heimdal.trondhjem.org> <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com> <1294426405.2929.23.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294426405.2929.23.camel-rJ7iovZKK19ZJLDQqaL3InhyD016LWXt@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marc Kleine-Budde <m.kleine-budde-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 07, 2011 at 01:53:25PM -0500, Trond Myklebust wrote:
> I'd still like to keep the existing code for those architectures that
> don't have problems, since that allows us to send 32k READDIR requests
> instead of being limited to 4k. For large directories, that is a clear
> win.
> For the NOMMU case we will just go back to using a single page for
> storage (and 4k READDIR requests only). Should I just do the same for
> architectures like ARM and PARISC?

I think you said that readdir reads via the vmalloc mapping of the
group of pages, but XDR writes to the individual pages.

As I understand NFS, you receive a packet, you then have to use XDR
to unpack the data, which you presumably write into the set of
struct page *'s using kmap?

Isn't a solution to have XDR write directly into the vmalloc mapping
rather than using struct page * and kmap?
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
