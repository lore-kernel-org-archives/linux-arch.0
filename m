Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247093;
	b=JF6P4nSYib3vIx8awix3cunEiRwK68yB9oUEGwe/2UdxBAH8aRnJrT8YwZqEj8/D4lzK
	 1vBrc/qQwNYKJfxR/APPS/U81wv4ghfUOq0nl5kzgAJ/XB1oU7jn1ND8sBEPHzvi5AZQ+
	 SVVj6rw+rP+7q/S2/y30HPVOECymbUaPfrB2esxcP76NajHKje35mrN32us8x6dnUKqv+
	 GYEaGKSSzMq1b9Sv0u+CrAuGnRf6Eax1OJ4cLPk1nfQvipuUg/4X7HTqPyjK2IkzDVRjr
	 fBQNAHkHc/gKnKYV8tBYP1SsC24rzIYAS5lshIHPPrtadC/HZE3Qv0RnDVNZmYyZEhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247093;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=anXQ9xEFRpuVscWjF4veHeQEoufNiTl8sjFMCnLYhD8=;
	b=l6huGP+Y20yWMbMYKUU72txlIodX4LOy+k7Qzs/s/RqMBQuh5/QB3Uhmhv9Tuq6xzQhn
	 sVP1nYTGLmfjcreye8HpPUyXxkAQLWDY8DZ3+amgmlJQ5qz/VsWuDX0wELdB7l5m0YNqr
	 WKh7o7DrgROKo4xf7LVhh4jKEyCTLc9JiKM2wwkPxzwDIec/oJ2qoEVC+2XYXiltSleah
	 jFgtc9x9jK5bFHCMuNvF941JP5Wd/WglRS5UdY7lKQn+tk67hEGHAZTVgPYZKkuJClpZn
	 0DHS39tyoqpfDw1s4us09gn7SUD4/Xf96urtEJwbWdwIvhGiniik45MHHFvxv14Kg9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBkFu1V2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2E606A320;
	Thu, 29 Oct 2026 04:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D2E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=IBkFu1V2
Received: from kali (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1D94620B7167;
	Wed, 28 Oct 2026 21:11:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D94620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793247080;
	bh=anXQ9xEFRpuVscWjF4veHeQEoufNiTl8sjFMCnLYhD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBkFu1V261/eAHssMvEVTXMps8K7kIz2YUU2Gc042JavsrPsvuy8nVseaagXb7Bhl
	 5HpGZQeytK7xSYSHZ3PvQTi06Zm2GcwkiZt2uqKlI/N7XePfJ5D3t2RG4s1VJwd4X4
	 nxJiZfnLcjNNgBJ3IUivVAodP6O8MK2+L84XzN9o=
Date: Wed, 28 Oct 2026 23:11:18 -0500
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	boris.ostrovsky@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v16 00/16] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <auLHZnaCIajW1kxX@kali>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>

On Fri, Oct 16, 2026 at 12:08:21AM -0700, Ankur Arora wrote:
> Hi,
>
> Changes in this version address sashiko comments [17]. The major change
> is the change in the exit path in __smp_cond_load_relaxed_timeout()
> which allows us to simplify providing ACQUIRE semantics in
> smp_cond_load_acquire_timeout():
>
>   - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
>    - unify the exit path for the loop condition and timeout case
>    - includes vdso/time64.h
>    - document the timeout_ns == 0 case
>    - use u64 for internal arithmetic
>
>   - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
>    - While moving USECS_TO_CYCLES() into the driver namespace also
>      make it a static inline rpmh_usecs_to_cycles()
>
>   - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
>     - use the change in patch-1 to fixup, simplify the ACQUIRE path
>     - thresh out the commit message a bit more
>
>   - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
>     - enclose the calls to smp_cond_load_{relaxed,acquire}_timeout()
>       in preempt_disable(), preempt_enable().
>     - WFET makes it difficult to use a synthetic timer. So skip
>       timeout tests on configurations with WFET.
>
> Haris Okaovic tested v15 [18] "Tested again on AWS Graviton3/4/5
> (ARM Neoverse V1/V2/V3) with haltpoll changes atop latest master
> 8ab1afb2e: still seeing average 6% improvement across various workloads
> (mysql, postgresql, cassandra, memcached) in latency sensitive
> configuration.  The new unit tests all pass on both metal and virt
> variants of the same machines. -- Haris"
>
> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
> on condition variables with architectural primitives used to avoid
> hammering the relevant cachelines.
>
> (This primitive can vary greatly across architectures: on x86 it's a
> cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
> which waits for a cacheline to change state in a time limited fashion.)
>
> Regardless of architectural details, typical smp_cond_load*() usage
> does not allow for termination until the condition change occurs.
>
> Beyond the core kernel, there are cases where it is useful to additionally
> terminate on a timeout. Two cases:
>
>   - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
>     duration expires.
>
>   - rqspinlock: nested qspinlock acquisition that terminates on timeout
>     or deadlock.
>
> Accordingly add two interfaces (with their generic and arm64 specific
> implementations):
>
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>
> Also add tif_need_resched_relaxed_wait() which wraps the polling
> pattern and its scheduler specific details in poll_idle().
> In addition add atomic_cond_read_*_timeout(),
> atomic64_cond_read_*_timeout(), and atomic_long wrappers.
>
> Structurally, both the smp_cond_load_*_timeout() interfaces are similar
> to smp_cond_load*(), with the addition of a rate-limited time-check.
>
> Usage
> ==
>
> These interfaces drop straight-forwardly into the rqspinlock logic
> since qspinlock already uses smp_cond_load*(), and the time-check
> extension can now be used for timeout and deadlock handling.
>
> Using tif_need_resched_relaxed_wait() in poll_idle() removes any
> architectural details allowing arm64 to straight-forwardly support
> that path.
> (However, for efficiency reasons cpuidle/poll_state.c continues to
> depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
> with an optimized architectural primitive.)
>
>
> Performance
> ==
>
> Apart from simplifications due to this change, supporting polling in
> cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
> patches):
>
>
>   # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>   perf bench sched pipe -l 1000000 -c 4
>
>   # No haltpoll (and, no TIF_POLLING_NRFLAG):
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>
>        12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>
>
>   # Haltpoll:
>
>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>
>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>
>         7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>
>   We get improved latency because we don't switch in and out of a
>   deeper sleep state or from the hypervisor. This also causes us to
>   execute ~20% fewer instructions.
>
>
> Changelog:
>
>   v15 [17] (as listed above):
>    - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
>     - unify the exit path for the loop condition and timeout case
>     - includes vdso/time64.h
>     - document the timeout_ns == 0 case
>     - use u64 for internal arithmetic
>
>    - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
>     - While moving USECS_TO_CYCLES() into the driver namespace also
>       make it a static inline rpmh_usecs_to_cycles()
>
>    - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()",
>      - use the change in patch-1 to fixup, simplify the ACQUIRE path
>      - thresh out the commit message a bit more
>
>    - patch 14,15,16 "barrier: add tests for smp_cond_load_*_timeout()"
>      - enclose the calls to smp_cond_load_{relaxed,acquire}_timeout()
>        in preempt_disable(), preempt_enable().
>      - WFET makes it difficult to use a synthetic timer. So skip
>        timeout tests on configurations with WFET.
>
>
>   v14 [16]:
>     - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
>      - deferred time-check is now limited to a single usec.
>
>      - smp_cond_load_relaxed_timeout() now enforces that the timeout_ns value
>        does fit in s64.
>
>      - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
>        architecture provides a waiting implementation of cpu_poll_relax()
>        (defines CPU_POLL_RELAX_WAITS).
>
>     - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
>       - convert the 32-bit arithmetic to use mul_u64_u64_shr() to avoid
>         truncating large delay values.
>
>       - make usecs_to_cycles(), nsecs_to_cycles() static inlines.
>
>     - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()"
>       - provide full acquire semantics (via smp_load_acquire()) in the
>         failure path.
>
>     - patch-16, "barrier: timeout validity checks for smp_cond_load_acquire_timeout()"
>       - add some tests for clocks that can fail (rqspinlock like
>        semantics)
>
>   v13 [15]:
>     - rename kconfig entry for the barrier kunit test to follow
>       the kunit style guide
>       (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)
>
>     - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
>       is not enabled.
>
>     Both comments from Julian Braha.
>
>   v12 [14]:
>     - smp_cond_load_acquire_timeout() now only has acquire semantics in
>       the success (non-timeout) case.
>
>     - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
>       defining TIF_POLLING_NRFLAG, in some cases we end up with a
>       degenerate version of poll_idle().
>
>     - kunit: removed the test case for timeout=-1 (not supported)
>       Also add test cases for timeout=0, timeout=1.
>
>     (All of these address review comments from sashiko/bpf-bot.)
>
>   v11 [13]:
>     - addressed some review comments from sashiko (see commit notes)
>       - The one notable change is to the implementation of
>         smp_cond_load_acquire_timeout() where there was a missed
>         control dependency in the timeout case.
>       All the others are minor.
>     - fixed a low probability race in the kunit test added in v11.
>     - added a bunch of kunit tests validating the implementation's
>       use of the clock.
>
>   v10 [10]:
>    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>      be using architectural primitives that don't support MMIO.
>      (David Laight, Catalin Marinas)
>    - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
>      Morton.)
>
>   v9 [9]:
>    - s/@cond/@cond_expr/ (Randy Dunlap)
>    - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
>      addresses. (David Laight)
>    - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
>      (Catalin Marinas).
>    - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
>      in the cmpwait path instead of using arch_timer_read_counter().
>      (Catalin Marinas)
>
>   v8 [0]:
>    - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>       (comment from Alexei Starovoitov).
>
>    - Mention that cpu_poll_relax() is better than raw CPU polling
>      only where ARCH_HAS_CPU_RELAX is defined.
>      - also define ARCH_HAS_CPU_RELAX for arm64.
>       (Came out of a discussion with Will Deacon.)
>
>    - Split out WFET and WFE handling. I was doing both of these
>      in a common handler.
>      (From Will Deacon and in an earlier revision by Catalin Marinas.)
>
>    - Add mentions of atomic_cond_read_{relaxed,acquire}(),
>      atomic_cond_read_{relaxed,acquire}_timeout() in
>      Documentation/atomic_t.txt.
>
>    - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().
>
>    - Cleanup unnecessary assignments, casts etc in poll_idle().
>      (From Rafael Wysocki.)
>
>    - Fixup warnings from kernel build robot
>
>
>   v7 [1]:
>    - change the interface to separately provide the timeout. This is
>      useful for supporting WFET and similar primitives which can do
>      timed waiting (suggested by Arnd Bergmann).
>
>    - Adapting rqspinlock code to this changed interface also
>      necessitated allowing time_expr to fail.
>    - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().
>
>    - add WFET support (suggested by Arnd Bergmann).
>    - add support for atomic-long wrappers.
>    - add a new scheduler interface tif_need_resched_relaxed_wait() which
>      encapsulates the polling logic used by poll_idle().
>      - interface suggested by (Rafael J. Wysocki).
>
>
>   v6 [2]:
>    - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
>    - remove a race between setting of TIF_NEED_RESCHED and the call to
>      smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
>      would be set even if we hadn't spent any time waiting.
>      (The original check compared against local_clock(), which would have been
>      fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
>    (Both from meta-CI bot)
>
>
>   v5 [3]:
>    - use cpu_poll_relax() instead of cpu_relax().
>    - instead of defining an arm64 specific
>      smp_cond_load_relaxed_timeout(), just define the appropriate
>      cpu_poll_relax().
>    - re-read the target pointer when we exit due to the time-check.
>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>    (Suggested by Will Deacon)
>
>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>      interfaces.
>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>    (Suggested by Catalin Marinas)
>
>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>
>
>   v4 [4]:
>     - naming change 's/timewait/timeout/'
>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>       and fixup use of RES_CHECK_TIMEOUT().
>     (Both suggested by Catalin Marinas)
>
>   v3 [5]:
>     - further interface simplifications (suggested by Catalin Marinas)
>
>   v2 [6]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in
>       hindsight unnecessary constants.
>
>   v1 [7]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]
>
> Comments appreciated!
>
> Thanks
> Ankur
>
>  [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
>  [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
>  [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>  [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>  [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>  [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>  [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>  [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
>  [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
>  [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
>  [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
>  [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
>  [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
>  [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
>  [16] https://lore.kernel.org/all/20260714073041.40250-1-ankur.a.arora@oracle.com/
>  [17] https://lore.kernel.org/all/20260831202251.305046-1-ankur.a.arora@oracle.com/
>  [18] https://lore.kernel.org/all/178908146776.2725577.2613699832033292946.b4-review@b4/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
>
>
> Ankur Arora (16):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: barrier: Support smp_cond_load_relaxed_timeout()
>   arm64/delay: move, fixup usecs_to_cycles()
>   arm64: support WFET in smp_cond_load_relaxed_timeout()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>   atomic: Add atomic_cond_read_*_timeout()
>   locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
>   bpf/rqspinlock: switch check_timeout() to a clock interface
>   bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>   sched: add need-resched timed wait interface
>   cpuidle/poll_state: Wait for need-resched via
>     tif_need_resched_relaxed_wait()
>   arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>   barrier: add tests for smp_cond_load_*_timeout()
>   barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
>   barrier: timeout validity checks for smp_cond_load_acquire_timeout()
>
>  Documentation/atomic_t.txt           |  14 +-
>  arch/arm64/include/asm/barrier.h     |  24 +++
>  arch/arm64/include/asm/cmpxchg.h     |  62 ++++--
>  arch/arm64/include/asm/delay-const.h |  35 ++++
>  arch/arm64/include/asm/rqspinlock.h  |  85 --------
>  arch/arm64/lib/delay.c               |  19 +-
>  drivers/clocksource/arm_arch_timer.c |   2 +
>  drivers/cpuidle/poll_state.c         |  21 +-
>  drivers/soc/qcom/rpmh-rsc.c          |  12 +-
>  include/asm-generic/barrier.h        | 157 ++++++++++++++
>  include/linux/atomic.h               |  10 +
>  include/linux/atomic/atomic-long.h   |  18 +-
>  include/linux/sched/idle.h           |  29 +++
>  kernel/bpf/rqspinlock.c              |  78 ++++---
>  lib/Kconfig.debug                    |  10 +
>  lib/tests/Makefile                   |   1 +
>  lib/tests/barrier-timeout-test.c     | 297 +++++++++++++++++++++++++++
>  scripts/atomic/gen-atomic-long.sh    |  16 +-
>  18 files changed, 710 insertions(+), 180 deletions(-)
>  create mode 100644 arch/arm64/include/asm/delay-const.h
>  create mode 100644 lib/tests/barrier-timeout-test.c
>
> --
> 2.43.7
>
Hi Ankur,

I tested this patch series on an Azure Cobalt 100
(neoverse-n2 on 64-vCPU Hyper-V guest (Standard_D64ps_v6),
on v7.2.12 + this series + arm64 cpuidle-haltpoll enablement[1]

cpuidle-haltpoll loaded with force=1, guest_halt_poll_ns=200000.

Baseline: no cpuidle driver(only WFI).

Workload: PostgreSQL 16.15/pgbench scale 100, client and server in
the same VM over a unix socket, with single run:

            with (-S)                         TPC-B-like r/w
clients  base TPS  haltpoll lat avg   base TPS   haltpoll  lat avg
   2       38658     +89%   52->27us     5299     +86%    378->203us
   4       72987     +99%   55->28      10305     +87%    388->208
  16      300895     +91%   53->28      42035     +83%    381->208
  32      590987     +93%   55->28      78319     +85%    410->221
  64      987749      +0%   65->65     130675      +3%    490->474

Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Regards,
Sahil

[1] https://lore.kernel.org/all/20250218213337.377987-1-ankur.a.arora@oracle.com/
