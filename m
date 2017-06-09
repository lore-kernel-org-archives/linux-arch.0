From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Fri, 9 Jun 2017 14:47:48 +0100
Message-ID: <20170609134748.GL13955@arm.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-11-palmer@dabbelt.com>
 <34ebb0fd-8d8b-3ec7-ecf1-f296e878bd5d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdFINrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Jun 2017 09:47:40 -0400
Content-Disposition: inline
In-Reply-To: <34ebb0fd-8d8b-3ec7-ecf1-f296e878bd5d@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org, Peter Zijlstra <peterz@infradead.org>

On Wed, Jun 07, 2017 at 11:52:10AM +0100, Marc Zyngier wrote:
> On 07/06/17 00:00, Palmer Dabbelt wrote:
> > +static void plic_disable(struct plic_data *data, int i, int hwirq)
> > +{
> > +	struct plic_enable_context *enable = plic_enable_context(data, i);
> > +
> > +	atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
> 
> This is still a device access, right? What does it mean to use the
> atomic primitives on that? What are you racing against? I thought the
> various context were private to an execution context...
> 
> Adding Will and PeterZ to the CC list because they will probably have
> their own views on this...

atomic_* accesses to MMIO is almost certainly a bad idea. Is this atomic
because you want to allow the function to run concurrently, or is it atomic
because you want some guarantees from the endpoint's view?

Will
