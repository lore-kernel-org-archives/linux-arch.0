Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbfAOPq5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jan 2019 10:46:57 -0500
Subject: Re: [PATCH v4 00/24] Unify vDSOs across more architectures
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <efae0a15-9560-7bc3-e008-1ffa0f9b9297@arm.com>
Date: Tue, 15 Jan 2019 15:46:53 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190115154653.NejclDJmWAIUQd3XkzcnHINwbUNgSRQmqpgyOMcnfcw@z>

On 15/01/2019 15:31, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
>>
>> This implementation contains the portings to the common library for: arm64,
>> compat mode for arm64, arm and mips.
> 
> And as you already copied most of the implementation from x86, then why is
> there no port of the x86 vdso ?
>

Did not think of doing that, but it is certainly something that can be done. I
will add it to v5.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
