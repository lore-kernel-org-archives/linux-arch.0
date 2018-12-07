Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:52380 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGGQn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2018 01:16:43 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so5336453itg.2
        for <linux-arch@vger.kernel.org>; Thu, 06 Dec 2018 22:16:42 -0800 (PST)
MIME-Version: 1.0
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 7 Dec 2018 11:46:30 +0530
Message-ID: <CALxhOnij8xO1yyZ87HX_jE8YdE-PbEe9a=yu50wvORnn-0_UvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] powerpc: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181207061630.yvVRvHfyGsLbcHsOPJGMQ77nsNOm_02KhFs4TjLIsxo@z>

++ sathnaga@linux.vnet.ibm.com,

Hi Satheesh,

On Fri, 7 Dec 2018 at 11:42, Firoz Khan <firoz.khan@linaro.org> wrote:
>
>
> Changes since v3:
>  - split compat syscall table out from native table.
>  - modified the script to add new line in the generated
>    file.

I have fixed few major issue. Could you perform boot test with v4
on the platform.

Thanks
Firoz
