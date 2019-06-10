Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codeweavers.com ([50.203.203.244]:59114 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJRr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 13:47:57 -0400
Date: Mon, 10 Jun 2019 18:47:46 +0100
From: Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH v6 01/19] kernel: Standardize vdso_datapage
Message-ID: <20190610174746.GA13224@merlot.physics.ox.ac.uk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-2-vincenzo.frascino@arm.com>
 <CAK8P3a3EnvkLND2RJdZtEY64PhK5g0sbbuytQro=f0cPur2g9g@mail.gmail.com>
 <bb5253b2-623c-c927-27a2-1d3a2990d20f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5253b2-623c-c927-27a2-1d3a2990d20f@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190610174746.RiVqBpc7QxTtkOvgysNg3Y6w3V5DKPAKVex2Jg8fnXU@z>

On Tue, Jun 04, 2019 at 01:05:40PM +0100, Vincenzo Frascino wrote:
> On 31/05/2019 09:16, Arnd Bergmann wrote:
> > On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > 
> >> + * vdso_data will be accessed by 64 bit and compat code at the same time
> >> + * so we should be careful before modifying this structure.
> >> + */
> >> +struct vdso_data {
> >> +       u32                     seq;
> >> +
> >> +       s32                     clock_mode;
> >> +       u64                     cycle_last;
> >> +       u64                     mask;
> >> +       u32                     mult;
> >> +       u32                     shift;
> >> +
> >> +       struct vdso_timestamp   basetime[VDSO_BASES];
> >> +
> >> +       s32                     tz_minuteswest;
> >> +       s32                     tz_dsttime;
> >> +       u32                     hrtimer_res;
> >> +};
> > 
> > The structure contains four padding bytes at the end, which is
> > something we try to avoid, at least if this ends up being used as
> > an ABI. Maybe add "u32 __unused" at the end?
> > 
> 
> Agreed, I will fix this in v7.

Note that this is also necessary to ensure that CLOCK_MONOTONIC_RAW
works in the 32-bit vDSO on x86_64 kernels.

Huw.
