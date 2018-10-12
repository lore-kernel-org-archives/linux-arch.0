Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44369 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeJLTYh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 15:24:37 -0400
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
In-Reply-To: <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Oct 2018 13:52:15 +0200
Message-ID: <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181012115215.DujteyRcmQaJDJKqq1hwCNF2KzI7ghJn57nqtuhXzqU@z>

On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Arnd,
>
> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >
> > > Wire up rseq system call requires an architecture specific
> > > implementation as it not present now.
> > >
> > > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >
> > Didn't we conclude that this should be skipped?
>
> Helge told "I prefer to keep the warning for rseq for now.
> It reminds me that we still may want the rseq syscall.
> If the warning is a problem, you may simply add the __IGNORE_rseq define."
>
> I chose this option; I feel it looks clean
> "# rseq requires an architecture specific implementation" in syscall.tbl
> hopefully remind him to add rseq syscall implementation in this architecture.
>

But he said he wants the warning instead.

     Arnd
