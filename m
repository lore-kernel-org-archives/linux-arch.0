Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfAONlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 08:41:09 -0500
Date: Tue, 15 Jan 2019 05:41:08 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] RISCV:IRQ: Support IRQ_WORK interrupts with self IPI
Message-ID: <20190115134108.GA13216@infradead.org>
References: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: G SatishKumar <gsatish.ldd@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, palmer@sifive.com, linux-kernel@vger.kernel.org
Message-ID: <20190115134108.DNeANvXkeZ5-p8JncrVaV-Cr4Vs0lSIg5F279_WbHLA@z>

On Sun, Jan 06, 2019 at 07:02:58PM +0530, G SatishKumar wrote:
> 	This patch adds, IRQ Work interrupts support to RISCV arch.
> 
> 	This patch is based on the arm32 patch ARM 7872/1
> 	which ports cleanly.
> 
> 	Done set of changes based on RISCV SMP process.
> 
> 	commit bf18525fd793 ("ARM: 7872/1: Support arch_irq_work_raise()
> 		via self IPIs")
> 	Author: Stephen Boyd <sboyd at codeaurora.org>
> 	Date:   Tue Oct 29 20:32:56 2013 +0100
> 
> 	By default, IRQ work is run from the tick interrupt (see
> 	irq_work_run() in update_process_times()). When we're in full
> 	NOHZ mode, restarting the tick requires the use of IRQ work and
> 	if the only place we run IRQ work is in the tick interrupt we
> 	have an unbreakable cycle. Implement arch_irq_work_raise() via
> 	self IPIs to break this cycle and get the tick started again.
> 	Note that we implement this via IPIs which are only available on
> 	SMP builds. This shouldn't be a problem because full NOHZ is only
> 	supported on SMP builds anyway.

The commit logs here looks oddly indented.  Also what workload did you
test this with?
