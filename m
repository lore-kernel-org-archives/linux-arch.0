Return-Path: <SRS0=mIjk=5D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-eopbgr770122.outbound.protection.outlook.com ([40.107.77.122]:38723
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbgCRARU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:17:20 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 06/10] arm64: hyperv: Add kexec and panic handlers
Date: Wed, 18 Mar 2020 00:17:16 +0000
Message-ID: <MW2PR2101MB1052178631BA0F54B3940D90D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
        <1584200119-18594-7-git-send-email-mikelley@microsoft.com>
 <86tv2pzdpr.wl-maz@kernel.org>
In-Reply-To: <86tv2pzdpr.wl-maz@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Message-ID: <20200318001716.9OMMYkHp12-sL-sPHpkzHrMLs73FZWToHGEmIzZADsE@z>

From: Marc Zyngier <maz@kernel.org>  Sent: Sunday, March 15, 2020 11:16 AM
>=20
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
> > +	panic_reported =3D true;
>=20
> How does this work when multiple vcpus are crashing at once? Are you
> guaranteed to be single-threaded at this point?

I'll need to go research.  If not, the above should be an atomic
test-and-set.

>=20
> > +
> > +	guest_id =3D hv_get_vpreg(HV_REGISTER_GUEST_OSID);
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
>=20
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

>=20
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
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.=
c
> > index ae6ece6..c58940d 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -23,6 +23,8 @@
> >
> >  static void (*vmbus_handler)(void);
> >  static void (*hv_stimer0_handler)(void);
> > +static void (*hv_kexec_handler)(void);
> > +static void (*hv_crash_handler)(struct pt_regs *regs);
>=20
> Why is this in the arch-specific code? Yes, it lives in the x86 arch
> code too, but I don't see what prevents it from being moved to the
> vmbus_drv.c code.

OK -- I'll see about moving it to arch independent code.

>=20
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
> > +	hv_kexec_handler =3D handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > +
> > +void hv_remove_kexec_handler(void)
> > +{
> > +	hv_kexec_handler =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > +
> > +void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> > +{
> > +	hv_crash_handler =3D handler;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
> > +
> > +void hv_remove_crash_handler(void)
> > +{
> > +	hv_crash_handler =3D NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
> > --
> > 1.8.3.1
> >
> >
>=20
> Thanks,
>=20
> 	M.
>=20
> --
> Jazz is not dead, it just smells funny.
