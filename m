From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v6 15/19] arm64: Add vDSO compat support
Date: Tue, 4 Jun 2019 13:10:31 +0100
Message-ID: <2027e092-2d76-9350-6c5b-7d3debc6a93f@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-16-vincenzo.frascino@arm.com>
 <20190601093830.GA13589@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601093830.GA13589@arrakis.emea.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
List-Id: linux-arch.vger.kernel.org

Hi Catalin,

thank you for testing my patches and providing the scripts you used to reproduce
the issue.

On 01/06/2019 10:38, Catalin Marinas wrote:
> On Thu, May 30, 2019 at 03:15:27PM +0100, Vincenzo Frascino wrote:
>> Add vDSO compat support to the arm64 building system.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/Kconfig         |  1 +
>>  arch/arm64/Makefile        | 23 +++++++++++++++++++++--
>>  arch/arm64/kernel/Makefile |  6 +++++-
>>  3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 952c9f8cf3b8..3e1d4f8347f4 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -108,6 +108,7 @@ config ARM64
>>  	select GENERIC_STRNLEN_USER
>>  	select GENERIC_TIME_VSYSCALL
>>  	select GENERIC_GETTIMEOFDAY
>> +	select GENERIC_COMPAT_VDSO if !CPU_BIG_ENDIAN
> 
> This select needs to also depend on COMPAT (or rather be selected from
> the COMPAT menuconfig), otherwise, trying to build this series with 64K
> pages where COMPAT is disabled, I get:
> 

This is a very good catch, my bad, will definitely fix in v7.

...

-- 
Regards,
Vincenzo
