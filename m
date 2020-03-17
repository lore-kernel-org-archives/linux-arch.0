From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
Date: Tue, 17 Mar 2020 16:43:32 +0000
Message-ID: <4eaa8717-78b4-0f28-6e14-9a0765e179c5@arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
 <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
 <20200317155031.GD632169@arrakis.emea.arm.com>
 <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:40394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgCQQnJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 12:43:09 -0400
In-Reply-To: <83aaf9e1-0a8f-4908-577a-23766541b2ba@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark



On 3/17/20 4:40 PM, Vincenzo Frascino wrote:
> Hi Catalin,
> 
> On 3/17/20 3:50 PM, Catalin Marinas wrote:
>> On Tue, Mar 17, 2020 at 03:04:01PM +0000, Vincenzo Frascino wrote:
>>> On 3/17/20 2:38 PM, Catalin Marinas wrote:
>>>> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
> 
> [...]
> 
>>>
>>> Can TASK_SIZE > UINTPTR_MAX on an arm64 system?
>>
>> TASK_SIZE yes on arm64 but not TASK_SIZE_32. I was asking about the
>> arm32 check where TASK_SIZE < UINTPTR_MAX. How does the vdsotest return
>> -EFAULT on arm32? Which code path causes this in the user vdso code?
>>
> 
> Sorry I got confused because you referred to arch/arm/vdso/vgettimeofday.c which
> is the arm64 implementation, not the compat one :)
> 

I stand corrected arch/*arm*/vdso/vgettimeofday.c is definitely the arm32
implemetation... I got completely confused here :)

-- 
Regards,
Vincenzo
