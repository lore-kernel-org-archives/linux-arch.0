From: Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Mon, 3 Mar 2008 06:32:16 +0000
Message-ID: <20080303063216.GA27894@ZenIV.linux.org.uk>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org> <47CB81EA.8070802@zytor.com> <20080303062007.GY27894@ZenIV.linux.org.uk> <47CB96D5.3030509@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47CB96D5.3030509-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

On Sun, Mar 02, 2008 at 10:12:37PM -0800, H. Peter Anvin wrote:
> Al Viro wrote:
> >On Sun, Mar 02, 2008 at 08:43:22PM -0800, H. Peter Anvin wrote:
> >>>>+#define S64_C(x) x ## LL
> >>>>+#define U64_C(x) x ## ULL
> >>>but can't we use the latter for all arches?
> >>>
> >>You really don't want to, as the whole point is that you want it to 
> >>match what u64/s64 is defined as, in order to avoid spurious warnings.
> >
> >Excuse me, in which contexts?  Where does replacement of explicitly long
> >constant with explicitly long long one generate warnings on a host that has
> >range(long) equal to range(long long)?
> 
> printf, for example.

Oh, for...  It's not as if we _had_ anything better for u64 than %ull and
convert the argument to unsigned long long for that family.

Unless you are seriously suggesting the use of vomit-inducing atrocity of
PRIu64 and constant concatenation in there, that is.  I would rather move
typechecking for printk-style functions to sparse and tell gcc to STFU
completely on that class of warnings.  Making it extensible, while we are
at it - i.e. telling sparse that this conversion is to be used for dma_addr_t,
etc.
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
