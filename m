From: Paul Mackerras <paulus@samba.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 11 Jun 2008 15:20:28 +1000
Message-ID: <18511.24732.191606.794160@cargo.ozlabs.ibm.com>
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806101656.51211.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755614AbYFKJGx@vger.kernel.org>
In-Reply-To: <200806101656.51211.nickpiggin@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nick Piggin writes:

> Now that doesn't leave waker ordering architectures lumped with "slow old
> x86 semantics". Think of it as giving them the benefit of sharing x86
> development and testing :)

Worth something, but not perhaps as much as you think, given that many
x86 driver writers still don't pay much attention to making their code
endian-safe and 64-bit-clean.  And there are still plenty of drivers
that use virt_to_bus...

Paul.
