From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 06/10] arm64: hyperv: Add kexec and panic handlers
Date: Wed, 18 Mar 2020 00:17:16 +0000
Message-ID: <MW2PR2101MB1052178631BA0F54B3940D90D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-7-git-send-email-mikelley@microsoft.com>
 <86tv2pzdpr.wl-maz@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <86tv2pzdpr.wl-maz@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Marc Zyngier <maz@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "apw@canonical.com" <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>, "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, linux-arm-kernel@lists.infradead.
List-Id: linux-arch.vger.kernel.org

From: Marc Zyngier <maz@kernel.org>  Sent: Sunday, March 15, 2020 11:16 AM
> 
> On Sat, 14 Mar 2020 15:35:15 +0000,
> Michael Kelley <mikelley@microsoft.com> wrote:
> >
> > Add functions to set up and remove kexec and panic
> > handlers, and to inform Hyper-V about a guest panic.
> > These functions are called from architecture independent
> > code in the VMbus driver.
> >
> > This code is built only when CONFIG_HYPERV is enabled.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/arm64/hyperv/hv_core.c  | 61
> ++++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm64/hyperv/mshyperv.c | 26 +++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >
> > diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> > index 4aa6b8f..8d6de9f 100644
> > --- a/arch/arm64/hyperv/hv_core.c
> > +++ b/arch/arm64/hyperv/hv_core.c
> > @@ -199,3 +199,64 @@ void hv_get_vpreg_128(u32 msr, struct
> hv_get_vp_register_output *res)
> >  	kfree(output);
> >  }
> >  EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
> > +
> > +void hyperv_report_panic(struct pt_regs *regs, long err)
> > +{
> > +	static bool panic_reported;
> > +	u64 guest_id;
> > +
> > +	/*
> > +	 * We prefer to report panic on 'die' chain as we have proper
> > +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> > +	 * to report it on 'panic'.
> > +	 */
> > +	if (panic_reported)
> > +		return;
> > +	panic_reported = true;
> 
> How does this work when multiple vcpus are crashing at once? Are you
> guaranteed to be single-threaded at this point?

I'll need to go research.  If not, the above should be an atomic
test-and-set.

> 
> > +
> > +	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
> > +
> > +	/*
> > +	 * Hyper-V provides the ability to store only 5 values.
> > +	 * Pick the passed in error value, the guest_id, and the PC.
> > +	 * The first two general registers are added arbitrarily.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
> 
> How about reporting useful information, a pointer to some data
> structure describing the fault? As it is, the usefulness of this is
> pretty dubious.

Yes, it is dubious.  The version with more data describing the fault is
hyperv_report_panic_msg() below, which is provided by newer versions
of Hyper-V, including all versions for ARM64.  So the above function
should never get called on ARM64.  While we could stub it out, I'd
like to keep the notification to Hyper-V just in case
hyperv_report_panic_msg() is not available for some reason I can't
currently anticipate.  The important thing is the notification, and
the register values aren't really important.  I'll add a comment to
that effect.

> 
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> > +
> > +/*
> > + * hyperv_report_panic_msg - report panic message to Hyper-V
> > + * @pa: physical address of the panic page containing the message
> > + * @size: size of the message in the page
> > + */
> > +void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
> > +{
> > +	/*
> > +	 * P3 to contain the physical address of the panic page & P4 to
> > +	 * contain the size of the panic data in that page. Rest of the
> > +	 * registers are no-op when the NOTIFY_MSG flag is set.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
> > +	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
> > +
> > +	/*
> > +	 * Let Hyper-V know there is crash data available along with
> > +	 * the panic message.
> > +	 */
> > +	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
> > +	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> > +}
> > +EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> > index ae6ece6..c58940d 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -23,6 +23,8 @@
> >
> >  static void (*vmbus_handler)(void);
> >  static void (*hv_stimer0_handler)(void);
> > +static void (*hv_kexec_handler)(void);
> > +static void (*hv_crash_handler)(struct pt_regs *regs);
> 
> Why is this in the arch-specific code? Yes, it lives in the x86 arch
> code too, but I don't see what prevents it from being moved to the
> vmbus_drv.c code.

OK -- I'll see about moving it to arch independent code.

> 
> >
> >  static int vmbus_irq;
> >  static long __percpu *vmbus_evt;
> > @@ -137,3 +139,27 @@ void hv_remove_stimer0_irq(int irq)
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
> > +
> > +void hv_setup_kexec_handler(void (*handler)(void))
> > +{
> > +	hv_kexec_handler = handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	hv_kexec_handler = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > +
> > +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> > +{
> > +	hv_crash_handler = handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> > +
> > +void hv_remove_crash_handler(void)
> > +{
> > +	hv_crash_handler = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> > --
> > 1.8.3.1
> >
> >
> 
> Thanks,
> 
> 	M.
> 
> --
> Jazz is not dead, it just smells funny.
