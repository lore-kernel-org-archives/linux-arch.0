Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34125 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZSHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Aug 2018 14:07:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id u10-v6so4532493pgr.1
        for <linux-arch@vger.kernel.org>; Sun, 26 Aug 2018 07:25:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
Date: Sun, 26 Aug 2018 07:25:01 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <01BF319B-D6F3-432F-AE1A-1B8B4E3A36A4@amacapital.net>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de> <CAHmME9q+JcT9pnZ5jgowf15O4BkVF-2-QkHA2o1ZKbVe4nAg6g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
Message-ID: <20180826142501.UNji1Owvsmvt4bQtWpWX-dIEC29NaFHhHR3HRv3xudE@z>




> On Aug 26, 2018, at 7:18 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> On Sun, Aug 26, 2018 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>> Do you mean to say you intend to make kernel_fpu_end() and
>>> kernel_neon_end() only actually do something upon context switch, but
>>> not when it's actually called? So that multiple calls to
>>> kernel_fpu_begin() and kernel_neon_begin() can be made without
>>> penalty?
>>=20
>> On context switch and exit to user. That allows to keep those code pathes=

>> fully preemptible. Still twisting my brain around the details.
>=20
> Just to make sure we're on the same page, the goal is so that this code:
>=20
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> kernel_fpu_begin();
> kernel_fpu_end();
> ...
>=20
> has the same performance as this code:
>=20
> kernel_fpu_begin();
> kernel_fpu_end();
>=20
> (Unless of course the process is preempted or the like.)
>=20
> Currently the present situation makes the performance of the above
> wildly different, since kernel_fpu_end() does something immediately.
>=20
> What about something like this:
> - Add a tristate flag connected to task_struct (or in the global fpu
> struct in the case that this happens in irq and there isn't a valid
> current).
> - On kernel_fpu_begin(), if the flag is 0, do the usual expensive
> XSAVE stuff, and set the flag to 1.
> - On kernel_fpu_begin(), if the flag is non-0, just set the flag to 1
> and return.
> - On kernel_fpu_end(), if the flag is non-0, set the flag to 2.
> (Otherwise WARN() or BUG() or something.)
> - On context switch / preemption / etc away from the task, if the flag
> is non-0, XRSTOR and such.

It=E2=80=99s not that simple. First, these states need names, at least for t=
hinking about. 0 is =E2=80=9Cuser state in regs=E2=80=9D. 1 is =E2=80=9Ckern=
el state active=E2=80=9D. 2 is =E2=80=9Cnothing active=E2=80=9D.

The actual encoding will be something like TIF_XSTATE_UNLOADED: user state i=
s not in regs.  TIF_KERNEL_XSTATE: kernel is using FPU. And this fundamental=
ly doubles the size of struct fpu.

Tglx, that doubling-the-size-of-fpu makes me question the idea of letting th=
e kernel use the fpu while preemptible.

> - On context switch / preemption / etc back to the task, if the flag
> is 1, XSAVE and such. If the flag is 2, set it to 0.
>=20



> Jason
