Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59344 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030201AbWCHV7x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 16:59:53 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <17423.20862.764098.732463@cargo.ozlabs.ibm.com>
References: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <28393.1141823992@warthog.cambridge.redhat.com>
	 <17423.20862.764098.732463@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 22:05:14 +0000
Message-Id: <1141855514.10606.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Iau, 2006-03-09 at 08:49 +1100, Paul Mackerras wrote:
> If the device accesses to memory are in response to an MMIO store,
> then the code needs an explicit wmb() between the memory stores and
> the MMIO store.  Disabling interrupts isn't going to help here because
> the device doesn't see the CPU interrupt enable state.

Interrupts are themselves entirely asynchronous anyway. The following
can occur on SMP Pentium-PIII.

	Device
		Raise IRQ

	CPU
		writel(MASK_IRQ, &dev->ctrl);
		readl(&dev->ctrl);

	IRQ arrives
		
CPU specific IRQ masking is synchronous, but IRQ delivery is not,
including IPI delivery (which is asynchronous and not guaranteed to
occur only once per IPI but can be replayed in obscure cases on x86).


