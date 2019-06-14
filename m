Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfFNVRL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 17:17:11 -0400
Date: Fri, 14 Jun 2019 17:17:10 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190614211710.GQ1513@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kelley <mikelley@microsoft.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190614211710.bSEbsEr-7Qs8OO_Vg_Z0Z35R5IhlFMBTfC3Uxc5mQ0A@z>

On Fri, Jun 14, 2019 at 01:15:23PM +0200, Thomas Gleixner wrote:
>On Thu, 30 May 2019, Michael Kelley wrote:
>> Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
>> I have that moves all of the Hyper-V clock/timer code into a separate
>> clocksource driver in drivers/clocksource, with an include file in
>> includes/clocksource.  That new include file should be able to work
>> instead of your new mshyperv-tsc.h.  It also has the benefit of being
>> ISA neutral, so it will work with my in-progress patch set to support
>> Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
>> for the new clocksource driver patch set.
>
>Grrr. That's queued in hyperv-next for whatever reasons.

I queue up our future pull requests there to give them some soaking in
-next.

>Sasha, can you please provide me the branch to pull from so I can have a
>common base for all the various changes floating around?

I'll send you a unified pull request for these changes.

--
Thanks,
Sasha
