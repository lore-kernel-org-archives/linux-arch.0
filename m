From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
Date: Sun, 02 Mar 2008 22:28:07 -0800
Message-ID: <47CB9A77.60708@zytor.com>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org> <47CB81EA.8070802@zytor.com> <20080303062007.GY27894@ZenIV.linux.org.uk> <47CB96D5.3030509@zytor.com> <20080303063216.GA27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080303063216.GA27894-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Al Viro wrote:
> 
> Oh, for...  It's not as if we _had_ anything better for u64 than %ull and
> convert the argument to unsigned long long for that family.
> 
> Unless you are seriously suggesting the use of vomit-inducing atrocity of
> PRIu64 and constant concatenation in there, that is.  I would rather move
> typechecking for printk-style functions to sparse and tell gcc to STFU
> completely on that class of warnings.  Making it extensible, while we are
> at it - i.e. telling sparse that this conversion is to be used for dma_addr_t,
> etc.

No, I'm not suggesting that.  I'd rather have the Windoze extension of 
%I64u, which of course gcc doesn't recognize.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
