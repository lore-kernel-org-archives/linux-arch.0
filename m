From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file generation
Date: Wed, 3 Oct 2018 10:38:40 +0530
Message-ID: <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org> <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Michal,

On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 1.10.2018 14:43, Firoz Khan wrote:
> > System call table generation script must be run to generate
> > unistd_32.h and syscall_table.h files. This patch will have
> > changes which will invokes the script.
> >
> > This patch will generate unistd_32.h and syscall_table.h
> > files by the syscall table generation script invoked by
> > arch/microblaze/Makefile and the generated files against the
> > removed files will be identical.
> >
> > The generated uapi header file will be included in
> > uapi/asm/unistd.h and generated system call table support
> > file will be included by kernel/syscall_table.S file.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > ---
> >  arch/microblaze/Makefile                  |   3 +
> >  arch/microblaze/include/asm/Kbuild        |   1 +
> >  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
> >  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
> >  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
> >  5 files changed, 10 insertions(+), 812 deletions(-)
> >
> > diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> > index 4f3ab57..cda5e03 100644
> > --- a/arch/microblaze/Makefile
> > +++ b/arch/microblaze/Makefile
> > @@ -81,6 +81,9 @@ all: linux.bin
> >  archclean:
> >       $(Q)$(MAKE) $(clean)=$(boot)
> >
> > +archheaders:
> > +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> > +
> >  linux.bin linux.bin.gz linux.bin.ub: vmlinux
> >       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> >
> > diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> > index 569ba9e..d64f5e7 100644
> > --- a/arch/microblaze/include/asm/Kbuild
> > +++ b/arch/microblaze/include/asm/Kbuild
> > @@ -31,3 +31,4 @@ generic-y += trace_clock.h
> >  generic-y += vga.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
> > \ No newline at end of file
>
> Still the problem with "No newline at end of file"
>
> > diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> > index 2c6a6bf..3a40659 100644
> > --- a/arch/microblaze/include/uapi/asm/Kbuild
> > +++ b/arch/microblaze/include/uapi/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += termbits.h
> >  generic-y += termios.h
> >  generic-y += types.h
> >  generic-y += ucontext.h
> > +generic-y += unistd_32.h
> > \ No newline at end of file
>
> and here too.

Thanks for your comment. checkpatch script didn't warn this one:(
Hopefully, I can fix this one in the next version.

I would appreciate if you can perform the boot test on the actual
platform and share the result with me.

Thanks,
Firoz
>
> M
