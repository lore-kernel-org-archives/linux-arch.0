Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38336 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbeJLRsW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 13:48:22 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so4754987ywa.5
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 03:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 12 Oct 2018 15:46:29 +0530
Message-ID: <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181012101629.CtoxqGrTuHdAGyHGI00KvO2CbBsZlOVArnJtAHo2ZIg@z>

Hi Arnd,

On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > Wire up rseq system call requires an architecture specific
> > implementation as it not present now.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Didn't we conclude that this should be skipped?

Helge told "I prefer to keep the warning for rseq for now.
It reminds me that we still may want the rseq syscall.
If the warning is a problem, you may simply add the __IGNORE_rseq define."

I chose this option; I feel it looks clean
"# rseq requires an architecture specific implementation" in syscall.tbl
hopefully remind him to add rseq syscall implementation in this architecture.

Firoz

>
>        Arnd
