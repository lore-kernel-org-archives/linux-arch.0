Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:54528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfFTIzy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 04:55:54 -0400
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <7baf295a-0cc6-1a0a-7e4e-ed33598a2242@marvell.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <eccdb6ec-3703-a22d-e6c0-4be31304e385@arm.com>
Date: Thu, 20 Jun 2019 09:55:50 +0100
MIME-Version: 1.0
In-Reply-To: <7baf295a-0cc6-1a0a-7e4e-ed33598a2242@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Shijith Thotton <sthotton@marvell.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190620085550.FKqwJtFcUSCZg13-HdzDLir7ph9bbtl1y5z7xxtWg0E@z>

Hi Shijith,

...

> Observed good improvement for some APIs with the patch.
> 

Looks good. Thanks for testing the set, I will add your tag to my patches.

> Tested-by: Shijith Thotton <sthotton@marvell.com>
> 
> Thanks,
> Shijith
> 

-- 
Regards,
Vincenzo
