From: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Date: Wed, 28 Nov 2018 16:01:10 -0700
Message-ID: <CAKocOOO2jELMaVh85m3V562ewCBDRUMJ1q_xoq7DgvUiagpTjQ@mail.gmail.com>
References: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
	<20181128174545.GJ30658@n2100.armlinux.org.uk>
	<CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
	<20181128.112717.149234960284639699.davem@davemloft.net>
	<20181128194708.GP30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181128194708.GP30658-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 28, 2018 at 12:48 PM Russell King - ARM Linux
<linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:27:17AM -0800, David Miller wrote:
> > From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> > Date: Wed, 28 Nov 2018 10:00:06 -0800
> >
> > > Not all memory is accessible even to the kernel. If you have memory
> > > that shows up in the last page of phys_addr_t, you just mark it
> > > reserved at boot-time.
> >
> > It's not the physical memory at the end that needs to be reserved.
> >
> > It's the IOMMU mapping arena.
>
> True, if and only if you have an IOMMU.
>
> Where there isn't an IOMMU, then we'd have to reserve every page that
> that translates to a bus address in the top 4K of dma_addr_t on any
> bus in the system - that means knowing early in the kernel
> initialisation about all buses in the system so we can detect and
> reserve these pages.
>

The arch and platform differences/confusion as to "what is DMA error
value" is the reason why dma_mapping_error is part dma ops. I
understand that iy would make sense to reduce the overhead of an
additional call, however, I am not sure if would be trivial change to
address this.

I was down this path of trying to address the missing mapping error
checks a few years ago and introduced dma_mapping_error checks in the
DMA DEBUG API. As you might already know that there is no common
definition for the mapping error.

Quick look at the defines shows:

#define CALGARY_MAPPING_ERROR 0
#define S390_MAPPING_ERROR  (~(dma_addr_t) 0x0)
#define SPARC_MAPPING_ERROR (~(dma_addr_t)0x0)

This is the reason why there is a arch or in some cases bus specific
mapping_error ops is needed.
We could unify this and fix all these first. I haven't looked at the
patch set closely, maybe you are already doing this.

thanks,
-- Shuah
