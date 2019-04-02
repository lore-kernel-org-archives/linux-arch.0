Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfDBKMj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 06:12:39 -0400
Subject: Re: [PATCH 4/4] arm64: compat: Add KUSER_HELPERS config option
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-5-vincenzo.frascino@arm.com>
 <20190401144855.GJ14874@arrakis.emea.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <4a56f2ed-9325-a6c1-7005-9e7e64a787fe@arm.com>
Date: Tue, 2 Apr 2019 11:12:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190401144855.GJ14874@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190402101237.VU8EwpA_K21D83-klv-I32O4w2RiuoUlqEovKqHCT8Q@z>

On 01/04/2019 15:48, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:20:25PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7e34b9eba5de..35c98e91bfeb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1494,6 +1494,36 @@ config COMPAT
>>  
>>  	  If you want to execute 32-bit userspace applications, say Y.
>>  
>> +config KUSER_HELPERS
>> +	bool "Enable kuser helpers page for compatibility with 32 bit applications."
> 
> I'd say only "Enable kuser helpers page for 32-bit applications" (my
> first reading of this sounded like it would be enabled for 64-bit apps
> to be on par with 32-bit ones).
> 

Ok, I agree, it can be misleading.

>> +	depends on COMPAT
>> +	default y
>> +	help
>> +	  Warning: disabling this option may break user programs.
> 
> "may break 32-bit user programs."
> 

Ok.

>> +
>> +	  Provide kuser helpers to compat tasks. The kernel provides
>> +	  helper code to userspace in read only form at a fixed location
>> +	  to allow userspace to be independent of the CPU type fitted to
>> +	  the system. This permits binaries to be run on ARMv4 through
>> +	  to ARMv8 without modification.
>> +
>> +	  See Documentation/arm/kernel_user_helpers.txt for details.
>> +
>> +	  However, the fixed address nature of these helpers can be used
>> +	  by ROP (return orientated programming) authors when creating
>> +	  exploits.
>> +
>> +	  If all of the binaries and libraries which run on your platform
>> +	  are built specifically for your platform, and make no use of
>> +	  these helpers, then you can turn this option off to hinder
>> +	  such exploits. However, in that case, if a binary or library
>> +	  relying on those helpers is run, it will not function correctly.
>> +
>> +	  Note: kuser helpers is disabled by default with 64K pages.
> 
> Is it?
> 

Oops... I removed it from all the places except here. Will fix in v2.

>> +
>> +	  Say N here only if you are absolutely certain that you do not
>> +	  need these helpers; otherwise, the safe option is to say Y.
>> +
> 

-- 
Regards,
Vincenzo
