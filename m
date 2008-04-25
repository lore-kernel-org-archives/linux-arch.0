From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 11:36:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0804252026040.20150-vVwEwcwQeYFPkBl3ERsXe1l1cybopEuJUBSOeVevoDU@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On Fri, 25 Apr 2008, Jan Engelhardt wrote:
> 
> long long is 64 bits on both 32 and 64, is not it?
> If so, the split between 32 and 64 should not be necessary.

They may be the same size, but there are still pure C-level _type_ 
differences that the compiler will warn about.

This is the same issue as a 32-bit type on x86-32: is it an "int" or a 
"long"? From a pure size perspective it shouldn't matter, but if you pass 
a pointer to it, or use it in a "printf()", it matters a whole lot, 
because the compiler will complain if you use the wrong version.

So on some 32-bit architectures, "size_t" is "unsigned int", on others it 
is "unsigned long", and you have to get it right in order to avoid 
complaints. 

The exact same thing is true about "long" vs "long long" on 64-bit 
architectures. They may have the same size, but they don't have the same 
type.

		Linus
