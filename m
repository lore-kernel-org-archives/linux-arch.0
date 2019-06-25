Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfFYUPd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 16:15:33 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C41F21738
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 20:15:32 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id d18so61116wrs.5
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190624133607.GI29497@fuggles.cambridge.arm.com>
 <20190625161804.38713-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906252024350.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906252024350.32342@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 25 Jun 2019 13:15:19 -0700
Message-ID: <CALCETrWE3zYN-6h0RkMV9j5kSkSWbJ-nQnjhH=md=ybSR0eZ9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch <linux-arch@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190625201519.USKE6UFXrid1X2WQeq7UUUIRYLI1W2UdqO3_yr8Jkis@z>

On Tue, Jun 25, 2019 at 11:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 25 Jun 2019, Thomas Gleixner wrote:
>
> > On Tue, 25 Jun 2019, Vincenzo Frascino wrote:
> >
> > CC+ Andy
> >
> > > do_hres() in the vDSO generic library masks the hw counter value
> > > immediately after reading it.
> > >
> > > Postpone the mask application after checking if the syscall fallback is
> > > enabled, in order to be able to detect a possible fallback for the
> > > architectures that have masks smaller than ULLONG_MAX.
> >
> > Right. This only worked on x86 because the mask is there ULLONG_MAX for all
> > VDSO capable clocksources, i.e. that ever worked just by chance.
> >
> > As we talked about that already yesterday, I tested this on a couple of
> > machines and as expected the outcome is uarch dependent. Minimal deviations
> > to both sides and some machines do not show any change at all. I doubt it's
> > possible to come up with a solution which makes all uarchs go faster
> > magically.
> >
> > Though, thinking about it, we could remove the mask operation completely on
> > X86. /me runs tests
>
> Unsurprisingly the results vary. Two uarchs do not care, but they did not
> care about moving the mask either. The other two gain performance and the
> last one falls back to the state before moving the mask. So in general it
> looks like a worthwhile optimization.
>

At one point, I contemplated a different approach: have the "get the
counter" routine return 0 and then do if (unlikely(cycles <= last))
goto fallback.  This will remove one branch from the hot path.  I got
dubious results when I tried benchmarking it, probably because the
branch in question was always correctly predicted.
