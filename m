Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:4404 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114AbXBVEEA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 23:04:00 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S2171CC> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 21 Feb 2007 23:03:56 -0500
Date: Wed, 21 Feb 2007 20:03:56 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <20070221.190702.88477592.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0702211953230.16904@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0702211313560.4043@woody.linux-foundation.org>
 <20070221.190702.88477592.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sfr@canb.auug.org.au, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, David Miller wrote:

> If unaligned accesses in userspace give SIGBUS, which is the case
> on both Sparc ports, it is a question of whether the same should be
> done in cases like this.
> 
> I can definitely see arguments in both directions.
> 
> On the one hand, if userland has the have aligned stuff while he
> executes, he should provide the same for things he gives to the
> kernel.
> 
> On the other hand, userland has no way to embed structures passed into
> system calls, using things like the "packed" GCC attribute, and
> communicate that to the kernel.  So in that regard, the kernel should
> try to handle the unaligned access as best as possible.
> 
> But currently we -EFAULT on sparc in this situation and I've never
> seen a problem because of that.
> 
> Nevertheless, I am to understand that in this case we're talking about
> a "u64" object, and that (and the structure it is in) will be aligned
> on an 8-byte boundary on both sparc32 and sparc64, so maybe there is
> no problem here?

SPARC is fine indeed, because it'll never wire the compat code for the 
"struct epoll_event" (because an u64 is 8 bytes aligned on both 32 and 
64 bit).
Mine was a conceptual issue, where for the only case that would the compat 
code for "struct epoll_event" cover (u64 align 4 bytes on 32 bit, and 8 
bytes on 64 bit), we are using {get,put}_user on an unaligned (4 bytes 
aligned) u64.
If all the architectures that require "struct epoll_event" compat, 
guarantee that a {get,put}_user of a u64 on unaligned memory works as 
expected, then Stephen code is fine.



- Davide


