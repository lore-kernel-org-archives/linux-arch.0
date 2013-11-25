From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Preventing IPI sending races in arch code
Date: Mon, 25 Nov 2013 16:22:18 +0530
Message-ID: <52932BE2.5010201@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:33759 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab3KYKwk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 05:52:40 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>, Noam Camus <noamc@ezchip.com>, David Daney <david.daney@cavium.com>, James Hogan <james.hogan@imgtec.com>, peter Zijlstra <peterz@infradead.org>, thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>

Hi,

I've been looking into cleaning up bitrot in ARC SMP support. Unlike some other
arches/platforms, we don't have per-msg-type IRQ, so the actual msg (say cross
function call) corresponding to IPI needs to be encoded in a per-cpu word (1 bit
per msg type) before kicking the IPI.

The current code (indicative below) is completely bonkers as it calls set_bit w/o
any protection whatsoever, clearly racy in case of multiple senders, where
receiver could end up NOT seeing one of the writes.

ipi_send_msg(cpu, msg-type)
{
   struct ipi_data *ipi_data = &per_cpu(ipi_data, cpu);

   local_irq_save();
   set_bit(msg-type, &ipi_data->bits)
   plat_smp_ops.ipi_send(cpumask)
   local_irq_restore();
}

Adding a spinlock here would serialize the sending part, but I still see issue in
receiver. Upon receipt of First IPI, the msg holding word will be atomically
exchanged with 0, so 2nd IPI will not see any msg in the word. Augmenting with an
atomic counter would only help detect the issue - but I don't see how it will help
elide the issue.

Does that mean w/o proper hardware assist (i.e. IRQ providing the msg id
indication), the race, however small, remains ?

Comments much appreciated !

-Vineet
