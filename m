From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
Date: Fri, 16 Nov 2018 11:18:35 +0530
Message-ID: <CALxhOngbgaqmcNPJ3xiBLrk35UWQ4ThJ-rApbd1z+9772yGpyQ@mail.gmail.com>
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <1542104370-22831-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
 <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com> <CAMo8BfKM0M-f9UNmz0o9qZb9srJn7yxkYVYjqGc84c0eO5jnmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMo8BfKM0M-f9UNmz0o9qZb9srJn7yxkYVYjqGc84c0eO5jnmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Max,

On Fri, 16 Nov 2018 at 01:15, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 2:05 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 14 Nov 2018 at 05:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > If we remove __NR_syscall_count from the uapi header I'd
> > > suggest dropping it completely and switching its two current
> > > users to __NR_syscalls.
> >
> > I'm not removing the __NR_syscall_count macro; just place it
> > in asm/unistd.h file for the above reason.
>
> Ok, I'll apply this series to the xtensa tree and make my cleanups
> on top of it.
>
> > FYI, I made sure that the kernel will build with my patch. I would
> > appreciate if you can perform the boot test on the actual platform.
>
> I did a simple boot testing on a range of configurations, it works.
> I'll also run LTP a bit later.

Great, thanks!

Firoz
>
> --
> Thanks.
> -- Max
