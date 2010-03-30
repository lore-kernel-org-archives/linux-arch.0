From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 1/2] genirq: Run irq handlers with interrupts disabled
Date: Tue, 30 Mar 2010 07:33:25 +0200
Message-ID: <20100330053325.GL20695@one.firstfloor.org>
References: <20100326000325.917127328@linutronix.de> <20100326000405.758579387@linutronix.de> <20100326061310.GV20695@one.firstfloor.org> <alpine.LFD.2.00.1003261224070.3147@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56576 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab0C3Fd0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2010 01:33:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003261224070.3147@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <andi@firstfloor.org>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

> Why not simply force IRQF_DISABLED for all MSI interrupts. That still
> allows nesting for non MSI ones, but it limits the chance of throwing
> up reasonably well. That's a two liner.
> 
> Can you please test whether it resolves the issue at hand ?

Sorry for the late answer. Got confirmation that this patch
fixes the test case. Thanks.

-Andi
