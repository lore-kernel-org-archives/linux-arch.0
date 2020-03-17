From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v4 18/26] arm64: vdso32: Replace TASK_SIZE_32 check in
 vgettimeofday
Date: Tue, 17 Mar 2020 15:04:01 +0000
Message-ID: <f03a9493-c8c2-e981-f560-b2f437a208e4@arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
 <20200317122220.30393-19-vincenzo.frascino@arm.com>
 <20200317143834.GC632169@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200317143834.GC632169@arrakis.emea.arm.com>
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

Hi Catalin,

On 3/17/20 2:38 PM, Catalin Marinas wrote:
> On Tue, Mar 17, 2020 at 12:22:12PM +0000, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
>> index 54fc1c2ce93f..91138077b073 100644
>> --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
>> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
>> @@ -8,11 +8,14 @@
>>  #include <linux/time.h>
>>  #include <linux/types.h>
>>  
>> +#define VALID_CLOCK_ID(x) \
>> +	((x >= 0) && (x < VDSO_BASES))
>> +
>>  int __vdso_clock_gettime(clockid_t clock,
>>  			 struct old_timespec32 *ts)
>>  {
>>  	/* The checks below are required for ABI consistency with arm */
>> -	if ((u32)ts >= TASK_SIZE_32)
>> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>>  		return -EFAULT;
>>  
>>  	return __cvdso_clock_gettime32(clock, ts);
> 
> I probably miss something but I can't find the TASK_SIZE check in the
> arch/arm/vdso/vgettimeofday.c code. Is this done elsewhere?

Can TASK_SIZE > UINTPTR_MAX on an arm64 system?

> 
>> @@ -22,7 +25,7 @@ int __vdso_clock_gettime64(clockid_t clock,
>>  			   struct __kernel_timespec *ts)
>>  {
>>  	/* The checks below are required for ABI consistency with arm */
>> -	if ((u32)ts >= TASK_SIZE_32)
>> +	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>>  		return -EFAULT;
>>  
>>  	return __cvdso_clock_gettime(clock, ts);
>> @@ -38,9 +41,12 @@ int __vdso_clock_getres(clockid_t clock_id,
>>  			struct old_timespec32 *res)
>>  {
>>  	/* The checks below are required for ABI consistency with arm */
>> -	if ((u32)res >= TASK_SIZE_32)
>> +	if ((u32)res > UINTPTR_MAX - sizeof(res) + 1)
>>  		return -EFAULT;
>>  
>> +	if (!VALID_CLOCK_ID(clock_id) && res == NULL)
>> +		return -EINVAL;
> 
> This last check needs an explanation. If the clock_id is invalid but res
> is not NULL, we allow it. I don't see where the compatibility issue is,
> arm32 doesn't have such check.
> 

The case that you are describing has to return -EPERM per ABI spec. This case
has to return -EINVAL.

The first case is taken care from the generic code. But if we don't do this
check before on arm64 compat we end up returning the wrong error code.

For the non compat case the same is taken care from the syscall fallback [1].

[1] lib/vdso/gettimeofday.c

-- 
Regards,
Vincenzo
