From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 13:28:58 -0600
Message-ID: <20080425192858.GM14990@parisc-linux.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org> <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48122CB0.7020003-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Apr 25, 2008 at 12:10:40PM -0700, H. Peter Anvin wrote:
> Well, compatibility with userspace is probably one aspect of that. 
> x86-64 is the odd man out there, it defines __s64 as "long long" even 
> for userspace, even though int64_t from <stdint.h> is "long".  This, 
> IMO, is the Wrong Thing, but it's a separate set of changes.
> 
> The right thing to do is probably to always use "long long" in the 
> kernel, while defining __s64 et al as "long" on 64-bit platforms when 
> not under __KERNEL__.
> 
> Again, this is a separate set of changes from this patchset, which is 
> just a code transformation.

Understood, and agreed.  It just seemed like an opportune time to
mention the problem of printing a u64.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
