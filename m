From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 12:03:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804251158410.2779@woody.linux-foundation.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
 <20080425185251.GL14990@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080425185251.GL14990-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>



On Fri, 25 Apr 2008, Matthew Wilcox wrote:
> 
> So ... given all this, why do we define s64 to be 'long' on some
> architectures and 'long long' on others?

Historical reasons, mainly. Once we start using one type for things like 
loff_t, it ends up getting encoded in user header files, and we're then 
basically forced to continue to use that particular type. Some of them end 
literally being embedded in the compiler itself (ie __builtin_size_t etc 
end up being known by compiler built-ins).

But yes, we could probably try to standardize the internal kernel s64/u64 
types that don't end up spreading anywhere else. 

Of course, part of the worry is probably that people thought that maybe 
"long long" would some day be 128-bit on a 64-bit architecture.

			Linus
