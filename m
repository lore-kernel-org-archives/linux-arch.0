Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262175AbUJZCl5@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:53472 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262164AbUJZClp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2004 22:41:45 -0400
Date: Mon, 25 Oct 2004 19:41:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] Add NO_IRQ to all architectures
Message-ID: <20041026024137.GE17038@holomorphy.com>
References: <1098756491.17886.18.camel@gaston> <Pine.LNX.4.58.0410251926340.427@ppc970.osdl.org> <1098757882.17887.35.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098757882.17887.35.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 26, 2004 at 12:31:22PM +1000, Benjamin Herrenschmidt wrote:
> Hehe... just after I went through all include/asm-*/... :)
> Well, the reason I did it that way is that I wasn't sure an arch
> wouldn't want to revert to 0 ... like x86 to be more "backward
> compatible" or to better match what probe_irq_* does ...
> Note to Willy: In the long run, the irq number should indeed be a
> typedef, it would be nice indeed to hide it in a structure, with some
> ISA_TO_IRQ and IRQ_TO_ISA for drivers who care about legacy numbers
> maybe ?

Justin case there was any confusion, this was William Irwin, not
Matthew Wilcox.


-- wli
