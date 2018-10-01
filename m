From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
Date: Mon, 1 Oct 2018 13:36:12 +0200
Message-ID: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org> <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

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
