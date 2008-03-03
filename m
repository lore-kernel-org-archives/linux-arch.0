From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Mon, 3 Mar 2008 13:40:50 +0100
Message-ID: <20080303124050.GA24841@uranus.ravnborg.org>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <8260.1204541852@redhat.com> <20080303114310.GA28139@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080303114310.GA28139-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux

On Mon, Mar 03, 2008 at 11:43:10AM +0000, Russell King wrote:
> On Mon, Mar 03, 2008 at 10:57:32AM +0000, David Howells wrote:
> > H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > > +#define S8_C(x)	 x
> > > +#define U8_C(x)  x ## U
> > > +#define S16_C(x) x
> > > +#define U16_C(x) x ## U
> > > +#define S32_C(x) x
> > > +#define U32_C(x) x ## U
> > > +#define S64_C(x) x ## LL
> > > +#define U64_C(x) x ## ULL
> > 
> > And #if defined(__ASSEMBLY__), just splat x through as is.
> 
> We already have something like this on ARM - include/asm-arm/memory.h
> 
> /*
>  * Allow for constants defined here to be used from assembly code
>  * by prepending the UL suffix only with actual C code compilation.
>  */
> #ifndef __ASSEMBLY__
> #define UL(x) (x##UL)
> #else
> #define UL(x) (x)
> #endif

And in linux/const.h we have yet another variant:
/* Some constant macros are used in both assembler and
 * C code.  Therefore we cannot annotate them always with
 * 'UL' and other type specifiers unilaterally.  We
 * use the following macros to deal with this.
 *
 * Similarly, _AT() will cast an expression with a type in C, but
 * leave it unchanged in asm.
 */

#ifdef __ASSEMBLY__
#define _AC(X,Y)        X
#define _AT(T,X)        X
#else
#define __AC(X,Y)       (X##Y)
#define _AC(X,Y)        __AC(X,Y)
#define _AT(T,X)        ((T)(X))
#endif

Not as typestrict as hpa's and arm's version but
used in a few placed already.

	Sam
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
