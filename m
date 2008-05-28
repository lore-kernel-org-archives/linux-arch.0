From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 28 May 2008 10:36:48 +0200
Message-ID: <20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:39083 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbYE1Ils (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 May 2008 04:41:48 -0400
In-Reply-To: <1211926636.3286.100.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > I'm happy to say that __raw is purely about ordering and make them
> > > byteswap on powerpc tho (ie, make them little endian like the non-raw
> > > counterpart).  
> > 
> > That would break a lot of drivers.  
> 
> How many actually use __raw_ * ?

I do -- in all the drivers for on-chip peripherals that are shared
between AT91 ARM (LE) and AVR32 (BE). Since everything goes on inside
the chip, we must use LE accesses on ARM and BE accesses on AVR32.

Currently, this is the only interface I know that can do native-endian
accesses, so if you take it away, I'm gonna need an alternative
interface that doesn't do byteswapping.

Haavard
