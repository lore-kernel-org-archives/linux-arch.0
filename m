From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Date: Fri, 6 Jul 2018 12:43:52 +0100
Message-ID: <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706113200.GA27148@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 06, 2018 at 07:32:01PM +0800, Guo Ren wrote:
> On Fri, Jul 06, 2018 at 06:24:33AM +0100, Mark Rutland wrote:
> > > +	if (cpu >= NR_CPUS)
> > > +		goto error;
> > > +
> > > +	if (of_property_read_string(node, "status", &status))
> > > +		status = "enable";
> > > +
> > > +	if (strcmp(status, "disable") == 0)
> > > +		goto error;
> > 
> > Please use of_device_is_available(node); 
> Ok.
> 
> > "enable" is not a sensible value for
> > the status property, and "disable" (rather than "disabled") is simply unusual.
> > 
> > Neither "enable" nor "disable" are correct values for the status property.
> 
> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		cpu@0 {
> 			device_type = "cpu";
> 			reg = <0>;
> 			status = "on";
> 		};
> 
> 		cpu@1 {
> 			device_type = "cpu";
> 			reg = <1>;
> 			status = "off";
> 		};
> 	};

Neither "on" nor "off" are standard status values either.

Please see the devicetree spec [1], section 2.3.4. Valid values are:

* "okay" // equivalent to no status property present
* "disabled"
* "fail"
* "fail-sss"

> > What is the value in the reg property, exactly?
> See above, I'll remove the reg property and it's no use.
> 
> > Is there a unique ID in
> > hardware for each CPU in the system?
> There is no unique ID in current CPU: ck860.

I'm a bit confused. You write (1 << cpu) into cv<29, 0>, to enable a
particular CPU, so I assume that bit uniquely identifies a CPU, and
therefore the reg is some unique ID for the CPU.

[...]

> > > +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> > > +{
> > > +	unsigned int tmp;
> > > +
> > > +	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
> > > +
> > > +	secondary_hint = mfcr("cr31");
> > > +
> > > +	secondary_ccr  = mfcr("cr18");
> > > +
> > > +	pr_info("%s: CPU%u\n", __func__, cpu);
> > > +
> > > +	tmp = mfcr("cr<29, 0>");
> > > +	tmp |= 1 << cpu;
> > > +	mtcr("cr<29, 0>", tmp);
> > > +
> > > +	while (!cpu_online(cpu));
> > > +
> > > +	secondary_stack = 0;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I don't see a start address being setup here, so I assume that CPUs branch to a
> > fixed address out-of-reset. Does that mean that the kernel has to be loaded at
> > a particular physical address on a given platform?
> No, not a fixed address. I put it arch/csky/kernel/traps.c:79-83
> trap_init()
> #ifdef CONFIG_SMP
> 	mtcr("cr<28, 0>", virt_to_phys(vec_base));
> 
> 	VEC_INIT(VEC_RESET, (void *)virt_to_phys(_start_smp_secondary));
> #endi

I see.

Is this SMP bringup mechanism architectual, or are you likely to need
another mechanism to turn on CPUs on future chips?

You probably want to use an enable-method property to describe this.

Thanks,
Mark.

[1] https://www.devicetree.org/specifications/
