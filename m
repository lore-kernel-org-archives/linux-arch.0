Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38681 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab0CVVHd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 17:07:33 -0400
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from
 e820.c to fw_memmap.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1269290862.8599.77.camel@pasglop>
References: <4BA6EA62.1030603@kernel.org>
	 <20100321.210023.209981130.davem@davemloft.net>
	 <4BA6F1F6.3070102@kernel.org>
	 <20100321.213350.176660494.davem@davemloft.net>
	 <20100322092809.GA20607@elte.hu>  <1269290862.8599.77.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Mar 2010 08:07:13 +1100
Message-ID: <1269292033.8599.83.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, yinghai@kernel.org, tglx@linutronix.de, hpa@zytor.com, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100322210713.3vgBNmG_BO3LTLt-OfHetDrMl-fdH55PKi3X56XFYaA@z>

On Tue, 2010-03-23 at 07:47 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-03-22 at 10:28 +0100, Ingo Molnar wrote:
> > Note the other side of the coin: LMB appears to be deployed on only
> 4
> > non-x86 
> > architectures that muster ~1% of the Linux boxes while early_res is
> > deployed 
> > on more than 95%. 
> 
> You use that arguemnt ONE MORE FUCKING TIME and you'll end up in my
> killfile with a auto-NACK reply of anything that looks like a patch
> from you.

Allright, I've calmed down now, so my appologies for going over the top
here, I shouldn't reply to emails before breakfast ... but it looks like
Thomas made the point a lot more clearly than me or Dave did so it's all
good. Let's move on.

Cheers,
Ben.


