From: Ingo Molnar <mingo@elte.hu>
Subject: Re: LMB bits
Date: Tue, 13 Jul 2010 10:54:25 +0200
Message-ID: <20100713085425.GC7984@elte.hu>
References: <4C38DDE3.9010303@kernel.org>
 <1278905081.28659.157.camel@pasglop>
 <1278920286.28659.194.camel@pasglop>
 <20100712.153455.108790468.davem@davemloft.net>
 <1279005164.28659.407.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35931 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0GMIyj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jul 2010 04:54:39 -0400
Content-Disposition: inline
In-Reply-To: <1279005164.28659.407.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, yinghai@kernel.org, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2010-07-12 at 15:34 -0700, David Miller wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Mon, 12 Jul 2010 17:38:06 +1000
> > 
> > > Ok pushed.
> > 
> > Your current tree headed by 94f4de71740edb80dfbd3916fe83308d545a4419
> > works fine for me.
> 
> Thanks Dave.
> 
> Ingo, Linus, how to you want to proceed ? We could get the rename patch in 
> now, that would make things easier for the ARM folks who have started using 
> LMB as well and are currently clashing in linux-next, and keep the rest of 
> the rework for the merge window ? Or keep the whole thing for the merge 
> window ?

I'd suggest you send a pull request to Linus with the rename - it is purely 
mechanical, tested and it will make life much easier in the merge window. 
Also, we are shortly after -rc5 now so should there be any fallout, there's 
enough time until -rc6.

Thanks,

	Ingo
