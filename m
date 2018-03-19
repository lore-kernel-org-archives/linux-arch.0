From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Date: Mon, 19 Mar 2018 11:29:24 -0700
Message-ID: <5bc39838-b1c5-ef65-f97d-8777ed33bda0@synopsys.com>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180319110002.27419-1-abrodkin@synopsys.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-snps-arc@lists.infradead.org
Cc: Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/19/2018 04:00 AM, Alexey Brodkin wrote:
> arc_usr_cmpxchg syscall is supposed to be used on platforms
> that lack support of Load-Locked/Store-Conditional instructions
> in hardware. And in that case we mimic missing hardware features
> with help of kernel's sycall that "atomically" checks current
> value in memory and then if it matches caller expectation new
> value is written to that same location.
> 
...
...

> 
> 2. What's worse if we're dealing with data from not yet allocated
>     page (think of pre-copy-on-write state) we'll successfully
>     read data but on write we'll silently return to user-space
>     with correct result 

This is technically incorrect, even for reading, you need a page, which could be 
common zero page in certain cases.

(which we really read just before). That leads
>     to very strange problems in user-space app further down the line
>     because new value was never written to the destination.
> 
> 3. Regardless of what went wrong we'll return from syscall
>     and user-space application will continue to execute.
>     Even if user's pointer was completely bogus.

Again we are exaggerating (from technical correctness POV) - if user pointer was 
bogs, the read would not have worked in first place etc. So lets tone down the 
rhetoric.


>     In case of hardware LL/SC that app would have been killed
>     by the kernel.
> 
> With that change we attempt to imrove on all 3 items above:
> 
> 1. We still disable preemption around read-and-write of
>     user's data but if we happen to fail with either of them
>     we're enabling preemption and try to force page fault so
>     that we have a correct mapping in the TLB. Then re-try
>     again in "atomic" context.
> 
> 2. If real page fault fails or even access_ok() returns false
>     we send SIGSEGV to the user-space process so if something goes
>     seriously wrong we'll know about it much earlier.
> 


>   
>   	/*
>   	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
> @@ -60,23 +62,48 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>   	/* Z indicates to userspace if operation succeded */
>   	regs->status32 &= ~STATUS_Z_MASK;
>   
> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
> -		return -EFAULT;
> +	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
> +	if (!ret)
> +		goto fail;
>   
> +again:
>   	preempt_disable();
>   
> -	if (__get_user(uval, uaddr))
> -		goto done;
> -
> -	if (uval == expected) {
> -		if (!__put_user(new, uaddr))
> +	ret = __get_user(val, uaddr);
> +	if (ret == -EFAULT) {


Lets see if this warrants adding complexity ! This implies that TLB entry with 
Read permissions didn't exist for reading the var and page fault handler could not 
wire up even a zero page due to preempt_disable, meaning it was something not 
touched by userspace already - sort of uninitialized variable in user code. 
Otherwise it is extremely unlikely to start with a TLB entry with Read 
permissions, followed by syscall Trap only to find the entry missing, unless a 
global TLB flush came from other cores, right in the middle. But this syscall is 
not guaranteed to work with SMP anyways, so lets ignore any SMP misdoings here.

Now in case it was *an* uninitialized var, do we have to guarantee any well 
defined semantics for the kernel emulation of cmpxchg ? IMO it should be fine to 
return 0 or -EFAULT etc. Infact -EFAULT is better as it will force a retry loop on 
user side, given the typical cmpxchg usage pattern.


> +		preempt_enable();
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;
> +
> +	if (val == expected) {
> +		ret = __put_user(new, uaddr);
> +		if (!ret)
>   			regs->status32 |= STATUS_Z_MASK;
>   	}
>   
> -done:
>   	preempt_enable();
>   
> -	return uval;
> +	if (ret == -EFAULT) {
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;
> +
> +	return val;
> +
> +fail:
> +	force_sig(SIGSEGV, current);
> +	return ret;
>   }
>   
>   #ifdef CONFIG_ISA_ARCV2
> 
