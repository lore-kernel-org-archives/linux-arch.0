Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbeKMUeX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Nov 2018 15:34:23 -0500
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C
 implementation
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a9726884-70e5-bff4-555d-cd870a5bd6db@arm.com>
Date: Tue, 13 Nov 2018 10:36:49 +0000
MIME-Version: 1.0
In-Reply-To: <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com
Message-ID: <20181113103649.bsY4JXZLpVKdu9o5DF5WLv2uP3UgTToo0xxmEf1xhz4@z>

Hi Peter,

thank you for your review.

On 09/11/2018 18:09, Peter Collingbourne wrote:
> On Fri, Nov 9, 2018 at 4:38 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> -ccflags-y := -shared -fno-common -fno-builtin
>> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
> 
> This either needs to include -ffixed-x18 or
> https://patchwork.kernel.org/patch/10671685/ needs to appear earlier
> in this series.
> 

I did not add -ffixed-x18 to my flags because I was planning to cherry-pick your patch. It will be in v2.

> Peter
> 

-- 
Regards,
Vincenzo
