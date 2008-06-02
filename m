From: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 02 Jun 2008 11:56:39 +0200
Message-ID: <4843C3D7.7000609@sgi.com>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <20080526204233.75b71bb8@infradead.org> <1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com> <1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com> <yq0iqwxrwuh.fsf@jaguar.mkp.net> <20080531075242.GC108600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:58491 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751233AbYFBJ4n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 05:56:43 -0400
In-Reply-To: <20080531075242.GC108600@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

Jeremy Higdon wrote:
> We don't actually have that problem on the Altix.  All writes issued
> by CPU X will be ordered with respect to each other.  But writes by
> CPU X and CPU Y will not be, unless an mmiowb() is done by the
> original CPU before the second CPU writes.  I.e.
> 
> 	CPU X	writel
> 	CPU X	writel
> 	CPU X	mmiowb
> 
> 	CPU Y	writel
> 	...
> 
> Note that this implies some sort of locking.  Also note that if in
> the above, CPU Y did the mmiowb, that would not work.

Hmmm,

Then it's less bad than I thought - my apologies for the confusion.

Would we be able to use Ben's trick of setting a per cpu flag in
writel() then and checking that in spin unlock issuing the mmiowb()
there if needed?


Cheers,
Jes
