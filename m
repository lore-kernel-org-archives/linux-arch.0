Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr1320134.outbound.protection.outlook.com ([40.107.132.134]:8263
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfI0Gti (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 02:49:38 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Date: Fri, 27 Sep 2019 06:48:52 +0000
Message-ID: <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-2-git-send-email-decui@microsoft.com>
 <87ef0372wv.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ef0372wv.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vkuznets <vkuznets@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20190927064852.1lS3KMz_9j02otT72f02nttlUsHABtSMsFHcp2HMXMM@z>

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Thursday, September 26, 2019 3:44 AM
> > [...]
> > +static int hv_suspend(void)
> > +{
> > +	union hv_x64_msr_hypercall_contents hypercall_msr;
> > +
> > +	/* Reset the hypercall page */
> > +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +	hypercall_msr.enable =3D 0;
> > +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +
>=20
> (trying to think out loud, not sure there's a real issue):
>=20
> When PV IPIs (or PV TLB flush) are enabled we do the following checks:
>=20
> 	if (!hv_hypercall_pg)
> 		return false;
>=20
> or
>         if (!hv_hypercall_pg)
>                 goto do_native;
>=20
> which will pass as we're not invalidating the pointer. Can we actually
> be sure that the kernel will never try to send an IPI/do TLB flush
> before we resume?
>=20
> Vitaly

When hv_suspend() and hv_resume() are called by syscore_suspend()
and syscore_resume(), respectively, all the non-boot CPUs are disabled and
only CPU0 is active and interrupts are disabled, e.g. see

hibernate() ->=20
  hibernation_snapshot() ->
    create_image() ->
      suspend_disable_secondary_cpus()
      local_irq_disable()

      syscore_suspend()
      swsusp_arch_suspend
      syscore_resume

      local_irq_enable
      enable_nonboot_cpus


So, I'm pretty sure no IPI can happen between hv_suspend() and hv_resume().
self-IPI is not supposed to happen either, since interrupts are disabled.

IMO TLB flush should not be an issue either, unless the kernel changes page
tables between hv_suspend() and hv_resume(), which is not the case as I
checked the related code, but it looks in theory that might happen, say, in
the future, so if you insist we should save the variable "hv_hypercall_pg"
to a temporary variable and set the "hv_hypercall_pg" to NULL before we
disable the hypercall page, I would be happy to post a new version of this
patch, or we can keep this patch as is and I can make an extra patch.

Thanks,
-- Dexuan
