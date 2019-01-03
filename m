Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:56060 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfACL3O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2019 06:29:14 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so44785867ith.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2019 03:29:14 -0800 (PST)
MIME-Version: 1.0
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
 <1546442319-20461-2-git-send-email-firoz.khan@linaro.org> <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
In-Reply-To: <CAMuHMdXD5PpF0VswotPP=DQUZ6Rcx0jUq1Czo_WFdGAUrkddyw@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu, 3 Jan 2019 16:59:03 +0530
Message-ID: <CALxhOnhjbJMGEXTaYCw9TN7kMsu_fi67FW-AjHGtntnUbXQ6tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: remove nargs from __SYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190103112903.El04iIY73lWSVzyWBm_jsEOs8_OYfI0EeHVtklhmFnc@z>

Hi Geert,

Thanks for your feedback.

On Thu, 3 Jan 2019 at 16:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >         while [ $t_nxt -lt $t_nr ]; do
> > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
>
> Please keep the space after the comma.

This is intentional as I was facing some compilation issue with
one architecture (If I'm right it is powerpc) when I keep the space
after comma.

Firoz
