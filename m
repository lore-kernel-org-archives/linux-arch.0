From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Date: Thu, 20 Feb 2020 14:18:36 +0100
Message-ID: <20200220131836.7yo7ktnhggo7653z@pathway.suse.cz>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgBTNSm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 08:18:42 -0500
Content-Disposition: inline
In-Reply-To: <20200219150744.428764577@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>

On Wed 2020-02-19 15:47:25, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.

Reviewed-by: Petr Mladek <pmladek@suse.com>	# for printk part

The rest looks good as well.

Best Regards,
Petr
