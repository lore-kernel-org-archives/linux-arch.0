Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:42478 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGIhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2018 03:37:33 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so2626158ioa.9
        for <linux-arch@vger.kernel.org>; Fri, 07 Dec 2018 00:37:32 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org> <20181207072724.GA3750@sathnaga86>
In-Reply-To: <20181207072724.GA3750@sathnaga86>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 7 Dec 2018 14:07:20 +0530
Message-ID: <CALxhOnijfhMx8Uyiv3L5DR9dea2P85YRKD09cVK58T9h3ca+Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sathnaga@linux.vnet.ibm.com
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20181207083720.EBck8mJH-_8WtEObBYhaXLCxYR6imKITefYEM1juVBs@z>

Hi Satheesh,

On Fri, 7 Dec 2018 at 12:57, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> On Fri, Dec 07, 2018 at 11:41:35AM +0530, Firoz Khan wrote:
> Hi Firoz,
>
> This version(v4) booted fine in IBM Power8 box.

Sounds good. Thanks for the support.
Thanks Arnd for sharing the solution for "split compat syscall table
out from native table"

If someone can review this patch series and queue it for 4.21 would be great.

Thanks
Firoz

> Compiled with 'ppc64le_defconfig' aginst https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=merge&id=a26b21082959cee3075b3edb7ef23071c7e0b09a
>
> Reference failure v3 version: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/182110.html
>
> Regards,
> -Satheesh.
