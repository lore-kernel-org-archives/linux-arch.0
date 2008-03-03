From: Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Mon, 3 Mar 2008 04:20:37 +0100
Message-ID: <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4a8566f54ff84f498c5c0c0340076c296b1840e6-TYXNXmPMDn57u0wkx6qpVYSLwOllVvif@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

> Although it is fully legal and correct C to write something like:
>
> 	 (u64)0x123456789abcdef
>
> .. gcc will issue a warning on 32-bit systems that 0x123456789abcdef
> is too big for an "int", and that it has been transparently promoted,
> even though it is obvious that that is what the user intended in the
> first place.

[It says it is too big for 'long', actually].

That's because this is not valid ISO C90.  GCC tries to help you out
by using the C99 rules (it has to do something, and terminating with
an error would be a bit rude).  Perhaps the kernel should use C99
mode (-std=gnu99, to get the GNU C extensions).

> +#define S8_C(x)	 x
> +#define U8_C(x)  x ## U
> +#define S16_C(x) x
> +#define U16_C(x) x ## U
> +#define S32_C(x) x
> +#define U32_C(x) x ## U

These are unnecessary, Linux requires an int to be at least 32 bits.

> +#define S64_C(x) x ## LL
> +#define U64_C(x) x ## ULL

Here you can use LL resp. ULL on all archs.


Do these new macros really buy anything over just writing LL in the
few places that 64-bit constants are used?


Segher

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
