From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch v3 30/36] Hexagon: Add page-fault support.
Date: Sun, 11 Sep 2011 12:08:49 -0300
Message-ID: <1315753729.455.56.camel@pasglop>
References: <20110909010847.294039464@codeaurora.org>
	 <20110909010917.578513171@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010917.578513171@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Thu, 2011-09-08 at 20:09 -0500, Richard Kuo wrote:

> +/*
> + * Canonical page fault handler
> + */
> +void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = current->mm;
> +	siginfo_t info;
> +	int si_code;
> +	int fault;
> +	const struct exception_table_entry *fixup;
> +
> +	si_code = SEGV_MAPERR;
> +	local_irq_enable();
> +
> +	/*
> +	 * If we're in an interrupt or have no user context,
> +	 * then must not take the fault.
> +	 */
> +	if (unlikely(in_interrupt() || !mm))
> +		goto no_context;

Are you sure about enabling interrupts before going to "no_context" ?

If somebody does a user access "in atomic" with interrupt disabled (with
the expectation that a fault would be caught by search_exception_tables
and returned as -EFAULT), such code probably doesn't expect interrupts
to be re-enabled implicitely.

Cheers,
Ben.


