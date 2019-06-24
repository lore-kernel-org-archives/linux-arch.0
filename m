Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfFXBmY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 21:42:24 -0400
Date: Sun, 23 Jun 2019 20:24:30 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Message-ID: <20190624002430.GN2226@sasha-vm>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <20190624075834.2491a61a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190624075834.2491a61a@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mikelley@microsoft.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, linux-hyperv@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20190624002430.tHH8tSNhc8BpOqDEkR3mrjGin0FrtQ-38jCttWNrz44@z>

On Mon, Jun 24, 2019 at 07:58:34AM +1000, Stephen Rothwell wrote:
>Hi Sasha,
>
>On Sun, 23 Jun 2019 15:09:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>
>> Appologies about this. I ended up with way more travel than I would have
>> liked (writing this from an airport). I've reset our hyperv-next branch
>> to remove these 3 commits until we figure this out.
>
>But not pushed out, yet?

Pushed now. For some reason the airport wifi was blocking ssh :/

--
Thanks,
Sasha
