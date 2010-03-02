From: Catalin Marinas <catalin.marinas@arm.com>
Subject: SMP barriers semantics
Date: Tue, 02 Mar 2010 10:52:58 +0000
Message-ID: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51427 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086Ab0CBKxG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2010 05:53:06 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>

Hi,

We have an issue with the barriers usage/implementation on ARM and I
would like some clarification.

As a background - latest ARM processors have two kinds of barriers - a
lightweight one (DMB) which basically only ensures the ordering of
accesses to the same memory type (the definition is a bit more
complicated but in the context of Linux this is a safe simplification).
The second kind of barrier is a heavyweight one (DSB) which drains the
write buffers.

Both *mb() and smp_*mb() are currently implemented with the lightweight
version (DMB) but this is not enough for coherent DMA operations where a
DSB is needed to drain the write buffer before writing to the device I/O
memory for starting the transfer. My proposal on the ARM lists was to
change mb()/wmb() to DSB but leave the smp_*mb() as a DMB.

The main question - are the Linux SMP barriers supposed to have an
effect outside of cacheable memory accesses (i.e. ordering wrt I/O
accesses)?

My understanding from other comments in the kernel source is that the
SMP barriers are only meant or cacheable memory but there are drivers
that do something like below (e.g. drivers/net/r8169.c):

		/* We need for force the visibility of tp->intr_mask
		 * for other CPUs, as we can loose an MSI interrupt
		 * and potentially wait for a retransmit timeout if we don't.
		 * The posted write to IntrMask is safe, as it will
		 * eventually make it to the chip and we won't loose anything
		 * until it does.
		 */
		tp->intr_mask = 0xffff;
		smp_wmb();
		RTL_W16(IntrMask, tp->intr_event);

Is this supposed to work given the SMP barriers semantics?

Thanks.

-- 
Catalin
