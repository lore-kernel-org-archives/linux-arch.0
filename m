Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52771 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeHJUtg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2018 16:49:36 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so3827511itf.2
        for <linux-arch@vger.kernel.org>; Fri, 10 Aug 2018 11:18:38 -0700 (PDT)
Subject: Re: [PATCH] sh: remove unneeded constructor.
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
 <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
 <20180805163234.GR1392@brightrain.aerifal.cx>
 <61a157f1-7d43-6554-5d26-84d47ce6cabe@landley.net>
 <20180805233349.GS1392@brightrain.aerifal.cx>
 <CAMuHMdUgy8B4d4rAAvixB66cxaN9OiWxnXJKL17J1c47MfU76Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
Message-ID: <a7d1d866-2d0f-2a1e-5275-ecdbb707bf84@landley.net>
Date: Fri, 10 Aug 2018 13:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUgy8B4d4rAAvixB66cxaN9OiWxnXJKL17J1c47MfU76Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>
Cc: Matthew Wilcox <willy@infradead.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On 08/06/2018 01:57 AM, Geert Uytterhoeven wrote:
> On the platform side, there will be a big difference between mostly legacy
> SH and new DT-based j-core on the 32-bit bit side, and mostly new DT-based
> j-core on the 64-bit side.

At $DAYJOB I'm working on a sh7760 board with platform data (the open source
release of the linux patches for which looks like it'll miss this merge window
but might hit next one; they only want to run everything through the lawyers
once so legal clearance waits until we're done fiddling).

The device tree people break platform data support because they only test device
tree, and then refuse patches to make the existing platform data work again. For
example, I have this bookmarked:

  http://lkml.iu.edu/hypermail/linux/kernel/1807.0/05252.html

In case I ever have time to go back and look at it, but I've moved on to other
things already. (My current "circle back to poke at it as I have time" is trying
to get DMAEngine working for sh7760 with the smc91x.c.) The fix I sent upstream
for the LEDs is the fix we're shipping with. It's the simple, obvious, "make it
work exactly like it used to work", and they went "nah, we don't want to do
that, do something else that will require changing the platform data that worked
before our commit". (See longish thread, above. The reply I bookmarked was the
polite one.)

I'm aware there's a problem regression testing old hardware, which limits
conversion of that old hardware to device tree. But the people who _have_ old
hardware continue to run old kernels because upgrading to current kernels
doesn't _work_. And then when we make it work, our patches to make it work get
rejected presumably on the grounds that the device tree people want to make not
having already migrated everything to systemd painful. So current kernels won't
"just work" for the _next_ person either, and nobody upgrades, and then if
somebody tries their hand at converting a board to device tree there's no
testers. Or if there are they go "it didn't boot" because of some unrelated
regression elsewhere in the code because the kernel they're using (and still
maintaining in-house) is years old...

This is something like the eighth company I've seen that at. :P

Rob
