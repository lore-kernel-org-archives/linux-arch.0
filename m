From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 12:10:40 -0700
Message-ID: <48122CB0.7020003@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org> <20080425185251.GL14990@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080425185251.GL14990-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Matthew Wilcox wrote:
> 
> So ... given all this, why do we define s64 to be 'long' on some
> architectures and 'long long' on others?  It seems to actively _hinder_
> passing it to printf(), so there must be some other good reason that
> I'm missing to not make it 'long long' everywhere.
> 

Well, compatibility with userspace is probably one aspect of that. 
x86-64 is the odd man out there, it defines __s64 as "long long" even 
for userspace, even though int64_t from <stdint.h> is "long".  This, 
IMO, is the Wrong Thing, but it's a separate set of changes.

The right thing to do is probably to always use "long long" in the 
kernel, while defining __s64 et al as "long" on 64-bit platforms when 
not under __KERNEL__.

Again, this is a separate set of changes from this patchset, which is 
just a code transformation.

	-hpa
