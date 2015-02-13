From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
Date: Fri, 13 Feb 2015 16:00:43 +0800
Message-ID: <54DDAF2B.2070707@huawei.com>
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com> <20150210122718.GC32052@e104818-lin.cambridge.arm.com> <54DB3B60.4050100@huawei.com> <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:35778 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbBMICK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Feb 2015 03:02:10 -0500
In-Reply-To: <20150211154054.GD9058@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lizefan@huawei.com" <lizefan@huawei.com>, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, ralf@linux-mips.org, cmetcalf@ezchip.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net

On 2015/2/11 23:40, Catalin Marinas wrote:
> On Wed, Feb 11, 2015 at 07:22:08PM +0800, Bamvor Jian Zhang wrote:
>> On 2015/2/10 20:27, Catalin Marinas wrote:
>>> On Tue, Feb 10, 2015 at 10:10:11AM +0000, Zhang Jian(Bamvor) wrote:
...
> The native sigval_t is also a union but on 64-bit big endian, the
> sival_int overlaps with the most significant 32-bit of the sival_ptr.
> So reading sival_int would always be 0. When the compat siginfo is
> copied to user, arm64 reads the native sival_ptr (si_ptr) and converts
> it to the compat one, getting the correct 32-bit value. However, other
> architectures access sival_int (si_int) instead which breaks with your
> get_compat_sigevent() changes.
> 
>>> I think the correct fix is in the arm64 code:
>>
>> The following code could fix my issue.
> 
> Without any parts of your patch?
Yes. As you mentioned above, sival_int overlaps the most significant 32bit
of the sival_ptr, it seems that your patch is right if sival_ptr is less than
32bit.

> I think that's correct fix since in the SIGEV_THREAD mq_notify case, we
> would not deliver a signal as notification, so the sival_int value is
> irrelevant (it would be 0 for big-endian compat tasks because of the
> sigval_t union on 64-bit).
> 
> Your patch would work as well but you have to change all the other
> architectures to use si_ptr when copying to a compat siginfo.
Yeah, it seems that my patch is useful only if the sival_ptr is bigger
than 32bit. It need the similar changes with following catalin's patch
in the following 64bit architecture:
x86:                 arch/x86/ia32/ia32_signal.c
tile, s390:          arch/xxx/kernel/compat_signal.c
parisc, sparc, mips: arch/xxx/kernel/signal32.c
powerpc:             arch/xxx/kernel/signal_32.c

cc these maintainers for input.

regards

bamvor

>>> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
>>> index e299de396e9b..32601939a3c8 100644
>>> --- a/arch/arm64/kernel/signal32.c
>>> +++ b/arch/arm64/kernel/signal32.c
>>> @@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>>  	case __SI_TIMER:
>>>  		 err |= __put_user(from->si_tid, &to->si_tid);
>>>  		 err |= __put_user(from->si_overrun, &to->si_overrun);
>>> -		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
>>> -				   &to->si_ptr);
>>> +		 err |= __put_user(from->si_int, &to->si_int);
>>>  		break;
>>>  	case __SI_POLL:
>>>  		err |= __put_user(from->si_band, &to->si_band);
>>> @@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>>  	case __SI_MESGQ: /* But this is */
>>>  		err |= __put_user(from->si_pid, &to->si_pid);
>>>  		err |= __put_user(from->si_uid, &to->si_uid);
>>> -		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
>>> +		err |= __put_user(from->si_int, &to->si_int);
>>>  		break;
>>>  	case __SI_SYS:
>>>  		err |= __put_user((compat_uptr_t)(unsigned long)
> 
