From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 22/44] metag: Time keeping
Date: Fri, 4 Jan 2013 18:18:07 +0530
Message-ID: <50E6CF87.4070802@synopsys.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-23-git-send-email-james.hogan@imgtec.com> <50E6A987.207@synopsys.com> <50E6C961.40009@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:43836 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ADMsf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 07:48:35 -0500
In-Reply-To: <50E6C961.40009@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>

On Friday 04 January 2013 05:51 PM, James Hogan wrote:
> On 04/01/13 10:05, Vineet Gupta wrote:
>>
>> I have a kludge in ARC port in this subsystem - which I hope you could help clear.
>>
>> ARC also has a local timer device used for clockevent on each CPU. A one-time
>> setup_irq() with IRQF_PERCPU - would indeed setup the generic IRQ subsystem - for
>> making registration effective for all CPUs. However don't you need some per-cpu
>> magic - say enabling the IRQ at cpu or embedded interrupt controller level -
>> assuming you starts off with all IRQs disabled (which ARC Linux does).
> Hi Vineet,
>
> For Meta this is done in secondary_start_kernel in
> arch/metag/kernel/smp.c (see
> https://github.com/jahogan/metag-linux/blob/metag-core/arch/metag/kernel/smp.c#L276).
> It uses tbi_startup_interrupt which is also called by the irq_startup
> callback for the root irq_chip.

Aha, I see. Actually even that way is not bad - although doing that in
local_timer_setup ( ) makes it much cleaner/obvious. So I can do the same and get
rid of the obscure request/enable API and their dependency API - and it's
workaround API .... which are used in only one more arch inexactly 1 place in the
whole kernel.

Another question if you don't mind. In our setup we have a UART (non-standard ARC
specific) which is wired up to the boot CPU (only). Now if the init/rcS happens to
run on non-boot CPU, the setup/request_irq( ) and hence consequential low level
cpu irq unmasking will only happen on *that* cpu. Now if user were to type a
key-stroke, the interrupt will be asserted on boot-cpu, which has interrupt
masked. How is this handled.

Many thx for your quick response.
-Vineet
