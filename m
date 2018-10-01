Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42308 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJASNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 14:13:50 -0400
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org> <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Oct 2018 13:36:12 +0200
Message-ID: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181001113612.TmQyBToHwEWCfDwpbJzmS6A0tOh7bfqzt2f9NJ5vTZ4@z>

On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> ---
>  arch/parisc/kernel/syscalls/Makefile       |  55 +++++
>  arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
>  arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 ++++

I think we absolutely want to share the .tbl files for generating all
five outputs
(32-bit unistd.h, 64-bit unistd.h, 32-bit native syscall-table.S, 64-bit native
syscall-table.S, and 32-bit compat syscall-table.S) so we only
have to modify one file when adding another syscall, and to ensure that
 32/64 are in sync.

      Arnd
