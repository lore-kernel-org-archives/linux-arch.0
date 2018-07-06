Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbeGFFYm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Jul 2018 01:24:42 -0400
Date: Fri, 6 Jul 2018 06:24:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706052432.q74gql32dtj5gj3b@salmiak>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706052433.RSoJmmX67c3UMLnyFx0vtPHn9sE8kdOpqQ7u7xDK_hY@z>

On Mon, Jul 02, 2018 at 01:30:19AM +0800, Guo Ren wrote:
> +static int csky_of_cpu(struct device_node *node)
> +{
> +	const char *status;
> +	int cpu;
> +
> +	if (of_property_read_u32(node, "reg", &cpu))
> +		goto error;
> +
> +	if (cpu >= NR_CPUS)
> +		goto error;
> +
> +	if (of_property_read_string(node, "status", &status))
> +		status = "enable";
> +
> +	if (strcmp(status, "disable") == 0)
> +		goto error;

Please use of_device_is_available(node); "enable" is not a sensible value for
the status property, and "disable" (rather than "disabled") is simply unusual.

Neither "enable" nor "disable" are correct values for the status property.

What is the value in the reg property, exactly? Is there a unique ID in
hardware for each CPU in the system?

It would be good to document this, e.g. as arm does in
Documentation/devicetree/bindings/arm/cpus.txt

> +
> +	return cpu;
> +error:
> +	return -ENODEV;
> +}
> +
> +void __init setup_smp(void)
> +{
> +	struct device_node *node = NULL;
> +	int cpu;
> +
> +	while ((node = of_find_node_by_type(node, "cpu"))) {
> +		cpu = csky_of_cpu(node);
> +		if (cpu >= 0) {
> +			set_cpu_possible(cpu, true);
> +			set_cpu_present(cpu, true);
> +		}
> +	}
> +}

What happens if/when the value in the reg property is larger than NR_CPUS?

> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +{
> +	unsigned int tmp;
> +
> +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> +
> +	secondary_hint = mfcr("cr31");
> +
> +	secondary_ccr  = mfcr("cr18");
> +
> +	pr_info("%s: CPU%u\n", __func__, cpu);
> +
> +	tmp = mfcr("cr<29, 0>");
> +	tmp |= 1 << cpu;
> +	mtcr("cr<29, 0>", tmp);
> +
> +	while (!cpu_online(cpu));
> +
> +	secondary_stack = 0;
> +
> +	return 0;
> +}

I don't see a start address being setup here, so I assume that CPUs branch to a
fixed address out-of-reset. Does that mean that the kernel has to be loaded at
a particular physical address on a given platform?

Thanks,
Mark.
