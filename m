Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIsU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 04:48:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so1511746edt.13
        for <linux-arch@vger.kernel.org>; Tue, 12 Mar 2019 01:48:19 -0700 (PDT)
Date: Tue, 12 Mar 2019 09:48:11 +0100
In-Reply-To: <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au> <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com> <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com> <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com> <20190311214307.domy6azaoi4ggtiu@brauner.io> <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree with the y2038 tree (now block and tip trees))
From: Christian Brauner <christian@brauner.io>
Message-ID: <0E75950C-D39C-43F9-950B-284BEA768A90@brauner.io>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190312084811.jwtAN43EQfgrHR7g7JsEDEvhCyLHoiB1VVMxmja69Gc@z>

On March 12, 2019 9:31:33 AM GMT+01:00, Arnd Bergmann <arnd@arndb=2Ede> wro=
te:
>On Mon, Mar 11, 2019 at 10:43 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
>> > On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven
><geert@linux-m68k=2Eorg> wrote:
>> > >
>> > > Shall each architcture maintainer take care of this hxxself, or
>will
>> > > this be done in
>> > > a coordinated way?
>> >
>> > I was planning to send a patch for all architectures this time
>> > (after all three sets are merged, which is now), and ask future
>>
>> Just to clarify, are you referring to your sets? I think Linus hasn't
>> gotten around to reviewing the PR for pidfd_send_signal() yet=2E :)
>
>Ah, I thought he had already merged both, the confusion was on
>my end=2E

I think I'll do a GIT PULL RESEND later today since I sent the original pr=
 last Tuesday=2E

Christian


>
>      Arnd
