From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file generation
Date: Tue, 25 Sep 2018 01:20:21 +0200
Message-ID: <CAK8P3a0sYYzFyLLjfUuvWOijTsqpOnG2HGDA4nSRmR6YkM6W9A@mail.gmail.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org> <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
 <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 18, 2018 at 9:12 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 9 August 2018 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
> > On 9.8.2018 07:27, Firoz Khan wrote:

> >> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> >> index fe6a6c6..99225ab 100644
> >> --- a/arch/microblaze/include/asm/Kbuild
> >> +++ b/arch/microblaze/include/asm/Kbuild
> >> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
> >>  generic-y += vga.h
> >>  generic-y += word-at-a-time.h
> >>  generic-y += xor.h
> >> +
> >> +generated-y += syscall_table.h
> >> \ No newline at end of file
> >
> > This doesn't look right.
>
> You mean I have to keep something like this?
>  generic-y += xor.h
> -
> -generated-y += syscall_table.h
> \ No newline at end of file
> +generic-y += syscall_table.h
> \ No newline at end of file

The "\ No newline at end of file" line is produced by
git format-patch when you have accidentally removed
the newline at the end. Most editors don't even allow
you to do that, so I don't know what went wrong.

       Arnd
