Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:2829 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbbBQHXB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Feb 2015 02:23:01 -0500
Message-ID: <54E2EA83.8080800@huawei.com>
Date: Tue, 17 Feb 2015 15:15:15 +0800
From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com> <20150210122718.GC32052@e104818-lin.cambridge.arm.com> <54DB3B60.4050100@huawei.com> <20150211154054.GD9058@e104818-lin.cambridge.arm.com> <54DDAF2B.2070707@huawei.com> <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, davem@davemloft.net, benh@kernel.crashing.org, deller@gmx.de, hpa@zytor.com, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, jejb@parisc-linux.org, cmetcalf@ezchip.com, "lizefan@huawei.com" <lizefan@huawei.com>, paulus@samba.org, mpe@ellerman.id.au, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, schwidefsky@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150217071515.3GX34C1GEk3aFFBsWN4IDAmV4YOAbyWgDTMRKM90p6I@z>

On 2015/2/13 18:44, Catalin Marinas wrote:
> On Fri, Feb 13, 2015 at 04:00:43PM +0800, Bamvor Jian Zhang wrote:
>> On 2015/2/11 23:40, Catalin Marinas wrote:
>>> On Wed, Feb 11, 2015 at 07:22:08PM +0800, Bamvor Jian Zhang wrote:
>>>> On 2015/2/10 20:27, Catalin Marinas wrote:
>>>>> On Tue, Feb 10, 2015 at 10:10:11AM +0000, Zhang Jian(Bamvor) wrote:
>> ...
>>> The native sigval_t is also a union but on 64-bit big endian, the
>>> sival_int overlaps with the most significant 32-bit of the sival_ptr.
>>> So reading sival_int would always be 0. When the compat siginfo is
>>> copied to user, arm64 reads the native sival_ptr (si_ptr) and converts
>>> it to the compat one, getting the correct 32-bit value. However, other
>>> architectures access sival_int (si_int) instead which breaks with your
>>> get_compat_sigevent() changes.
>>>
>>>>> I think the correct fix is in the arm64 code:
>>>>
>>>> The following code could fix my issue.
>>>
>>> Without any parts of your patch?
>>
>> Yes. As you mentioned above, sival_int overlaps the most significant 32bit
>> of the sival_ptr, it seems that your patch is right if sival_ptr is less than
>> 32bit.
> 
> I don't follow you here. sival_ptr is greater than 32-bit on a 64-bit
> kernel.
Sorry for confuse. I was considering if the pointer in sival_ptr is greater
than 32bit in 64bit application. But it seems that it is not relative to my
issue: We only talk about the 32bit application here.
>>> I think that's correct fix since in the SIGEV_THREAD mq_notify case, we
>>> would not deliver a signal as notification, so the sival_int value is
>>> irrelevant (it would be 0 for big-endian compat tasks because of the
>>> sigval_t union on 64-bit).
>>>
>>> Your patch would work as well but you have to change all the other
>>> architectures to use si_ptr when copying to a compat siginfo.
>>
>> Yeah, it seems that my patch is useful only if the sival_ptr is bigger
>> than 32bit. It need the similar changes with following catalin's patch
>> in the following 64bit architecture:
>>
>> x86:                 arch/x86/ia32/ia32_signal.c
> 
> That's a little endian architecture and the use of ptr_to_compat() looks
> fine to me.
> 
>> tile, s390:          arch/xxx/kernel/compat_signal.c
> 
> s390 uses si_int already, as in my proposed arm64 patch.
> 
> tile seems to be bi-endian, though I couldn't see a Kconfig option, nor
> something defining __BIG_ENDIAN__ in headers or Makefile. I guess it's
> coming from the compiler directly. Anyway, on big endian tile, I we have
> the same issue as on big endian arm64.
> 
>> parisc, sparc, mips: arch/xxx/kernel/signal32.c
> 
> paris, sparc and mips all use si_int instead of si_ptr, so that's fine.
> 
>> powerpc:             arch/xxx/kernel/signal_32.c
> 
> Same for powerpc, it uses si_int instead of si_ptr.
> 
>> cc these maintainers for input.
> 
> I think it's only tile that needs fixing for big endian, something like
> the arm64 patch below:
Agree. I was thinking if it is not very clear that app write to si_ptr in
userspace while kernel only read/write si_int.

regards

bamvor

>>>>> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
>>>>> index e299de396e9b..32601939a3c8 100644
>>>>> --- a/arch/arm64/kernel/signal32.c
>>>>> +++ b/arch/arm64/kernel/signal32.c
>>>>> @@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>>>>  	case __SI_TIMER:
>>>>>  		 err |= __put_user(from->si_tid, &to->si_tid);
>>>>>  		 err |= __put_user(from->si_overrun, &to->si_overrun);
>>>>> -		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
>>>>> -				   &to->si_ptr);
>>>>> +		 err |= __put_user(from->si_int, &to->si_int);
>>>>>  		break;
>>>>>  	case __SI_POLL:
>>>>>  		err |= __put_user(from->si_band, &to->si_band);
>>>>> @@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>>>>  	case __SI_MESGQ: /* But this is */
>>>>>  		err |= __put_user(from->si_pid, &to->si_pid);
>>>>>  		err |= __put_user(from->si_uid, &to->si_uid);
>>>>> -		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
>>>>> +		err |= __put_user(from->si_int, &to->si_int);
>>>>>  		break;
>>>>>  	case __SI_SYS:
>>>>>  		err |= __put_user((compat_uptr_t)(unsigned long)
> 


