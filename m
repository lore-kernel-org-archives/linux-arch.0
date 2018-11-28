From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Date: Wed, 28 Nov 2018 08:47:05 -0800
Message-ID: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
References: <20181122140320.24080-1-hch@lst.de>
	<CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
	<20181122170715.GI30658@n2100.armlinux.org.uk>
	<CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
	<11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
	<CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
	<20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181128074117.GA21126-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Linux List Kernel Mailing <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 27, 2018 at 11:41 PM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>
> On Fri, Nov 23, 2018 at 07:55:11AM +0100, Christoph Hellwig wrote:
> > Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
> > instead of the old 1 is as bool true.  The callers should all be fine,
> > although I'd have to audit them.  Still wouldn't help with being able to
> > return different errors.
>
> Any opinions?  I'd really like to make some forward progress on this
> series.

So I do think that yes, dma_mapping_error() should return an error
code, not 0/1.

But I was really hoping that the individual drivers themselves could
return error codes. Right now the patch-series has code like this:

      ret = needs_bounce(dev, dma_addr, size);
      if (ret < 0)
-         return ARM_MAPPING_ERROR;
+         return DMA_MAPPING_ERROR;

which while it all makes sense in the context of this patch-series, I
*really* think it would have been so much nicer to return the error
code 'ret' instead (which in this case is -E2BIG).

I don't think this is a huge deal, but ERR_PTR() has been hugely
successful elsewhere. And I'm not hugely convinced about all these
"any address can be valid" arguments. How the hell do you generate a
random dma address in the last page that isn't even page-aligned?

                     Linus
