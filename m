From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/24] C6X: early boot code
Date: Tue, 9 Aug 2011 18:12:35 +0200
Message-ID: <201108091812.35688.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-6-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57999 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab1HIQMm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:12:42 -0400
In-Reply-To: <1312839879-13592-6-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:

> +static const char *cpu_name, *cpu_voltage, *mmu, *fpu;
> +static char *soc_rev;
> +static char __cpu_rev[5], *cpu_rev;
> +static size_t initrd_size = CONFIG_BLK_DEV_RAM_SIZE*1024;
> +static unsigned int core_id;

Better make a data structure for the elements that you have per CPU,
that will help you when you get to SMP.

> +static void __init probe_machine(void)
> +{
> +	/*
> +	 * Iterate all c6x_md structures until we find the proper
> +	 * one for the current machine type
> +	 */
> +	for (machine_id = &__machine_desc_start;
> +	     machine_id < &__machine_desc_end;
> +	     machine_id++) {
> +		memcpy(&c6x_md, machine_id, sizeof(struct machdep_calls));
> +		if (c6x_md.probe())
> +			break;
> +	}
> +	/* What can we do if we didn't find ? */
> +	if (machine_id >= &__machine_desc_end) {
> +		DBG("No suitable machine found !\n");
> +		for (;;)
> +			;
> +	}
> +
> +	printk(KERN_INFO "Using %s machine description\n", c6x_md.name);
> +}

Why do you need separate machine descriptors? Since you can do all probing
through the device tree, you should not need to copy the complexity of
architectures that don't use it everywhere yet.

> +
> +static int show_cpuinfo(struct seq_file *m, void *v)
> +{
> +	seq_printf(m,
> +		   "CPU:\t\t%s\n"
> +		   "Core revision:\t%s\n"
> +		   "Core voltage:\t%s\n"
> +		   "Core id:\t%d\n"
> +		   "SoC cores:\t%d\n"
> +		   "MMU:\t\t%s\n"
> +		   "FPU:\t\t%s\n"
> +		   "Silicon rev:\t%s\n"
> +		   "Clocking:\t%uMHz\n"
> +		   "BogoMips:\t%lu.%02lu\n"
> +		   "Calibration:\t%lu loops\n",
> +		   cpu_name, cpu_rev, cpu_voltage,
> +		   core_id, c6x_num_cores, mmu, fpu,
> +		   soc_rev, (c6x_core_freq + 500000) / 1000000,
> +		   (loops_per_jiffy/(500000/HZ)),
> +		   (loops_per_jiffy/(5000/HZ))%100,
> +		   loops_per_jiffy);
> +
> +	return 0;
> +}

The fields are commonly all lowercase. Start with a line 'processor:\t0' to make it
easier to extend for multiple CPUs.

Out of "Clocking", "BogoMips" and "Calibration", you probably should have
only one, since they are all interdependent.

	Arnd
