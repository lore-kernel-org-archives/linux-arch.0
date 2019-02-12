Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44486 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbfBLOg0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 09:36:26 -0500
MIME-Version: 1.0
References: <1549861699-11875-1-git-send-email-guoren@kernel.org> <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
In-Reply-To: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Feb 2019 15:36:04 +0100
Message-ID: <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guo Ren <guoren@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190212143604.OYFNm327bc3nsYBkV-TCRX8_EgJJGqEG_2HoNrfnXYc@z>

On Mon, Feb 11, 2019 at 7:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.0-rc6
>
> The bulk of this seems to be new hardware support code.
>
> Please send it during the 5.1 merge window, not as fixes at post-rc6 time.

Aside from this, I also noticed that the new code is for drivers/irqchip,
which is a separate subsystems with its own maintainers, who were
neither on Cc nor did they Ack the patches.

Generally, those should get merged through the respective subsystem
trees as listed in the linux/MAINTAINERS file.


      Arnd
