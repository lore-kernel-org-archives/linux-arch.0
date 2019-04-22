Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:8378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfDVIsL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Apr 2019 04:48:11 -0400
Message-ID: <1555922585.26198.19.camel@intel.com>
Subject: Re: [PATCH 3/7] thermal/drivers/core: Add init section table for
 self-encapsulation
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 22 Apr 2019 16:43:05 +0800
In-Reply-To: <20190402161256.11044-3-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
         <20190402161256.11044-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20190422084305.dfjwadCgdXL84lE-thgd-eJ4qK4OfarJ79TtNUfawDM@z>

Hi, Daniel,

Thanks for the patches, it looks good to me except this one and patch
4/7.

First, I don't think this is a cyclic dependency issue as they are in
the same module.
Second, I have not read include/asm-generic/vmlinux.lds.h before, it
seems that it is used for architecture specific stuff. Fix a thermal
issue in this way seems overkill to me.

IMO, to make the code clean, we can build the governors as separate
modules just like we do for cpu governors.
This brings to the old commit 80a26a5c22b9("Thermal: build thermal
governors into thermal_sys module"), and that was introduced to fix a
problem when CONFIG_THERMAL is set to 'm'. So I think we can switch
back to the old way as the problem is gone now.

what do you think?

Patch 1,2,5,6,7 applied first.

thanks,
rui

On 二, 2019-04-02 at 18:12 +0200, Daniel Lezcano wrote:
> Currently the governors are declared in their respective files but
> they
> export their [un]register functions which in turn call the
> [un]register
> the governors core's functions. That implies a cyclic dependency
> which is
> not desirable. There is a way to self-encapsulate the governors by
> letting
> them to declare themselves in a __init section table.
> 
> Define the table in the asm generic linker description like the other
> tables and provide the specific macros to deal with.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.h    | 16 ++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index 0df190ed82a7..28d18083e969 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -15,6 +15,22 @@
>  /* Initial state of a cooling device during binding */
>  #define THERMAL_NO_TARGET -1UL
>  
> +/* Init section thermal table */
> +extern struct thermal_governor * __governor_thermal_table[];
> +extern struct thermal_governor * __governor_thermal_table_end[];
> +
> +#define THERMAL_TABLE_ENTRY(table, name)			\
> +        static typeof(name) * __thermal_table_entry_##name	\
> +	__used __section(__##table##_thermal_table)		\
> +		= &name;
> +
> +#define THERMAL_GOVERNOR_DECLARE(name)	THERMAL_TABLE_ENTRY(go
> vernor, name)
> +
> +#define for_each_governor_table(__governor)		\
> +	for (__governor = __governor_thermal_table;	\
> +	     __governor < __governor_thermal_table_end;	\
> +	     __governor++)
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> generic/vmlinux.lds.h
> index f8f6f04c4453..9893a3ed242a 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -239,6 +239,16 @@
>  #define ACPI_PROBE_TABLE(name)
>  #endif
>  
> +#ifdef CONFIG_THERMAL
> +#define THERMAL_TABLE(name)						
> \
> +        . = ALIGN(8);						
> 	\
> +        __##name##_thermal_table = .;				
> 	\
> +        KEEP(*(__##name##_thermal_table))				
> \
> +        __##name##_thermal_table_end = .;
> +#else
> +#define THERMAL_TABLE(name)
> +#endif
> +
>  #define KERNEL_DTB()							
> \
>  	STRUCT_ALIGN();						
> 	\
>  	__dtb_start = .;						
> \
> @@ -609,6 +619,7 @@
>  	IRQCHIP_OF_MATCH_TABLE()					
> \
>  	ACPI_PROBE_TABLE(irqchip)					
> \
>  	ACPI_PROBE_TABLE(timer)					
> 	\
> +	THERMAL_TABLE(governor)					
> 	\
>  	EARLYCON_TABLE()						
> \
>  	LSM_TABLE()
>  
