Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:55993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdE2MHr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 May 2017 08:07:47 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN)
In-Reply-To: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
Date: Mon, 29 May 2017 22:07:41 +1000
Message-ID: <87a85v7to2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Babu Moger <babu.moger@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <20170529120741.BoJdMsCKJfQbHX3OmJh01EW1zZtUOBXfHxCyhqHHTc0@z>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
>> Found this problem while enabling queued rwlock on SPARC.
>> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
>> specific byte in qrwlock structure. Without this parameter,
>> we clear the wrong byte. Here is the code.
>>
>> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>>  {
>>         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>>  }
>>
>> Define CPU_BIG_ENDIAN for SPARC to fix it.
>
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>>  config ARCH_PROC_KCORE_TEXT
>>         def_bool y
>>
>> +config CPU_BIG_ENDIAN
>> +       bool
>> +       default y if SPARC
>
> Nice catch!
>
> Traditionally, CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN were defined only on
> architectures that may support both.  And it was checked in platform code
> and drivers only.
> Hence the symbol is lacking from most architectures. Heck, even
> architectures that support both may default to one endiannes, and declare
> only the symbol for the other endianness:

I guess there's a reason we can't use __BIG_ENDIAN__ / __LITTLE_ENDIAN__ ?

cheers
