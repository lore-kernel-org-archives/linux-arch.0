From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
Date: Sun, 02 Mar 2008 20:43:22 -0800
Message-ID: <47CB81EA.8070802@zytor.com>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080303023851.GF24386-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Matthew Wilcox wrote:
> On Sun, Mar 02, 2008 at 04:09:51PM -0800, H. Peter Anvin wrote:
>> first place.  C99 has macros of the form [U]INT#_C() to construct
>> numbers of an arbitrary size; this patch creates analogous macros for
>> the kernel s# and u# types.
> 
> Why put this in asm/types.h instead of, say, linux/types.h?
> 

Because that's where the s* and u* types are defined.

Realistically, those probably could/should be folded into a pair of 
asm-generic files (for 32 and 64 bits), but that is a separate change.

> I appreciate you have:
> 
>> +#define S64_C(x) x ## L
>> +#define U64_C(x) x ## UL
> 
> and:
> 
>> +#define S64_C(x) x ## LL
>> +#define U64_C(x) x ## ULL
> 
> but can't we use the latter for all arches?
> 

You really don't want to, as the whole point is that you want it to 
match what u64/s64 is defined as, in order to avoid spurious warnings.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
