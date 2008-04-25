From: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 21:43:50 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804252143170.20150@fbirervta.pbzchgretzou.qr>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
 <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com> <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <48123325.30003-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


On Friday 2008-04-25 21:38, H. Peter Anvin wrote:
>> Understood, and agreed.  It just seemed like an opportune time to
>> mention the problem of printing a u64.
>> 
>
> I have to admit to liking the Windows extension %I64u for this kind of stuff.
> Unfortunately gcc/glibc decided to use I for internationalized digits instead
> :(

In the kernel's *printk, we are free to do what we want :)

%_64u perhaps?
