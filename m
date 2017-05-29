From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN)
Date: Mon, 29 May 2017 22:07:41 +1000
Message-ID: <87a85v7to2.fsf@concordia.ellerman.id.au>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial@vger.kernel.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
