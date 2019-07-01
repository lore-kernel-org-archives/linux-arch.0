From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v4 2/2] Drivers: hv: Move Hyper-V clocksource code to new
 clocksource driver
Date: Mon, 1 Jul 2019 03:27:46 +0000
Message-ID: <BL0PR2101MB1348F33B06FEAFFD4AC5474ED7F90@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <1561746758-23216-1-git-send-email-mikelley@microsoft.com>
 <1561746758-23216-3-git-send-email-mikelley@microsoft.com>
 <alpine.DEB.2.21.1906290850220.1802@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1906290850220.1802@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "shuah@kernel.org" <shuah@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, KY Srinivasan <kys@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Saturday, June 29, 2019 12:04 AM
> 
> On Fri, 28 Jun 2019, Michael Kelley wrote:
> 
> See the other reply vs. prefix and summary
> 
> > Continue consolidating Hyper-V clock and timer code into an ISA
> ...
> 
> > +#ifdef CONFIG_HYPERV_TSCPAGE
> > +
> > +static struct ms_hyperv_tsc_page *tsc_pg;
> > +
> > +struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> > +{
> > +	return tsc_pg;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_get_tsc_page);
> 
> > +static u64 read_hv_sched_clock_tsc(void)
> 
> Lacks a notrace annotation as it is used as sched clock.

Will add to this and to read_hv_sched_clock_msr().

> 
> > +{
> > +	u64 current_tick = hv_read_tsc_page(tsc_pg);
> > +
> > +	if (current_tick == U64_MAX)
> > +		hv_get_time_ref_count(current_tick);
> > +
> > +	return current_tick;
> > +}
> > +
> > +static u64 read_hv_clock_tsc(struct clocksource *arg)
> > +{
> > +	return read_hv_sched_clock_tsc();
> > +}
> > +
> > +static struct clocksource hyperv_cs_tsc = {
> > +		.name		= "hyperv_clocksource_tsc_page",
> > +		.rating		= 400,
> > +		.read		= read_hv_clock_tsc,
> > +		.mask		= CLOCKSOURCE_MASK(64),
> > +		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> 
> One tab indent is sufficient

Will fix.

> 
> > +};
> > +#endif
> 
> > +void __init hv_init_clocksource(void)
> > +{
> > +#ifdef CONFIG_HYPERV_TSCPAGE
> 
> Can you please avoid ifdef blocks in the code and just split out this into
> a helper function and provide an empty stub for the TSCPAGE=n case?
> 
> Then you can spare one indent and the ifdeffery is confined. Get's rid of
> the goto as well.

I was trying not to change code unrelated to reorganizing into a clocksource
driver, but I've coded the approach you suggest and the result is a lot
cleaner.  I'll include the new approach in v5 of the patch.

> 
> > +	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
> > +
> > +		u64		tsc_msr;
> > +		phys_addr_t	phys_addr;
> > +
> > +		tsc_pg = vmalloc(PAGE_SIZE);
> > +		if (!tsc_pg)
> > +			goto register_msr_cs;
> > +
> > +		hyperv_cs = &hyperv_cs_tsc;
> > +		phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
> > +
> > +		/* The Hyper-V TLFS specifies to preserve the value of
> 
> Please use proper multi line comments formatting:
> 
> 		/*
> 		 * This is a proper formatted multi-line comment.
> 		 * See?
> 		 */

Argh.  Old habits ...

> 
> > +		 * reserved bits in registers.  So read the existing
> > +		 * value, preserve the low order 12 bits, and add in
> > +		 * the guest physical address (which already has at
> > +		 * least the low 12 bits set to zero since it is page
> > +		 * aligned). Also set the "enable" bit, which is bit 0.
> > +		 */
> > +		hv_get_reference_tsc(tsc_msr);
> > +		tsc_msr &= GENMASK_ULL(11, 0);
> > +		tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
> > +		hv_set_reference_tsc(tsc_msr);
> > +
> > +		hv_set_clocksource_vdso(hyperv_cs_tsc);
> > +		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> > +
> > +		/*
> > +		 * sched_clock_register is needed on ARM64 but
> > +		 * is a no-op on x86
> > +		 */
> > +		sched_clock_register(read_hv_sched_clock_tsc,
> > +						64, HV_CLOCK_HZ);
> 
> If you have to use line breaks, then please align them properly
> 
> 		sched_clock_register(read_hv_sched_clock_tsc,
> 				     64, HV_CLOCK_HZ);
> 

Got it.  The line break is no longer needed in the new version anyway.

> 
> > +		return;
> > +	}
> > +register_msr_cs:
> > +#endif
> > +	/*
> > +	 * For 32 bit guests just use the MSR based mechanism for reading
> > +	 * the partition counter.
> > +	 */
> > +	hyperv_cs = &hyperv_cs_msr;
> > +	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE) {
> > +		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
> > +
> > +		/*
> > +		 * sched_clock_register is needed on ARM64 but
> > +		 * is a no-op on x86
> > +		 */
> > +		sched_clock_register(read_hv_sched_clock_msr,
> > +						64, HV_CLOCK_HZ);
> 
> Ditto. But again if you return when the feature is not available you spare
> an indent and the line break.

Agreed.

Thanks,

Michael
