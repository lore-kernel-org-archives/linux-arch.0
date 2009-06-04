From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at the
	Kernel Summit
Date: Wed, 3 Jun 2009 23:24:43 -0400
Message-ID: <8bd0f97a0906032024k412ac3a5x1dbf52b74dc1ebbd@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
	 <1244045997.21423.303.camel@mulgrave.site>
	 <20090603170925.GA8330@flint.arm.linux.org.uk>
	 <20090603114344.bf852654.akpm@linux-foundation.org>
	 <FF038EB85946AA46B18DFEE6E6F8A2890151520C@xmb-rtp-218.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:61536 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZFDDYm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2009 23:24:42 -0400
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2890151520C@xmb-rtp-218.amer.cisco.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, James.Bottomley@hansenpartnership.com, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

On Wed, Jun 3, 2009 at 23:11, David VomLehn (dvomlehn) wrote:
> David Delaney has a proof-of-concept of an idea of his which was
> presented at the last CELF, which is basically to put the kernel and
> loadable kernel modules closely enough together that you can avoid the
> use of long jumps. He sees a better than 1% improvement in performance,
> which we've duplicated using a slightly different approach. This is nice
> payback for little work and, though it doesn't help on all processors,
> it helps on several.

it would help on the Blackfin architecture.  we compile all kernel
modules with -mlong-call because of this issue.

> The problem is: how do you allocate memory with the magical "close to
> the kernel" attribute? We have something that adds a new ZONE_KERNEL
> (this name has some problems, actually). It seems like a pretty good
> solution if you look at zones as conceptually concentric usages, but
> with the current zone implementation, each zone must be contiguous. So,
> if we're talking about changing what zones are done, I'd like to throw
> this into the pot.

what do you do if the alloc fails ?  return back to userspace with
something like ENOMEM and have it retry with a module that was
compiled with -mlong-call ?
-mike
