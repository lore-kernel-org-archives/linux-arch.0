Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53810
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751478AbXBVDHD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 22:07:03 -0500
Date: Wed, 21 Feb 2007 19:07:02 -0800 (PST)
Message-Id: <20070221.190702.88477592.davem@davemloft.net>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0702211313560.4043@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0702211313560.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: davidel@xmailserver.org, sfr@canb.auug.org.au, akpm@linux-foundation.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2007 13:15:58 -0800 (PST)

> On Wed, 21 Feb 2007, Davide Libenzi wrote:
> > > 
> > > We can't trust user pointers, and that includes not trusting them being 
> > > aligned. 
> > 
> > Don't we get EFAULT in case of exception (access or alignment) in there?
> > For "dealing with", here we'd need them to do the correct thing 
> > (split-load?) in case of mis-aligned access.
> 
> I sure hope no architecture does that. EFAULT should be for *unmapped* 
> accesses, not from users just using unaligned pointers. 
> 
> I would argue that it is a bug if some architecture thinks that 
> "get_user()" and "put_user()" don't do unaligned accesses. 
> 
> (Not to say that it might not be something some odd architecture *does*, 
> but I'd be disappointed if somebody did)

If unaligned accesses in userspace give SIGBUS, which is the case
on both Sparc ports, it is a question of whether the same should be
done in cases like this.

I can definitely see arguments in both directions.

On the one hand, if userland has the have aligned stuff while he
executes, he should provide the same for things he gives to the
kernel.

On the other hand, userland has no way to embed structures passed into
system calls, using things like the "packed" GCC attribute, and
communicate that to the kernel.  So in that regard, the kernel should
try to handle the unaligned access as best as possible.

But currently we -EFAULT on sparc in this situation and I've never
seen a problem because of that.

Nevertheless, I am to understand that in this case we're talking about
a "u64" object, and that (and the structure it is in) will be aligned
on an 8-byte boundary on both sparc32 and sparc64, so maybe there is
no problem here?
