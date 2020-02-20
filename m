From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Date: Thu, 20 Feb 2020 08:41:53 +0000
Message-ID: <20200220084153.GA11827@willie-the-truck>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgBTImB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 03:42:01 -0500
Content-Disposition: inline
In-Reply-To: <20200219150744.428764577@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>

On Wed, Feb 19, 2020 at 03:47:25PM +0100, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/hardirq.h |    4 ++--
>  arch/arm64/kernel/sdei.c         |   14 ++------------
>  arch/arm64/kernel/traps.c        |    8 ++------

For these arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

Will
