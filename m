From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LMB bits
Date: Sat, 10 Jul 2010 21:01:59 +1000
Message-ID: <1278759719.28659.155.camel@pasglop>
References: <1278659480.28659.149.camel@pasglop>
	 <20100709072408.GD10743@elte.hu>
	 <20100709.172050.112604881.davem@davemloft.net>
	 <20100709.205544.48508808.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48822 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab0GJLC0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 10 Jul 2010 07:02:26 -0400
In-Reply-To: <20100709.205544.48508808.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, yinghai@kernel.org, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Fri, 2010-07-09 at 20:55 -0700, David Miller wrote:
> A quick update, I'm still chipping away to find the culprit,
> I know so far that things are ok at least 14 patches into the
> series.
> 
> I'll work more to try and track down the exact problem tomorrow. 

Thanks Dave !

To save you that burden in the future, do you know if there's a sparc64
box somewhere I can access to do tests ? Or an emulator maybe ?

Cheers,
Ben.
