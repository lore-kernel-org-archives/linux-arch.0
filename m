Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0053.outbound.protection.outlook.com ([157.56.112.53]:6592
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752515AbbBMV4n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Feb 2015 16:56:43 -0500
Message-ID: <54DE730D.3090100@ezchip.com>
Date: Fri, 13 Feb 2015 16:56:29 -0500
From: Chris Metcalf <cmetcalf@ezchip.com>
MIME-Version: 1.0
Subject: Re: [PATCH] compat: Fix endian issue in union sigval
References: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com> <20150210122718.GC32052@e104818-lin.cambridge.arm.com> <54DB3B60.4050100@huawei.com> <20150211154054.GD9058@e104818-lin.cambridge.arm.com> <54DDAF2B.2070707@huawei.com> <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150213104455.GA3508@e104818-lin.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, davem@davemloft.net, benh@kernel.crashing.org, deller@gmx.de, hpa@zytor.com, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, jejb@parisc-linux.org, "lizefan@huawei.com" <lizefan@huawei.com>, paulus@samba.org, mpe@ellerman.id.au, "dingtianhong@huawei.com" <dingtianhong@huawei.com>, schwidefsky@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150213215629.FKWrlkVBRhFOygQV_u4LKiuTtVjYazoHRWgtRcgex08@z>

On 2/13/2015 5:44 AM, Catalin Marinas wrote:
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
>
>> tile, s390:          arch/xxx/kernel/compat_signal.c
>
> tile seems to be bi-endian, though I couldn't see a Kconfig option, nor
> something defining __BIG_ENDIAN__ in headers or Makefile. I guess it's
> coming from the compiler directly.

Yes, we just pick up the compiler's __BIG_ENDIAN__ if specified.

> Anyway, on big endian tile, I we have
> the same issue as on big endian arm64.
>
> I think it's only tile that needs fixing for big endian, something like
> the arm64 patch below:
>
>> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
>> index e299de396e9b..32601939a3c8 100644
>> --- a/arch/arm64/kernel/signal32.c
>> +++ b/arch/arm64/kernel/signal32.c
>> @@ -154,8 +154,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>   	case __SI_TIMER:
>>   		 err |= __put_user(from->si_tid, &to->si_tid);
>>   		 err |= __put_user(from->si_overrun, &to->si_overrun);
>> -		 err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr,
>> -				   &to->si_ptr);
>> +		 err |= __put_user(from->si_int, &to->si_int);
>>   		break;
>>   	case __SI_POLL:
>>   		err |= __put_user(from->si_band, &to->si_band);
>> @@ -184,7 +183,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
>>   	case __SI_MESGQ: /* But this is */
>>   		err |= __put_user(from->si_pid, &to->si_pid);
>>   		err |= __put_user(from->si_uid, &to->si_uid);
>> -		err |= __put_user((compat_uptr_t)(unsigned long)from->si_ptr, &to->si_ptr);
>> +		err |= __put_user(from->si_int, &to->si_int);
>>   		break;
>>   	case __SI_SYS:
>>   		err |= __put_user((compat_uptr_t)(unsigned long)

I must be confused here, but I don't see that these do anything different.

If we are writing 32 bits to to->si_ptr or to->si_int, either way the high 32 bits
are irrelevant.  So whether we read it from from->si_ptr and massage the high bits,
or just read it from from->si_int as a straight-up 32-bit quantity, either way it
seems we should end up writing the same bits to userspace.

I would understand the argument if we were overlaying the si_ptr/si_int union
from a kernel-side siginfo_t where si_ptr and si_int are different sizes
onto userspace, but it doesn't seem we ever do that.

All that said, it certainly seems like the si_int version is simpler, so I don't have
a problem with switching to it, but I don't see how it fixes a problem.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

