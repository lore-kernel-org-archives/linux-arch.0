Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39009 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbeIFUF5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 16:05:57 -0400
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 6 Sep 2018 17:29:39 +0200
Message-ID: <CAK8P3a3_tzeKf2PFa4LMym3UgBPu380H9LGyGLTDJEu7aNyecQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180906152939.ScxszdjVenp3afe9CWQ6z0_cSU-Paozkh2rMnEaPX_M@z>

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

>
> -#define NR_syscalls            361
> +#define __NR_syscalls          361

What about the suggestion that was made earlier to enclose this in
#ifdef __KERNEL__?

     Arnd
