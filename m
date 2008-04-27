From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/24] Unify integer type definitions, and add fixed type
 constructor macros
Date: Sun, 27 Apr 2008 10:44:53 -0700
Message-ID: <4814BB95.8090808@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <200804251015.32157.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804251015.32157.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Arnd Bergmann wrote:
> On Friday 25 April 2008, H. Peter Anvin wrote:
>> This patchset unifies the integer definitions across all the
>> <asm-*/types.h> files, replacing them with two asm-generic files, one
>> for the LL64 model (all 32-bit architectures plus x86-64) and one for
>> the L64 model (all other 64-bit architectures.)
> 
> I started hacking on a similar patch just yesterday, but with a slightly
> different goal. My intention was to move the headers in a direction
> where a new architecture (microblaze being the next one) would no longer
> have to care about ABI defining headers at all, but just use the defaults
> from a single #include line.
> 
> I could deal with x86 by leaving the current asm-x86/types.h in place,
> and change all the others so they can use the common one. The only
> difference here would be umode_t and dma_addr_t, which are irregularly
> defined on a few architectures, but we can assume reasonable defaults, as in
> 

It seems reasonable to implement what you are proposing on top of my 
changes, IMO.

	-hpa
