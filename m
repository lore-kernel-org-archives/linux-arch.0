From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
Date: Sun, 02 Mar 2008 22:12:37 -0800
Message-ID: <47CB96D5.3030509@zytor.com>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org> <47CB81EA.8070802@zytor.com> <20080303062007.GY27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080303062007.GY27894-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Al Viro wrote:
> On Sun, Mar 02, 2008 at 08:43:22PM -0800, H. Peter Anvin wrote:
>>>> +#define S64_C(x) x ## LL
>>>> +#define U64_C(x) x ## ULL
>>> but can't we use the latter for all arches?
>>>
>> You really don't want to, as the whole point is that you want it to 
>> match what u64/s64 is defined as, in order to avoid spurious warnings.
> 
> Excuse me, in which contexts?  Where does replacement of explicitly long
> constant with explicitly long long one generate warnings on a host that has
> range(long) equal to range(long long)?

printf, for example.

	-hpa
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
