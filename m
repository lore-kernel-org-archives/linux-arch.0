Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:40249 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeKSPoz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2018 10:44:55 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so1541746ioh.7
        for <linux-arch@vger.kernel.org>; Sun, 18 Nov 2018 21:22:26 -0800 (PST)
MIME-Version: 1.0
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org> <20181118.185913.65989390344960294.davem@davemloft.net>
In-Reply-To: <20181118.185913.65989390344960294.davem@davemloft.net>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 19 Nov 2018 10:52:16 +0530
Message-ID: <CALxhOni2YmDX3zYx5a_MWvkfJic+UuMmZBV7sgppkXO5pZB_vw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux <sparclinux@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181119052216.9o4pGTkoGph23ljXZ7SoB3Lqd3f7qRo89gHDAhw1mos@z>

Hi David,

On Mon, 19 Nov 2018 at 08:29, David Miller <davem@davemloft.net> wrote:
>
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Wed, 14 Nov 2018 10:56:27 +0530
>
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>  ...
>
> Series applied to sparc-next.

Sounds good. Thanks

Firoz
