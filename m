Return-Path: <SRS0=m5K7=42=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:60073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgCITXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 15:23:54 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/20] Introduce common headers
In-Reply-To: <20200309122429.GB26309@lakrids.cambridge.arm.com>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com> <3278D604-28F1-47A1-BAB8-D8EB439995E8@amacapital.net> <b18c7ce1-0948-a9e2-2d7e-d019669a71e1@arm.com> <20200309122429.GB26309@lakrids.cambridge.arm.com>
Date: Mon, 09 Mar 2020 20:23:32 +0100
Message-ID: <877dzt72ob.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200309192332.sRXkVndunVRxU9PiGKXWReTlO-HiFunGFEUo3qYsZfA@z>

Mark Rutland <mark.rutland@arm.com> writes:
> On Mon, Mar 09, 2020 at 11:07:08AM +0000, Vincenzo Frascino wrote:
>> On 3/6/20 4:04 PM, Andy Lutomirski wrote:
>> >> To solve the problem, I decided to use the approach below:
>> >>  * Extract from include/linux/ the vDSO required kernel interface
>> >>    and place it in include/common/
>> > 
>> > I really like the approach, but I’m wondering if “common” is the
>> > right name. This directory is headers that aren’t stable ABI like
>> > uapi but are shared between the kernel and the vDSO. Regular user
>> > code should *not* include these, right?
>> > 
>> > Would “vdso” or perhaps “private-abi” be clearer?
>> 
>> Thanks! These headers are definitely not "uapi" like and they are meant to
>> evolve in future like any other kernel header. We have just to make sure that
>> the evolution does not break what we are trying to achieve with this series.
>
> Given we already include uapi/* headers in kernel code, I think placing
> these in a vdso/* namespace would be fine. I think that more clearly
> expresses the constraints on the headers than private-abi/* would.

Yes, that makes most sense.

Thanks,

        tglx
