From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Date: Wed, 18 Apr 2018 11:16:47 -0700
Message-ID: <b4d35ed5-9e60-84c4-1081-c5d41498f189@synopsys.com>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
 <5bc39838-b1c5-ef65-f97d-8777ed33bda0@synopsys.com>
 <1521633274.9805.30.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521633274.9805.30.camel@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "wbx@uclibc-ng.org" <wbx@uclibc-ng.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On 03/21/2018 04:54 AM, Alexey Brodkin wrote:
> /*
>>>    	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
>>> @@ -60,23 +62,48 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>>>    	/* Z indicates to userspace if operation succeded */
>>>    	regs->status32 &= ~STATUS_Z_MASK;
>>>    
>>> -	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
>>> -		return -EFAULT;
>>> +	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
>>> +	if (!ret)
>>> +		goto fail;
>>>    
>>> +again:
>>>    	preempt_disable();
>>>    
>>> -	if (__get_user(uval, uaddr))
>>> -		goto done;
>>> -
>>> -	if (uval == expected) {
>>> -		if (!__put_user(new, uaddr))
>>> +	ret = __get_user(val, uaddr);
>>> +	if (ret == -EFAULT) {
>>
>> Lets see if this warrants adding complexity ! This implies that TLB entry with
>> Read permissions didn't exist for reading the var and page fault handler could not
>> wire up even a zero page due to preempt_disable, meaning it was something not
>> touched by userspace already - sort of uninitialized variable in user code.
> Ok I completely missed the fact that fast path TLB miss handler is being
> executed even if we have preemption disabled. So given the mapping exist
> we do not need to retry with enabled preemption.
>
> Still maybe I'm a bit paranoid here but IMHO it's good to be ready for a corner-case
> when the pointer is completely bogus and there's no mapping for him.
> I understand that today we only expect this syscall to be used from libc's
> internals but as long as syscall exists nobody stops anybody from using it
> directly without libc. So maybe instead of doing get_user_pages_fast() just
> send a SIGSEGV to the process? At least user will realize there's some problem
> at earlier stage.

if the pointer is bogus, we currently return -EFAULT, is that not enough ! I'm 
fine if u want to change that to segv.

>> Otherwise it is extremely unlikely to start with a TLB entry with Read
>> permissions, followed by syscall Trap only to find the entry missing, unless a
>> global TLB flush came from other cores, right in the middle. But this syscall is
>> not guaranteed to work with SMP anyways, so lets ignore any SMP misdoings here.
> Well but that's exactly the situation I was debugging: we start from data from read-only
> page and on attempt to write back modified value COW machinery gets involved.

No exactly your situation. In your case the TLB entry *did* exist with Read 
permission. What I was pointing to is that case where it woudl vanish between user 
reading the backing page and making a syscall !

>
>> Now in case it was *an* uninitialized var, do we have to guarantee any well
>> defined semantics for the kernel emulation of cmpxchg ? IMO it should be fine to
>> return 0 or -EFAULT etc. Infact -EFAULT is better as it will force a retry loop on
>> user side, given the typical cmpxchg usage pattern.
> The problem is libc only expects to get a value read from memory.
> And in theory expected value might be -14 which is basically -EFAULT.
> I'm not talking about 0 at all because in some cases that's exactly what
> user-space expects.
>
> So if we read unexpected value then we'll just return it without even attempting
> to write.
>
> If we read expected data but fail to write then we'll send a SIGSEGV and
> return whatever... let it be -EFAULT - anyways the app will be killed on exit from
> this syscall.

I'm not sure what you mean here. I'm fine with adding segv kill semantics, but 
don't think complexity for get_user is worth it !

-Vineet
