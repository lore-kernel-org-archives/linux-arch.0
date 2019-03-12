Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45707 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfCLIbw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 04:31:52 -0400
MIME-Version: 1.0
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
 <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
 <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com> <20190311214307.domy6azaoi4ggtiu@brauner.io>
In-Reply-To: <20190311214307.domy6azaoi4ggtiu@brauner.io>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Mar 2019 09:31:33 +0100
Message-ID: <CAK8P3a0iW-bhfiLY2po4cwaG0f-S+Xdoowrj0A6CwaY4VHgdWA@mail.gmail.com>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree
 with the y2038 tree (now block and tip trees))
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20190312083133.Y9FMNlywO522513t3V05Lh2Ls5EiVdHe97UVK5FmIB0@z>

On Mon, Mar 11, 2019 at 10:43 PM Christian Brauner <christian@brauner.io> wrote:
> On Mon, Mar 11, 2019 at 10:38:07PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Shall each architcture maintainer take care of this hxxself, or will
> > > this be done in
> > > a coordinated way?
> >
> > I was planning to send a patch for all architectures this time
> > (after all three sets are merged, which is now), and ask future
>
> Just to clarify, are you referring to your sets? I think Linus hasn't
> gotten around to reviewing the PR for pidfd_send_signal() yet. :)

Ah, I thought he had already merged both, the confusion was on
my end.

      Arnd
