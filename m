Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0JF2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 05:05:28 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 128FF126E
        for <linux-arch@vger.kernel.org>; Fri, 27 Sep 2019 09:05:28 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l3so2460662wmf.8
        for <linux-arch@vger.kernel.org>; Fri, 27 Sep 2019 02:05:28 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
In-Reply-To: <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com> <1567723581-29088-2-git-send-email-decui@microsoft.com> <87ef0372wv.fsf@vitty.brq.redhat.com> <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Date: Fri, 27 Sep 2019 11:05:24 +0200
Message-ID: <877e5u6re3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20190927090524.Ndnz8iwH2yXMlG6GTkgj9bXG9i4EmzIyw-RQ1V07HfU@z>

Dexuan Cui <decui@microsoft.com> writes:

>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Thursday, September 26, 2019 3:44 AM
>> > [...]
>> > +static int hv_suspend(void)
>> > +{
>> > +	union hv_x64_msr_hypercall_contents hypercall_msr;
>> > +
>> > +	/* Reset the hypercall page */
>> > +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +	hypercall_msr.enable = 0;
>> > +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> 
>> (trying to think out loud, not sure there's a real issue):
>> 
>> When PV IPIs (or PV TLB flush) are enabled we do the following checks:
>> 
>> 	if (!hv_hypercall_pg)
>> 		return false;
>> 
>> or
>>         if (!hv_hypercall_pg)
>>                 goto do_native;
>> 
>> which will pass as we're not invalidating the pointer. Can we actually
>> be sure that the kernel will never try to send an IPI/do TLB flush
>> before we resume?
>> 
>> Vitaly
>
> When hv_suspend() and hv_resume() are called by syscore_suspend()
> and syscore_resume(), respectively, all the non-boot CPUs are disabled and
> only CPU0 is active and interrupts are disabled, e.g. see
>
> hibernate() -> 
>   hibernation_snapshot() ->
>     create_image() ->
>       suspend_disable_secondary_cpus()
>       local_irq_disable()
>
>       syscore_suspend()
>       swsusp_arch_suspend
>       syscore_resume
>
>       local_irq_enable
>       enable_nonboot_cpus
>
>
> So, I'm pretty sure no IPI can happen between hv_suspend() and hv_resume().
> self-IPI is not supposed to happen either, since interrupts are disabled.
>
> IMO TLB flush should not be an issue either, unless the kernel changes page
> tables between hv_suspend() and hv_resume(), which is not the case as I
> checked the related code, but it looks in theory that might happen, say, in
> the future, so if you insist we should save the variable "hv_hypercall_pg"
> to a temporary variable and set the "hv_hypercall_pg" to NULL before we
> disable the hypercall page

Let's do it as a future proof so we can keep relying on !hv_hypercall_pg
everywhere we need. No need to change this patch IMO, a follow-up would
do.

-- 
Vitaly
