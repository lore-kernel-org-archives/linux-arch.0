Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:39778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfFJKSz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 06:18:55 -0400
Subject: Re: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-3-vincenzo.frascino@arm.com>
 <20190610093146.GB11076@merlot.physics.ox.ac.uk>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <01907a8b-c052-c51a-4113-389312f9efe7@arm.com>
Date: Mon, 10 Jun 2019 11:18:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190610093146.GB11076@merlot.physics.ox.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huw Davies <huw@codeweavers.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190610101851.QID6wY-T4JKJZlR_qVoKsfSbOIgi8Vt5SF9e4hLEZ_U@z>


On 10/06/2019 10:31, Huw Davies wrote:
> On Thu, May 30, 2019 at 03:15:14PM +0100, Vincenzo Frascino wrote:
>> In the last few years we assisted to an explosion of vdso
>> implementations that mostly share similar code.
> 
> This doesn't make much sense.  Perhaps: "In the last few years we
> have seen an explosion in vdso..." ?
>

Thanks for this, I will fix in v7.

> Huw.
> 

-- 
Regards,
Vincenzo
