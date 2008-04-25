From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 12:49:16 -0700
Message-ID: <1209152956.14173.2.camel@brick>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
	 <1209078352-7593-2-git-send-email-hpa@zytor.com>
	 <1209078352-7593-3-git-send-email-hpa@zytor.com>
	 <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
	 <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
	 <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com>
	 <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com>
	 <alpine.LFD.1.10.0804251243590.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.1.10.0804251243590.2779-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Al Viro <viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2008-04-25 at 12:45 -0700, Linus Torvalds wrote:
> 
> On Fri, 25 Apr 2008, H. Peter Anvin wrote:
> > 
> > I have to admit to liking the Windows extension %I64u for this kind of stuff.
> > Unfortunately gcc/glibc decided to use I for internationalized digits instead
> > :(
> 
> The sad part is that this is purely a gcc thing. We could easily do the 
> right thing in the kernel vsnprintf stuff, but then we'd have to drop the 
> nice format warnings from gcc ;(

This looks like something sparse could be made to check though, should
we lose the gcc checking.

In fact, didn't Al Viro mention adding just this kind of checking to
sparse recently?

Harvey
