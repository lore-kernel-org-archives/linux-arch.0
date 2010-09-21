From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -tip -v5] irq_work: generic hard-irq context callbacks
Date: Tue, 21 Sep 2010 20:20:51 +0200
Message-ID: <1285093251.2275.888.camel@laptop>
References: <1284689131.32373.63.camel@yhuang-dev>
	 <1284728802.28028.470.camel@twins> <20100920042011.GA13542@drongo>
	 <1284973981.2275.642.camel@laptop>  <20100921030523.GB14668@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:32855 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab0IUSVR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Sep 2010 14:21:17 -0400
In-Reply-To: <20100921030523.GB14668@drongo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, 2010-09-21 at 13:05 +1000, Paul Mackerras wrote:
> On Mon, Sep 20, 2010 at 11:13:01AM +0200, Peter Zijlstra wrote:
> > On Mon, 2010-09-20 at 14:20 +1000, Paul Mackerras wrote:
> > > Actually these days we do it by setting the decrementer (the built-in
> > > timer facility) to generate an interrupt immediately (well, within one
> > > timebase tick, i.e. a small number of nanoseconds).
> > 
> > Then that is something that wants curing I guess.. 
> 
> Curing?  Why?  How?

Sorry, I got my head in a twist, its fine.
