From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LMB bits
Date: Tue, 13 Jul 2010 17:12:44 +1000
Message-ID: <1279005164.28659.407.camel@pasglop>
References: <4C38DDE3.9010303@kernel.org>
	 <1278905081.28659.157.camel@pasglop> <1278920286.28659.194.camel@pasglop>
	 <20100712.153455.108790468.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37316 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0GMHNN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jul 2010 03:13:13 -0400
In-Reply-To: <20100712.153455.108790468.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: yinghai@kernel.org, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Mon, 2010-07-12 at 15:34 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 12 Jul 2010 17:38:06 +1000
> 
> > Ok pushed.
> 
> Your current tree headed by 94f4de71740edb80dfbd3916fe83308d545a4419
> works fine for me.

Thanks Dave.

Ingo, Linus, how to you want to proceed ? We could get the rename patch
in now, that would make things easier for the ARM folks who have started
using LMB as well and are currently clashing in linux-next, and keep the
rest of the rework for the merge window ? Or keep the whole thing for
the merge window ?

Cheers,
Ben.
