From: Jes Sorensen <jes@sgi.com>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: Thu, 22 May 2008 14:28:23 +0200
Message-ID: <483566E7.8010703@sgi.com>
References: <20080521152855.GE8897@wotan.suse.de> <yq0fxsaivo4.fsf@jaguar.mkp.net> <20080522095121.GA18012@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:37748 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934565AbYEVM2a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 May 2008 08:28:30 -0400
In-Reply-To: <20080522095121.GA18012@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, jbarnes@virtuousgeek.org, Linus Torvalds <torvalds@linux-foundation.org>

Nick Piggin wrote:
> Right, but probably the large majority of wmb() callers actually
> just want io_wmb(). This would relieve much of the performance
> problem, I'd say.
> 
> Of those that really want a wmb() and cannot be converted to
> io_wmb(), I don't think it is a good option to actually just weaken
> wmb() because we deem that doing what the caller asked for is too
> expensive.

Hi Nick,

I believe there's a fair number of places where wmb() is used for
memory ordering not related to IO.

> I guess with the ia64_mf(), Altix probably does not reorder PCI
> stores past earlier cacheable stores, so _some_ wmb()s actually
> do not require the full mmiowb case (if we only need to order
> an earlier RAM store with a later PCI store). However, again,
> weakening wmb() is not a good option because it really requires
> an audit of the entire tree to do that.

Nope, unfortunately not, ia64_mf() isn't strong enough to prevent the
reordering, it's done in the PCI controller, so in order to guarantee
the the reording you have to go all the way out to the PCI controller,
which is very slow.

> We _could_ introduce partial barriers like store/iostore iostore/store,
> but really, I think the io_wmb is a pretty good first step, and I
> haven't actually seen any numbers indicating it would be a performance
> problem.

I must admit I am not 100% upto speed on the entire discussion, but I
think the io_wmb() and friends did go around in the past and got shot
down.

Cheers,
Jes
