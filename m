From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] cpuinfo: add sysfs based arch independent cpuinfo
 framework
Date: Fri, 6 Dec 2019 17:33:58 +0100
Message-ID: <20191206163358.GB86904@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-2-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-2-trenn@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-arch@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, Felix Schnizlein <fschnizlein@suse.com>, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, fschnitzlein@suse.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 06, 2019 at 05:24:19PM +0100, Thomas Renninger wrote:
> --- /dev/null
> +++ b/drivers/base/cpuinfo.c
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright (C) 2017 SUSE Linux GmbH
> + * Written by: Felix Schnizlein <fschnizlein@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + */

No SPDX line?  And you can drop the license boilerplate text as well
too.

> +
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/cpuinfo.h>
> +
> +static struct attribute_group cpuinfo_attr_group = {
> +	.attrs = cpuinfo_attrs,
> +	.name = "info"
> +};
> +
> +static int cpuinfo_add_dev(unsigned int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	return sysfs_create_group(&dev->kobj, &cpuinfo_attr_group);

Why are a set of attributes being added _after_ the device is created?
We have fixed up a lot of the "default attribute" logic since 2017,
perhaps you should be using that instead?


> +}
> +
> +static int cpuinfo_remove_dev(unsigned int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	sysfs_remove_group(&dev->kobj, &cpuinfo_attr_group);

Same here, I don't think this is needed.

> +	return 0;
> +}
> +
> +static int cpuinfo_sysfs_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_CPUINFO_PREPARE,
> +				 "base/cpuinfo:prepare",
> +				 cpuinfo_add_dev,
> +				 cpuinfo_remove_dev);
> +}
> +
> +device_initcall(cpuinfo_sysfs_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e51ee772b9f5..2c4c59304bdb 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -78,6 +78,7 @@ enum cpuhp_state {
>  	CPUHP_SH_SH3X_PREPARE,
>  	CPUHP_NET_FLOW_PREPARE,
>  	CPUHP_TOPOLOGY_PREPARE,
> +	CPUHP_CPUINFO_PREPARE,
>  	CPUHP_NET_IUCV_PREPARE,
>  	CPUHP_ARM_BL_PREPARE,
>  	CPUHP_TRACE_RB_PREPARE,
> diff --git a/include/linux/cpuinfo.h b/include/linux/cpuinfo.h
> new file mode 100644
> index 000000000000..112ff76d64d5
> --- /dev/null
> +++ b/include/linux/cpuinfo.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (C) 2017 SUSE Linux GmbH
> + * Written by: Felix Schnizlein <fschnizlein@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version
> + * 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.

SPDX and boilerplate.


> + */
> +#ifndef _LINUX_CPUINFO_H
> +#define _LINUX_CPUINFO_H
> +
> +#ifdef CONFIG_HAVE_CPUINFO_SYSFS
> +extern struct attribute *cpuinfo_attrs[];

No need for thie #ifdef really, right?

thanks,

greg k-h
