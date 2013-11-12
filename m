From: Joe Perches <joe@perches.com>
Subject: Re: [tip:x86/asm] x86, bitops:  Change bitops to be native operand
 size
Date: Mon, 11 Nov 2013 18:54:43 -0800
Message-ID: <1384224883.4771.28.camel@joe-AO722>
References: <tip-z61ofiwe90xeyb461o72h8ya@git.kernel.org>
	 <1384117768.3081.10.camel@joe-AO722>
	 <5ac67859-a0b2-47f5-bdc2-c2a52b8d6885@email.android.com>
	 <1384123457.3081.33.camel@joe-AO722> <52803BA2.2080908@zytor.com>
	 <1384136570.4771.5.camel@joe-AO722> <5281698F.9080808@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:37685 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751385Ab3KLCyk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Nov 2013 21:54:40 -0500
In-Reply-To: <5281698F.9080808@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, james.t.kukunas@intel.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>

On Mon, 2013-11-11 at 15:34 -0800, H. Peter Anvin wrote:
> On 11/10/2013 06:22 PM, Joe Perches wrote:
> > 
> > Perhaps the current x86 bitops asm code is being conflated
> > with the ideal implementation?
> > 
> Yes, by you.

Really?  I don't think so.

How does the use of signed long for an index where
no negative values are possible or the use of a
negative int for BIT_MASK make sense?

> x86 has instructions that operate on signed bitindicies.

indices.

> It doesn't
> have instructions that operate on unsigned bitindicies.  Unless someone
> is willing to do the work to prove that shift and mask is actually
> faster than using the hardware instructions (which I doubt, but it is
> always a possibility), that's what we have.

That doesn't mean x86 is the ideal implementation.
