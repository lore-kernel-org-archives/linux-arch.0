Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35969 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIULGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 07:06:20 -0400
MIME-Version: 1.0
References: <20180914143719.GA27689@guoren-Inspiron-7460> <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
In-Reply-To: <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Sep 2018 22:18:51 -0700
Message-ID: <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Guo Ren <ren_guo@c-sky.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20180921051851.JSgD0keA3KFiOn30f8whNwoMsJP9rpdRuE3TI9pvNzU@z>

On Thu, Sep 20, 2018 at 10:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> > On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> >> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> I don't want to hijack this thread, but in RISC-V land we were hoping to have a
> user ABI free of 32-bit time_t.  Our 32-bit glibc ABI hasn't been finalized
> yet, and when I talked to the glibc guys a few weeks ago they were happy to let
> us wait until 32-bit time_t can be removed before we stabilize the ABI.  We've
> been maintaining out-of-tree glibc patches for a while now, so I'd really like
> to get them into the next glibc release.
>
> Mapping out the schedule more explicitly, as I'm terrible with dates:
>
> * 4.19-rc4 was 2018-09-16
> * 4.19 should be 2018-10-21
> * 4.20 should be 2019-01-13 (skipping 2 weeks for the holidays)
> * 4.21 merge window should close 2019-01-27
> * glibc 2.29 is scheduled for 2019-02-01
>
> That's very tight, but assuming we at least have a prototype of the API so we
> can get the rv32i glibc patches in much earlier it might be OK.  There was some
> talk of being able to use some workarounds to do a 32-bit time_t user ABI
> without the cooresponding kernel ABI, so we could always go down that route to
> start and then decide to deprecate or not deprecate the 32-bit kernel ABI at
> the last minute -- not something I'm fond of doing, but an option.
>
> How close to done do you think the 32-bit time_t will be by the end of the 4.20
> merge window?  If it's close enough to start our glibc push then that might be
> OK.

It will be a bit of a stretch, but it's possible. Most syscalls are
done in linux-next,
I have a few more pending, and only clock_adjtime is really missing now (I had
some earlier patches that I could revive).

My plan was to get that all into 4.20, and then have a conversation about the
actual syscall table changes in 4.21. If we need it for both csky and rv32,
we might just change the generic syscall table that way in 4.21 without
changing all the other ones along with them. I don't want to drag things out
over too many merge windows though, and my plan was to do all architectures
together to simplify the version checks in the libc code to only have to check
for a single version.

         Arnd
