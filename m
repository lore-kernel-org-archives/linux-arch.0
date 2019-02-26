Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfBZMKd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 07:10:33 -0500
Subject: Re: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-9-vincenzo.frascino@arm.com>
 <20190222140427.GI42419@lakrids.cambridge.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9a74d54f-5500-3276-64fa-c838f85bc69c@arm.com>
Date: Tue, 26 Feb 2019 12:10:28 +0000
MIME-Version: 1.0
In-Reply-To: <20190222140427.GI42419@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190226121028.k1f4vfqF5Cyou5ifypc7Kho38tvq6mgtUeG1T60Lmxk@z>

Hi Mark,

thank you for your review.

On 22/02/2019 14:04, Mark Rutland wrote:
> On Fri, Feb 22, 2019 at 12:24:15PM +0000, Vincenzo Frascino wrote:
>> When kuser helpers are enabled the kernel maps the relative code at
>> a fixed address (0xffff0000). Making configurable the option to disable
>> them means that the kernel can remove this mapping and any access to
>> this memory area results in a sigfault.
>>
>> Add a KUSER_HELPERS config option that can be used to disable the
>> mapping when it is turned off.
>>
>> This option can be turned off if and only if the applications are
>> designed specifically for the platform and they do not make use of the
>> kuser helpers code.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> IIUC, the KUSER bits aren't striclty dependent on the rest of the vDSO
> changes.
> 
> I think the KUSER bits should be split into a preparatory series, so that they
> can be merged soon, rather than tying them artificially to the rest of the vDSO
> bits (which I expect will require significantly more review).
> 

This is a good point. I will extract them and post as a separate patch set.
In doing so I will update the config description below.

-- 
Regards,
Vincenzo

>> ---
>>  arch/arm64/Kconfig          | 21 +++++++++++++++++++++
>>  arch/arm64/kernel/Makefile  |  3 ++-
>>  arch/arm64/kernel/kuser32.S |  7 +++----
>>  arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
>>  4 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index d898da2e20f5..ed3290494f1c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1465,6 +1465,27 @@ config COMPAT
>>  
>>  	  If you want to execute 32-bit userspace applications, say Y.
>>  
>> +config KUSER_HELPERS
>> +	bool "Enable kuser helpers page for compatibility with 32 bit applications."
>> +	depends on COMPAT
>> +	default y
>> +	help
>> +	  Enables kuser helpers to be mapped in a special purpose page at a fixed
>> +	  address to maintain independence from the type of CPU present in the SoC.
>> +	  This feature is provided for compatibility reasons in fact allows 32 bit
>> +	  applications compliant with ARMv4 up to ARMv8 to run without any
>> +	  modification.
>> +
>> +	  Warning: Being always mapped at a fixed address makes it easier to create
>> +	  exploits based on ROP type of attacks.
>> +
>> +	  As a consequence of this, this feature is made configurable but be aware that
>> +	  it can be turned off if and only if the binaries and the libraries running on
>> +	  a specific platform are designed to do not make use of these helpers, otherwise
>> +	  should be left on.
>> +
>> +	  See Documentation/arm/kernel_user_helpers.txt for details.
> 
> This is quite divergent from the text for the 32-bit arm KUSER_HELPERS.
> 
> Could we please reuse that existing text as far as possible, with minimal
> changes?
> 
> e.g.
> 
> config KUSER_HELPERS
> 	bool "Enable kuser helpers for compat tasks"
> 	depends on COMPAT
> 	default y
> 	help
> 	  Warning: disabling this option may break user programs.
> 
> 	  Provide kuser helpers to compat tasks. The kernel provides
> 	  helper code to userspace in read only form at a fixed location
> 	  to allow userspace to be independent of the CPU type fitted to
> 	  the system. This permits binaries to be run on ARMv4 through
> 	  to ARMv8 without modification.
> 
> 	  See Documentation/arm/kernel_user_helpers.txt for details.
> 
> 	  However, the fixed address nature of these helpers can be used
> 	  by ROP (return orientated programming) authors when creating
> 	  exploits.
> 
> 	  If all of the binaries and libraries which run on your platform
> 	  are built specifically for your platform, and make no use of
> 	  these helpers, then you can turn this option off to hinder
> 	  such exploits. However, in that case, if a binary or library
> 	  relying on those helpers is run, it will not function correctly.
> 
> 	  Say N here only if you are absolutely certain that you do not
> 	  need these helpers; otherwise, the safe option is to say Y.
> 
> I believe that Will wanted to default the kuser helpers off, as applications
> using them need the instruction emulation which is also disabled by default.
> 
> I'm also not sure which binaries we expect to work on arm64, so I'm not sure if
> the ARMv4 reference is correct.
> 
> Thanks,
> Mark.
> 
