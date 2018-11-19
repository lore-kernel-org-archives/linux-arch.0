Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34584 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbeKTC0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2018 21:26:01 -0500
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Nov 2018 17:01:43 +0100
Message-ID: <CAK8P3a20MaFRNf8-umvrGNtjgNG98PkzcFGtHrnY835UEGv3tg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mips: generate uapi header and system call table files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181119160143.wfm3HKWBWm5ULbO2tNmjLrpjfQiWCSwd4jqkhWJ1rEw@z>

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to gener-
> ate unistd_64/n32/o32.h and syscall_table_32_o32/64_64/64-
> _n32/64-o32.h files. This patch will have changes which
> will invokes the script.
>
> This patch will generate unistd_64/n32/o32.h and syscall-
> _table_32_o32/64_64/64-n32/64-o32.h files by the syscall
> table generation script invoked by parisc/Makefile and
> the generated files against the removed files must be
> identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/scall32-o32/64-64/64-n32/-
> 64-o32.Sfile.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Looks good to me.

      Arnd
