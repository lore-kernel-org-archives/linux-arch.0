From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LMB bits
Date: Mon, 12 Jul 2010 17:38:06 +1000
Message-ID: <1278920286.28659.194.camel@pasglop>
References: <20100709.172050.112604881.davem@davemloft.net>
	 <20100709.205544.48508808.davem@davemloft.net>
	 <1278759719.28659.155.camel@pasglop>
	 <20100710.131418.246532639.davem@davemloft.net>
	 <4C38DDE3.9010303@kernel.org>  <1278905081.28659.157.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40816 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab0GLHic (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Jul 2010 03:38:32 -0400
In-Reply-To: <1278905081.28659.157.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Mon, 2010-07-12 at 13:24 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2010-07-10 at 13:53 -0700, Yinghai Lu wrote:
> 
> > Ben/David, 
> > 
> > can you fold in following patch in your patchset too?
> > 
> > also please use -v2 [PATCH] lmb: rename to memblock
> > that is removing one wrong change with microblaze dts
> 
> Will do. I'm also fixing another bug David found. I'll have an updated
> branch later today.

Ok pushed.

Yinghai, I've left your patch on the top of the branch rather than
squashing it for now.

Cheers,
Ben.
