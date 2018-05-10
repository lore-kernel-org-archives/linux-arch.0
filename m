From: Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where
 appropriate
Date: Thu, 10 May 2018 08:59:26 +0100
Message-ID: <6811e06d-ac0d-35a6-7d86-57838d5d7f8e@mips.com>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-8-ebiederm@xmission.com>
 <e0a5bde2-7817-3e05-1c8d-c8fa8f6aa5f2@mips.com> <8736z0s087.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8736z0s087.fsf@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Hi Eric,

On 10/05/18 03:39, Eric W. Biederman wrote:
> Matt Redfearn <matt.redfearn@mips.com> writes:
> 
>> Hi Eric,
>>
>> On 20/04/18 15:37, Eric W. Biederman wrote:
>>> Filling in struct siginfo before calling force_sig_info a tedious and
>>> error prone process, where once in a great while the wrong fields
>>> are filled out, and siginfo has been inconsistently cleared.
>>>
>>> Simplify this process by using the helper force_sig_fault.  Which
>>> takes as a parameters all of the information it needs, ensures
>>> all of the fiddly bits of filling in struct siginfo are done properly
>>> and then calls force_sig_info.
>>>
>>> In short about a 5 line reduction in code for every time force_sig_info
>>> is called, which makes the calling function clearer.
>>>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: James Hogan <jhogan@kernel.org>
>>> Cc: linux-mips@linux-mips.org
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>    arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
>>>    arch/mips/mm/fault.c     | 19 ++++----------
>>>    2 files changed, 23 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>>> index 967e9e4e795e..66ec4b0b484d 100644
>>> --- a/arch/mips/kernel/traps.c
>>> +++ b/arch/mips/kernel/traps.c
>>> @@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
>>>    asmlinkage void do_ov(struct pt_regs *regs)
>>>    {
>>>    	enum ctx_state prev_state;
>>> -	siginfo_t info;
>>> -
>>> -	clear_siginfo(&info);
>>> -	info.si_signo = SIGFPE;
>>> -	info.si_code = FPE_INTOVF;
>>> -	info.si_addr = (void __user *)regs->cp0_epc;
>>>      	prev_state = exception_enter();
>>>    	die_if_kernel("Integer overflow", regs);
>>>    -	force_sig_info(SIGFPE, &info, current);
>>> +	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
>>>    	exception_exit(prev_state);
>>>    }
>>>    @@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
>>>    void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>>>    		     struct task_struct *tsk)
>>>    {
>>> -	struct siginfo si;
>>> -
>>> -	clear_siginfo(&si);
>>> -	si.si_addr = fault_addr;
>>> -	si.si_signo = SIGFPE;
>>> +	int si_code;
>>
>> This is giving build errors in Linux next
>> (https://storage.kernelci.org/next/master/next-20180509/mips/defconfig+kselftest/build.log)
>>
>> si_code would have ended up as 0 before from the clear_siginfo(), but perhaps
> 
> And si_code 0 is not a valid si_code to use with a floating point
> siginfo layout.
> 
>> int si_code = FPE_FLTUNK;
>>
>> Would make a more sensible default?
> 
> FPE_FLTUNK would make a more sensible default.
> 
> I seem to remember someone telling me that case can never happen in
> practice so I have simply not worried about it.  Perhaps I am
> misremembering this.

It probably can't happen in practise - but the issue is that the kernel 
doesn't even compile because -Werror=maybe-uninitialized results in a 
build error since the compiler can't know that one of the branches will 
definitely be taken to set si_code.

Thanks,
Matt

> 
> Eric
> 
