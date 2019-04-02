From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 4/4] arm64: compat: Add KUSER_HELPERS config option
Date: Tue, 2 Apr 2019 11:12:37 +0100
Message-ID: <4a56f2ed-9325-a6c1-7005-9e7e64a787fe@arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-5-vincenzo.frascino@arm.com>
 <20190401144855.GJ14874@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401144855.GJ14874@arrakis.emea.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
