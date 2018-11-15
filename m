From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
Date: Thu, 15 Nov 2018 15:35:23 +0530
Message-ID: <CALxhOnhBN3ibNku5z4ZwnRjnWEtSrsbyVQUDzJkT6U65Ek0H+g@mail.gmail.com>
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <1542104370-22831-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Max,

On Wed, 14 Nov 2018 at 05:19, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Firoz,
>
> I have one more question:
>
> On Tue, Nov 13, 2018 at 2:20 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
> > calls also added for making the name convention same across
> > all architecture. While __NR_syscalls isn't strictly part
> > of the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
>
> Looking at the include/uapi/asm-generic/unistd.h I see that
> __NR_syscalls is not guarded by the #ifdef __KERNEL__,
> why should it be guarded for xtensa?

__NR_syscalls for kernel. So this macro is present in asm/unistd.h
rather than uapi/asm/unistd.h. As I mentioned in the patch, it would
be better to keep in uapi/asm/unistd.h to count the number of syscalls.
But this will create some side effect. So I was guarded with __KERNEL__.
In order to come up with common implementation, I kept this for all
architecture.

>
> If we remove __NR_syscall_count from the uapi header I'd
> suggest dropping it completely and switching its two current
> users to __NR_syscalls.

I'm not removing the __NR_syscall_count macro; just place it
in asm/unistd.h file for the above reason.

FYI, I made sure that the kernel will build with my patch. I would
appreciate if you can perform the boot test on the actual platform.

Thanks
Firoz
>
> --
> Thanks.
> -- Max
