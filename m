From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 3/3] microblaze: uapi header and system call table file generation
Date: Wed, 10 Oct 2018 08:44:43 +0530
Message-ID: <CALxhOngLfXNvnxXZZJuJVbUGW7peoo3=Ss8ToVWcDCm-g14GTg@mail.gmail.com>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
 <1538397784-4214-4-git-send-email-firoz.khan@linaro.org> <0741f810-58c9-dcf3-8c1c-93860c08e428@xilinx.com>
 <CALxhOnh4__SMm93Lpr13eHxBTvDnocHzdh3YDxtuogEKg355Vw@mail.gmail.com>
 <440fc4a0-cd4e-c8fc-9278-928cf5b7cd92@xilinx.com> <CALxhOnhFyb13YZTRFNsvs9FWD7OCzPtbmdzn+V_YepXACVOxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnhFyb13YZTRFNsvs9FWD7OCzPtbmdzn+V_YepXACVOxiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Michal,

On Thu, 4 Oct 2018 at 16:05, Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Hi Michal,
>
> On Wed, 3 Oct 2018 at 16:56, Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > On 3.10.2018 07:08, Firoz Khan wrote:
> > > Hi Michal,
> > >
> > > On Tue, 2 Oct 2018 at 19:37, Michal Simek <michal.simek@xilinx.com> wrote:
> > >>
> > >> On 1.10.2018 14:43, Firoz Khan wrote:
> > >>> System call table generation script must be run to generate
> > >>> unistd_32.h and syscall_table.h files. This patch will have
> > >>> changes which will invokes the script.
> > >>>
> > >>> This patch will generate unistd_32.h and syscall_table.h
> > >>> files by the syscall table generation script invoked by
> > >>> arch/microblaze/Makefile and the generated files against the
> > >>> removed files will be identical.
> > >>>
> > >>> The generated uapi header file will be included in
> > >>> uapi/asm/unistd.h and generated system call table support
> > >>> file will be included by kernel/syscall_table.S file.
> > >>>
> > >>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> > >>> ---
> > >>>  arch/microblaze/Makefile                  |   3 +
> > >>>  arch/microblaze/include/asm/Kbuild        |   1 +
> > >>>  arch/microblaze/include/uapi/asm/Kbuild   |   1 +
> > >>>  arch/microblaze/include/uapi/asm/unistd.h | 411 +-----------------------------
> > >>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
> > >>>  5 files changed, 10 insertions(+), 812 deletions(-)
> > >>>
> > >>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> > >>> index 4f3ab57..cda5e03 100644
> > >>> --- a/arch/microblaze/Makefile
> > >>> +++ b/arch/microblaze/Makefile
> > >>> @@ -81,6 +81,9 @@ all: linux.bin
> > >>>  archclean:
> > >>>       $(Q)$(MAKE) $(clean)=$(boot)
> > >>>
> > >>> +archheaders:
> > >>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
> > >>> +
> > >>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
> > >>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> > >>>
> > >>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
> > >>> index 569ba9e..d64f5e7 100644
> > >>> --- a/arch/microblaze/include/asm/Kbuild
> > >>> +++ b/arch/microblaze/include/asm/Kbuild
> > >>> @@ -31,3 +31,4 @@ generic-y += trace_clock.h
> > >>>  generic-y += vga.h
> > >>>  generic-y += word-at-a-time.h
> > >>>  generic-y += xor.h
> > >>> +generic-y += syscall_table.h
> > >>> \ No newline at end of file
> > >>
> > >> Still the problem with "No newline at end of file"
> > >>
> > >>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
> > >>> index 2c6a6bf..3a40659 100644
> > >>> --- a/arch/microblaze/include/uapi/asm/Kbuild
> > >>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
> > >>> @@ -28,3 +28,4 @@ generic-y += termbits.h
> > >>>  generic-y += termios.h
> > >>>  generic-y += types.h
> > >>>  generic-y += ucontext.h
> > >>> +generic-y += unistd_32.h
> > >>> \ No newline at end of file
> > >>
> > >> and here too.
> > >
> > > Thanks for your comment. checkpatch script didn't warn this one:(
> > > Hopefully, I can fix this one in the next version.
> > >
> > > I would appreciate if you can perform the boot test on the actual
> > > platform and share the result with me.
> >
> > I see one issue there.
> > Run
> > make mrproper
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/1/
> >
> > And then
> >
> > make mrproper
> > make archheaders V=1
> > make ARCH=microblaze headers_install INSTALL_HDR_PATH=/tmp/2/
> >
> > And compare output.
> > What I see is that in the first part asm/unistd_32.h pointing to
> > asm-generic/unistd_32.h
> >
> > But when archheaders is run before there is expected content.
> >
> > That means there is incorrect/missing dependency in Makefiles.
> >
> >
> > Time to time I am able to see compilation warnings
> > but I didn't find exact steps to replicate this but it also looks like
> > on missing dependency somewhere.
> >
> > [linux](next)$ make mmu_defconfig
> > #
> > # configuration written to .config
> > #
> > [linux](next)$ make -j8 simpleImage.system
> >   WRAP    arch/microblaze/include/generated/asm/barrier.h
> >   WRAP    arch/microblaze/include/generated/asm/bitops.h
> >   WRAP    arch/microblaze/include/generated/asm/bug.h
> >   WRAP    arch/microblaze/include/generated/asm/bugs.h
> >   WRAP    arch/microblaze/include/generated/asm/device.h
> >   WRAP    arch/microblaze/include/generated/asm/compat.h
> >   WRAP    arch/microblaze/include/generated/asm/div64.h
> >   WRAP    arch/microblaze/include/generated/asm/dma-mapping.h
> >   WRAP    arch/microblaze/include/generated/asm/emergency-restart.h
> >   WRAP    arch/microblaze/include/generated/asm/exec.h
> >   WRAP    arch/microblaze/include/generated/asm/extable.h
> >   WRAP    arch/microblaze/include/generated/asm/fb.h
> >   WRAP    arch/microblaze/include/generated/asm/hardirq.h
> >   WRAP    arch/microblaze/include/generated/asm/irq_regs.h
> >   WRAP    arch/microblaze/include/generated/asm/kdebug.h
> >   WRAP    arch/microblaze/include/generated/asm/kmap_types.h
> >   WRAP    arch/microblaze/include/generated/asm/irq_work.h
> >   WRAP    arch/microblaze/include/generated/asm/kprobes.h
> >   WRAP    arch/microblaze/include/generated/asm/linkage.h
> >   WRAP    arch/microblaze/include/generated/asm/local.h
> >   WRAP    arch/microblaze/include/generated/asm/local64.h
> >   WRAP    arch/microblaze/include/generated/asm/mcs_spinlock.h
> >   WRAP    arch/microblaze/include/generated/asm/mm-arch-hooks.h
> >   WRAP    arch/microblaze/include/generated/asm/parport.h
> >   WRAP    arch/microblaze/include/generated/asm/percpu.h
> >   WRAP    arch/microblaze/include/generated/asm/preempt.h
> >   WRAP    arch/microblaze/include/generated/asm/topology.h
> >   WRAP    arch/microblaze/include/generated/asm/syscalls.h
> >   WRAP    arch/microblaze/include/generated/asm/trace_clock.h
> >   WRAP    arch/microblaze/include/generated/asm/vga.h
> >   WRAP    arch/microblaze/include/generated/asm/serial.h
> >   WRAP    arch/microblaze/include/generated/asm/word-at-a-time.h
> >   WRAP    arch/microblaze/include/generated/asm/xor.h
> >   HOSTCC  scripts/bin2c
> >   HOSTCC  scripts/kallsyms
> >   HOSTCC  scripts/dtc/dtc.o
> >   HOSTCC  scripts/mod/mk_elfconfig
> >   HOSTCC  scripts/sortextable
> >   CC      scripts/mod/empty.o
> >   HOSTCC  scripts/dtc/flattree.o
> >   UPD     include/config/kernel.release
> >   HOSTCC  scripts/dtc/fstree.o
> >   HOSTCC  scripts/dtc/data.o
> >   HOSTCC  scripts/dtc/livetree.o
> >   CC      scripts/mod/devicetable-offsets.s
> >   HOSTCC  scripts/dtc/treesource.o
> >   HOSTCC  scripts/dtc/srcpos.o
> >   MKELF   scripts/mod/elfconfig.h
> >   UPD     scripts/mod/devicetable-offsets.h
> >   HOSTCC  scripts/dtc/checks.o
> >   HOSTCC  scripts/dtc/util.o
> >   HOSTCC  scripts/mod/sumversion.o
> >   LEX     scripts/dtc/dtc-lexer.lex.c
> >   YACC    scripts/dtc/dtc-parser.tab.h
> >   YACC    scripts/dtc/dtc-parser.tab.c
> >   UPD     include/generated/utsrelease.h
> >   HOSTCC  scripts/dtc/dtc-lexer.lex.o
> >   CC      kernel/bounds.s
> >   UPD     include/generated/timeconst.h
> >   HOSTCC  scripts/dtc/dtc-parser.tab.o
> >   HOSTCC  scripts/mod/file2alias.o
> >   HOSTCC  scripts/mod/modpost.o
> >   UPD     include/generated/bounds.h
> >   CC      arch/microblaze/kernel/asm-offsets.s
> > In file included from ./arch/microblaze/include/uapi/asm/unistd.h:14:0,
> >                  from ./arch/microblaze/include/asm/unistd.h:12,
> >                  from ./include/uapi/linux/unistd.h:8,
> >                  from ./arch/microblaze/include/asm/seccomp.h:5,
> >                  from ./include/linux/seccomp.h:14,
> >                  from ./include/linux/sched.h:21,
> >                  from arch/microblaze/kernel/asm-offsets.c:13:
> > ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:1:35: fatal
> > error: asm-generic/unistd_32.h: No such file or directory
> >  #include <asm-generic/unistd_32.h>
> >                                    ^
> > compilation terminated.
> > make[1]: *** [arch/microblaze/kernel/asm-offsets.s] Error 1
> > make: *** [prepare0] Error 2
> > make: *** Waiting for unfinished jobs....
> >   HOSTLD  scripts/dtc/dtc
> >   HOSTLD  scripts/mod/modpost
> >
> >
> >
> > When build is fine system is booting fine (v4.19-rc6 + your patches).
>
> Thanks for your support. I'll work on the same which shared above.
> I'll update you asap with the fix.

I'm bit busy this week, working on parisc and ia64 support.
Hopefully I can update you next week.

Thanks
Firoz

>
> - Firoz
>
> >
> > Thanks,
> > Michal
> >
> >
