From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Sun, 2 Mar 2008 19:38:52 -0700
Message-ID: <20080303023851.GF24386@parisc-linux.org>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4a8566f54ff84f498c5c0c0340076c296b1840e6-TYXNXmPMDn57u0wkx6qpVYSLwOllVvif@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

On Sun, Mar 02, 2008 at 04:09:51PM -0800, H. Peter Anvin wrote:
> first place.  C99 has macros of the form [U]INT#_C() to construct
> numbers of an arbitrary size; this patch creates analogous macros for
> the kernel s# and u# types.

Why put this in asm/types.h instead of, say, linux/types.h?

I appreciate you have:

> +#define S64_C(x) x ## L
> +#define U64_C(x) x ## UL

and:

> +#define S64_C(x) x ## LL
> +#define U64_C(x) x ## ULL

but can't we use the latter for all arches?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
