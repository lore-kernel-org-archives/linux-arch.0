From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 12:53:08 +0100
Message-ID: <20080815115308.GA24513@flint.arm.linux.org.uk>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo> <20080815021131.dfab416a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080815021131.dfab416a.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 15, 2008 at 02:11:31AM -0700, Andrew Morton wrote:
> On Fri, 15 Aug 2008 11:52:48 +0300 Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org> wrote:
> 
> > Wonder if it's possible to have the above patch applied so I can get rid
> > of those stubs in musb_io.h
> 
> Someone would need to take care of it and document it and repair all
> those driver which broke because they went and created private copies.
> 
> I could do some of that but I'm stuck at step #1.  What the heck _are_
> these things?  Why do they exist?  What are their semantics?
> 
> The arm implementation says
> 
>  * Generic IO read/write.  These perform native-endian accesses.  Note
>  * that some architectures will want to re-define __raw_{read,write}w.
> 
> which is somewhat clear as mud.  I'd guess that these are the MMIO
> partners to insl and friends?

Yes.

> And then it has
> 
> extern void __raw_writesb(void __iomem *addr, const void *data, int bytelen);
> extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
> extern void __raw_writesl(void __iomem *addr, const void *data, int longlen);
> 
> which is a bit odd.

Shrug.  Everything is not a PC.  I don't see anything odd about the above.

We basically implement a standard set of IO macros (the __raw_*) stuff
which is used to implement the standard set of IO support (inl, insl)
and provide a set of extensions for our platforms (readsl to complement
insl - named precisely the same way because that's what they are) because
the generic stuff doesn't cover all our needs.

> I assume that "bytelen" should have been "bytecount" or similar.

bytelen and bytecount mean the same thing to me.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
