From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for
 patching
Date: Thu, 6 Sep 2018 11:01:42 +0200
Message-ID: <20180906090142.GG24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-5-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180902173224.30606-5-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Sep 02, 2018 at 10:32:22AM -0700, Nadav Amit wrote:
> +void __init poking_init(void)
> +{
> +	unsigned long poking_addr;
> +
> +	poking_mm = copy_init_mm();
> +	if (!poking_mm) {
> +		pr_err("x86/mm: error setting a separate poking address space");
> +		return;
> +	}
> +
> +	/*
> +	 * Randomize the poking address, but make sure that the following page
> +	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
> +	 * and adjust the address if the PMD ends after the first one.
> +	 */
> +	poking_addr = TASK_UNMAPPED_BASE +
> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
> +
> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) == 0)
> +		poking_addr += PAGE_SIZE;
> +}

This fails to compile for me.. I don't have kaslr_get_random_long().
