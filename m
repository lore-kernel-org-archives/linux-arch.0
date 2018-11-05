Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:35534 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGxN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 01:53:13 -0500
MIME-Version: 1.0
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 5 Nov 2018 13:31:20 -0800
Message-ID: <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] alpha: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: linux-alpha <linux-alpha@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20181105213120.rgYgnsoKoEmfbwaRNNG8HUfpMkjR9MAyVw6sEC4Zzg4@z>

On Thu, Nov 1, 2018 at 6:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the
> system call table generation support implementation
> across all the architectures.
>
> The system call tables are in different format in
> all architecture. It will be difficult to manually
> add, modify or delete the system calls in the resp-
> ective files manually. To make it easy by keeping a
> script and which'll generate uapi header file and
> syscall table file.
>
> syscall.tbl contains the list of available system
> calls along with system call number and correspond-
> ing entry point. Add a new system call in this arch-
> itecture will be possible by adding new entry in the
> syscall.tbl file.

Sounds like a worthy goal.

I tried applying the patches and it seems they haven't been rebased
since v4.18. My rebases are in
https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=for-linus

They seem to work for me, FWIW.

Is your plan to have the patches go through the separate architecture
trees, or go in together? I think I'd at least prefer for another
architecture to take the plunge before alpha.
