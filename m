Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfGJJs6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 05:48:58 -0400
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
 <alpine.DEB.2.21.1907100811170.1758@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b2dccce1-8cf2-1330-7ea9-7636e0da3c42@arm.com>
Date: Wed, 10 Jul 2019 10:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907100811170.1758@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shijith Thotton <sthotton@marvell.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190710094853.BDZgWt7OB8KcOFPdLnBb5GXaU2aMZ70GtmrAwsXmL-E@z>

On 10/07/2019 07:12, Thomas Gleixner wrote:
> On Tue, 9 Jul 2019, John Stultz wrote:
>> Though unfortunately, it seems the arm64 vdso code that just landed is
>> breaking AOSP for me.
>>
>> I see a lot of the following errors:
>> 01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
>> pid 755 (cameraserver)
>> 01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
>> (android.hardwar), pid 759 (android.hardwar)
>> 01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
>> pid 756 (drmserver)
>>
>> Which go away if I revert the vdso merge that went in via tip/timers.
>>
>> I tried to bisect things down a bit, but as some later fixes are
>> required (at one point, date was returning the start epoch and never
>> increasing), this hasn't worked too well. But I'm guessing since I
>> see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
>> not be built", and the system is half working, I'm guessing this is an
>> issue with just the 32bit code failing.  While I can try to sort out
>> the proper CROSS_COMPILE_COMPAT in my build environment, I assume
>> userland shouldn't be crashing if that value isn't set.
> 
> The obvious question is whether the VDSO is mapped to the 32bit process in
> that case. It shouldn't...
>

Agreed. I am investing if/why this is happening and will post a fix accordingly.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
