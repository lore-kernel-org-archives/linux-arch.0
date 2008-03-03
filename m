From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
Date: Sun, 02 Mar 2008 20:50:01 -0800
Message-ID: <47CB8379.5050203@zytor.com>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org> <200803022014.11535.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200803022014.11535.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

David Brownell wrote:
> On Sunday 02 March 2008, Segher Boessenkool wrote:
> 
>> Do these new macros really buy anything over just writing LL in the
>> few places that 64-bit constants are used?
> 
> The original workaround was to make the offending *SEC_TO_HZ_ADJ32
> constants use "ULL" suffixes.  Certainly making the Perl script emit
> those would be less intrusive.
> 

"Less intrusive" in the sense of smaller line count for this particular 
patch, perhaps, but it makes it less obvious when reading the code 
what's going on (a size override in an entirely different file). 
Additionally, I'm hoping these kind of things can be used elsewhere; the 
C99 <inttypes.h> facilities are really quite nice once you get over the 
rather ugly look of them, and I for one definitely miss having access to 
the in the kernel.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
