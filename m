From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] ARC: Improve cmpxchg syscall implementation
Date: Mon, 25 Jun 2018 13:03:56 -0700
Message-ID: <bc488b10-cd54-2ef8-46d6-d6c8dc20f799@synopsys.com>
References: <20180619142205.20493-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619142205.20493-1-abrodkin@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 06/19/2018 07:22 AM, Alexey Brodkin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> arc_usr_cmpxchg syscall is supposed to be used on platforms
> that lack support of Load-Locked/Store-Conditional instructions
> in hardware. And in that case we mimic missing hardware features
> with help of kernel's sycall that "atomically" checks current
> value in memory and then if it matches caller expectation new
> value is written to that same location.
>
> What's important in the description above:
>  - Check-and-exchange must be "atomical" which means
>    preemption must be disabled during entire "transaction"
>  - Data accessed is from user-space, i.e. we're dealing
>    with virtual addresses
>
> And in current implementation we have a couple of problems:
>
> 1. We do disable preemprion around __get_user() & __put_user()
>    but that in its turn disables page fault handler.
>    That means if a pointer to user's data has no mapping in
>    the TLB we won't be able to access required data.
>    Instead software "exception handling" code from __get_user_fn()
>    will return -EFAULT.
>
> 2. What's worse if we're dealing with data from not yet allocated
>    page (think of pre-copy-on-write state) we'll successfully
>    read data but on write we'll silently return to user-space
>    with correct result (which we really read just before). That leads
>    to very strange problems in user-space app further down the line
>    because new value was never written to the destination.
>
> 3. Regardless of what went wrong we'll return from syscall
>    and user-space application will continue to execute.
>    Even if user's pointer was completely bogus.
>    In case of hardware LL/SC that app would have been killed
>    by the kernel.
>
> With that change we attempt to imrove on all 3 items above:
>
> 1. We still disable preemption around write of user's data but
>    if we happen to fail with write we're enabling preemption
>    and try to fix-up page fault so that we have a correct permission
>    for writing user's data. Then re-try again in "atomic" context.
>
> 2. If real page fault fails or even access_ok() returns false
>    we send SIGSEGV to the user-space process so if something goes
>    seriously wrong we'll know about it much earlier.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-arch@vger.kernel.org
> ---
>
> Changes v1 -> v2:
>
>  * Peter's almost clean-room reimplmentation with less paranoid checks
>    and direct invocation of fixup_user_fault() for in-place update of
>    write permissions.
>

I don't like the changelog - it is way too verbose and doesn't say the exact
problem we are trying to solve. How about something like below ?

----->

    ARC: Improve cmpxchg syscall implementation
   
    This is used in configs lacking hardware atomics to emulate atomic r-m-w
    for user space, implemented by disabling preemption in kernel.
   
    However there are issues in current implementation:
   
    1. Process not terminated if invalid user pointer passed:
       i.e. __get_user() failed.
   
    2. The reason for this patch was __put_user() failure not being handled,
       for COW break scenario. The zero page is initially wired up and
       read by __get_user() succeeds. However a write by __put_user()
       doesn't complete the page fault handling due to the page fault
       disabling from preempt disable. And what's worse is we silently return
       the stale zero value from __get_user() to user space. So the fix
       handles the specific case by re-enabling preemption and explicitly
       fixing up the fault and retrying the whole sequence over.

OK ?

-Vineet
