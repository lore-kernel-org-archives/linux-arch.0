From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/8] lib: vdso: Build 32 bit specific functions in the right context
Date: Tue, 14 Jan 2020 10:33:50 +0100
Message-ID: <87r202qt4x.fsf@nanos.tec.linutronix.de>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com> <20190830135902.20861-3-vincenzo.frascino@arm.com> <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
List-Id: linux-arch.vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>
>> clock_gettime32 and clock_getres_time32 should be compiled only with a
>> 32 bit vdso library.
>>
>> Exclude these symbols when BUILD_VDSO32 is not defined.
>
> This breaks the ARM build with:
>
> arch/arm/vdso/vgettimeofday.c: In function ‘__vdso_clock_gettime’:
> arch/arm/vdso/vgettimeofday.c:15:9: error: implicit declaration of function ‘__cvdso_clock_gettime32’; did you mean ‘__cvdso_clock_gettime’? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_gettime32(clock, ts);
>          ^~~~~~~~~~~~~~~~~~~~~~~
>          __cvdso_clock_gettime
> arch/arm/vdso/vgettimeofday.c: In function ‘__vdso_clock_getres’:
> arch/arm/vdso/vgettimeofday.c:33:9: error: implicit declaration of function ‘__cvdso_clock_getres_time32’; did you mean ‘__cvdso_clock_getres_common’? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_getres_time32(clock_id, res);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          __cvdso_clock_getres_common
> cc1: some warnings being treated as errors
>
> The patch below 'fixes' at least the build. Can someone please confirm
> the correctness?

Bah, it's not fixing it. That's what you get when you compile the wrong
tree...
