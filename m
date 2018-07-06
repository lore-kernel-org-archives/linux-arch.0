Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39658 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeGFQVI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Jul 2018 12:21:08 -0400
Date: Fri, 6 Jul 2018 17:21:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706162100.3iimik242cied2c6@lakrids.cambridge.arm.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
 <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
 <20180706122631.GA30265@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706122631.GA30265@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706162100.lVhP3ANeAYO-GkqqFJUWE1lg9UXgIt0sL01UX3UVS9w@z>

On Fri, Jul 06, 2018 at 08:26:31PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 12:43:52PM +0100, Mark Rutland wrote:
> > Please see the devicetree spec [1], section 2.3.4. Valid values are:
> > 
> > * "okay" // equivalent to no status property present
> > * "disabled"
> > * "fail"
> > * "fail-sss"
> Nice tip, thx.
> 
> > I'm a bit confused. You write (1 << cpu) into cv<29, 0>, to enable a
> > particular CPU, so I assume that bit uniquely identifies a CPU,
> Yes, you're right and cr<29, 0>'s bit uniquely identifies a cpu.
> 
> > and
> > therefore the reg is some unique ID for the CPU.
> static int csky_of_cpu(struct device_node *node)
> {
> 	const char *status;
> 
> 	if (of_property_read_string(node, "status", &status))
> 		status = "okay";
> 
> 	if (strcmp(status, "disabled") == 0)
> 		goto error;
> 
> 	return 1;
> error:
> 	return 0;
> }

Please don't open-code this. Use of_device_is_available(), which checks
the status property itself. e.g.

void __init setup_smp(void)
{
	struct device_node *node = NULL;

	while ((node = of_find_node_by_type(node, "cpu"))) {
		if (!of_device_is_available(node))
			continue;

		...
	}
}

> void __init setup_smp(void)
> {
> 	struct device_node *node = NULL;
> 	int i = 0;
> 
> 	while ((node = of_find_node_by_type(node, "cpu"))) {
> 		if (!csky_of_cpu(node))
> 			continue;
> 
> 		set_cpu_possible(i, true);
> 		set_cpu_present(i, true);
> 
> 		i++;
> 	}
> }
> Hmm?
> 
> No <reg> in next version patch, it's no use.

Please use the reg property, you need it to describe which particular
CPUs are available.

You probably also want a mapping from Linux logical CPU id to your
physical CPU id, and a sanity check on this. See arm64 for an example.

> > I see.
> > 
> > Is this SMP bringup mechanism architectual, or are you likely to need
> > another mechanism to turn on CPUs on future chips?
> It's the only SMP bringup mechanism architectual for C-SKY SMP. There is
> no another way in future and SOC vendor couldn't change it.
> 
> > You probably want to use an enable-method property to describe this.
> No, thx.

Fair enough.

Thanks,
Mark.
