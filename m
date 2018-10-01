From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
Date: Mon, 1 Oct 2018 19:53:12 +0530
Message-ID: <CALxhOnjwY+n5qdNBsL2_ZxCMkGf=Fz=_MwMwBjrWS8=WzYxAQQ@mail.gmail.com>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
 <1538058267-3765-4-git-send-email-firoz.khan@linaro.org> <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Mon, 1 Oct 2018 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > ---
> >  arch/parisc/kernel/syscalls/Makefile       |  55 +++++
> >  arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++++++++++
> >  arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
> >  arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 ++++
>
> I think we absolutely want to share the .tbl files for generating all
> five outputs
> (32-bit unistd.h, 64-bit unistd.h, 32-bit native syscall-table.S, 64-bit native
> syscall-table.S, and 32-bit compat syscall-table.S) so we only
> have to modify one file when adding another syscall, and to ensure that
>  32/64 are in sync.

For this design, I need to rework. I'll update you shortly

- Firoz
>
>       Arnd
