Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfJPSpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 14:45:05 -0400
Date: Wed, 16 Oct 2019 20:43:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191016184346.GT2328@hirez.programming.kicks-ass.net>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-2-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191016184346.VLJ4k_IpoF01ZmEH3Q90mcu-b6kXcmkEtNQlKcb0IZc@z>

On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:

> +bool __kcsan_check_watchpoint(const volatile void *ptr, size_t size,
> +			      bool is_write)
> +{
> +	atomic_long_t *watchpoint;
> +	long encoded_watchpoint;
> +	unsigned long flags;
> +	enum kcsan_report_type report_type;
> +
> +	if (unlikely(!is_enabled()))
> +		return false;
> +
> +	watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
> +				     &encoded_watchpoint);
> +	if (watchpoint == NULL)
> +		return true;
> +
> +	flags = user_access_save();

Could use a comment on why find_watchpoint() is save to call without
user_access_save() on.

> +	if (!try_consume_watchpoint(watchpoint, encoded_watchpoint)) {
> +		/*
> +		 * The other thread may not print any diagnostics, as it has
> +		 * already removed the watchpoint, or another thread consumed
> +		 * the watchpoint before this thread.
> +		 */
> +		kcsan_counter_inc(kcsan_counter_report_races);
> +		report_type = kcsan_report_race_check_race;
> +	} else {
> +		report_type = kcsan_report_race_check;
> +	}
> +
> +	/* Encountered a data-race. */
> +	kcsan_counter_inc(kcsan_counter_data_races);
> +	kcsan_report(ptr, size, is_write, raw_smp_processor_id(), report_type);
> +
> +	user_access_restore(flags);
> +	return false;
> +}
> +EXPORT_SYMBOL(__kcsan_check_watchpoint);
> +
> +void __kcsan_setup_watchpoint(const volatile void *ptr, size_t size,
> +			      bool is_write)
> +{
> +	atomic_long_t *watchpoint;
> +	union {
> +		u8 _1;
> +		u16 _2;
> +		u32 _4;
> +		u64 _8;
> +	} expect_value;
> +	bool is_expected = true;
> +	unsigned long ua_flags = user_access_save();
> +	unsigned long irq_flags;
> +
> +	if (!should_watch(ptr))
> +		goto out;
> +
> +	if (!check_encodable((unsigned long)ptr, size)) {
> +		kcsan_counter_inc(kcsan_counter_unencodable_accesses);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Disable interrupts & preemptions, to ignore races due to accesses in
> +	 * threads running on the same CPU.
> +	 */
> +	local_irq_save(irq_flags);
> +	preempt_disable();

Is there a point to that preempt_disable() here?
