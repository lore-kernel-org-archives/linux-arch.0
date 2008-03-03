From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
Date: Mon, 03 Mar 2008 09:03:35 -0800
Message-ID: <47CC2F67.80003@zytor.com>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <8260.1204541852@redhat.com> <20080303114310.GA28139@flint.arm.linux.org.uk> <20080303124050.GA24841@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080303124050.GA24841-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Sam Ravnborg wrote:
> 
> And in linux/const.h we have yet another variant:
> /* Some constant macros are used in both assembler and
>  * C code.  Therefore we cannot annotate them always with
>  * 'UL' and other type specifiers unilaterally.  We
>  * use the following macros to deal with this.
>  *
>  * Similarly, _AT() will cast an expression with a type in C, but
>  * leave it unchanged in asm.
>  */
> 
> #ifdef __ASSEMBLY__
> #define _AC(X,Y)        X
> #define _AT(T,X)        X
> #else
> #define __AC(X,Y)       (X##Y)
> #define _AC(X,Y)        __AC(X,Y)
> #define _AT(T,X)        ((T)(X))
> #endif
> 
> Not as typestrict as hpa's and arm's version but
> used in a few placed already.
> 

These, unfortunately, don't solve the issue of gcc warnings, and you 
don't want to make them paste ULL on before the cast, since I think 
they're used with non-simple constants.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
