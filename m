From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Date: Thu, 20 Feb 2020 09:19:27 +0000
Message-ID: <9af753c4d91f6a46d3121e72186cee03@kernel.org>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgBTJTa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 04:19:30 -0500
In-Reply-To: <20200219150744.428764577@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>

On 2020-02-19 14:47, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks for cleaning this up!

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
