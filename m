Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:46475 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345AbYFKJGm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2008 05:06:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18511.24732.191606.794160@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jun 2008 15:20:28 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806101656.51211.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806101656.51211.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Message-ID: <20080611052028.x3ixsWYVWMzFY9XDEttajx1y_5XtnsoHb4AqiGL2f1w@z>

Nick Piggin writes:

> Now that doesn't leave waker ordering architectures lumped with "slow old
> x86 semantics". Think of it as giving them the benefit of sharing x86
> development and testing :)

Worth something, but not perhaps as much as you think, given that many
x86 driver writers still don't pay much attention to making their code
endian-safe and 64-bit-clean.  And there are still plenty of drivers
that use virt_to_bus...

Paul.
