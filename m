From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 12:52:51 -0600
Message-ID: <20080425185251.GL14990@parisc-linux.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804251133100.2779-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Apr 25, 2008 at 11:36:26AM -0700, Linus Torvalds wrote:
> On Fri, 25 Apr 2008, Jan Engelhardt wrote:
> > long long is 64 bits on both 32 and 64, is not it?
> > If so, the split between 32 and 64 should not be necessary.
> 
> They may be the same size, but there are still pure C-level _type_ 
> differences that the compiler will warn about.
> 
> This is the same issue as a 32-bit type on x86-32: is it an "int" or a 
> "long"? From a pure size perspective it shouldn't matter, but if you pass 
> a pointer to it, or use it in a "printf()", it matters a whole lot, 
> because the compiler will complain if you use the wrong version.
> 
> So on some 32-bit architectures, "size_t" is "unsigned int", on others it 
> is "unsigned long", and you have to get it right in order to avoid 
> complaints. 
> 
> The exact same thing is true about "long" vs "long long" on 64-bit 
> architectures. They may have the same size, but they don't have the same 
> type.

So ... given all this, why do we define s64 to be 'long' on some
architectures and 'long long' on others?  It seems to actively _hinder_
passing it to printf(), so there must be some other good reason that
I'm missing to not make it 'long long' everywhere.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
