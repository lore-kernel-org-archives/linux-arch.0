Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:34713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfFXEbn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 00:31:43 -0400
Date: Mon, 24 Jun 2019 00:12:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
In-Reply-To: <20190623190929.GL2226@sasha-vm>
Message-ID: <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-19-vincenzo.frascino@arm.com> <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com> <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm> <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de> <20190623190929.GL2226@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20190623221237.NpXjlmP0wTNx52S-ciKs9oSTe9oXLvIZLM9TQZjQviA@z>

Sasha,

On Sun, 23 Jun 2019, Sasha Levin wrote:
> On Sat, Jun 22, 2019 at 04:46:28PM +0200, Thomas Gleixner wrote:
> > Folks, please stop chosing Cc lists as you like. We have well established
> > rules for that. And please stop queueing random unreviewed patches in
> > next. Next is not a playground for not ready and unreviewed stuff. No, the
> > hyper-v inbreed Reviewed-by is not sufficient for anything x86 and
> > clocksource related.
> 
> I'm sorry for this, you were supposed to be Cc'ed on these patches and I
> see that you were not.

All good. I've vented steam and am back to normal pressure :)

> > After chasing and looking at those patches, which have horrible subject
> > lines and changelogs btw, I was not able to judge quickly whether that
> > stuff is self contained or not. So no, I fixed up the fallout and rebased
> > Vincenzos VDSO stuff on mainline w/o those hyperv changes simply because if
> > they are not self contained they will break bisection badly.
> > 
> > I'm going to push out the VDSO series later today. That will nicely break

Not yet, but soon :)

> > in combination with the hyper-next branch. Stephen, please drop that and do
> > not try to handle the fallout. That stuff needs to go through the proper
> > channels or at least be acked/reviewed by the relevant maintainers. So the
> > hyper-v folks can rebase themself and post it proper.
> 
> Okay, thank you. We'll rebase and resend.

I have no objections if you collect hyper-v stuff, quite the contrary, but
changes which touch other subsystems need to be coordinated upfront. That's
all I'm asking for.

Btw, that clocksource stuff looks good code wise, just the change logs need
some care and after the VDSO stuff hits next we need to sort out the
logistics. I hope these changes are completely self contained. If not we'll
find a solution.

Thanks,

	tglx
