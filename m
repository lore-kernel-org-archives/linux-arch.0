From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Date: Sat, 17 Nov 2018 17:26:23 +0100
Message-ID: <20181117162623.GA14763@ls3530.dellerweb.de>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
 <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
 <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
 <20181116215502.GA6585@ls3530.dellerweb.de>
 <CAK8P3a2g-7iR594Fs_goYCYPqgO6FRML5oi9vodDC_wKHF64bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2g-7iR594Fs_goYCYPqgO6FRML5oi9vodDC_wKHF64bA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>
Cc: Helge Deller <deller@gmx.de>, Firoz Khan <firoz.khan@linaro.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

* Arnd Bergmann <arnd@arndb.de>:
> On Fri, Nov 16, 2018 at 1:55 PM Helge Deller <deller@gmx.de> wrote:
> > > On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
> > > >
> > > > On 14.11.2018 07:34, Firoz Khan wrote:
> > > > > The purpose of this patch series is, we can easily
> > > > > add/modify/delete system call table support by cha-
> > > > > nging entry in syscall.tbl file instead of manually
> > > > > changing many files. The other goal is to unify the
> > > > > system call table generation support implementation
> > > > > across all the architectures.
> > > > >
> > > > > The system call tables are in different format in
> > > > > all architecture. It will be difficult to manually
> > > > > add, modify or delete the system calls in the resp-
> > > > > ective files manually. To make it easy by keeping a
> > > > > script and which'll generate uapi header file and
> > > > > syscall table file.
> > > > >
> > > > > syscall.tbl contains the list of available system
> > > > > calls along with system call number and correspond-
> > > > > ing entry point. Add a new system call in this arch-
> > > > > itecture will be possible by adding new entry in the
> > > > > syscall.tbl file.
> > > > >
> > > > > Adding a new table entry consisting of:
> > > > >         - System call number.
> > > > >         - ABI.
> > > > >         - System call name.
> > > > >         - Entry point name.
> > > > >
> > > > > ....
> > > > > Firoz Khan (5):
> > > > >   parisc: move __IGNORE* entries to non uapi header
> > > > >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> > > > >   parisc: add system call table generation support
> > > > >   parisc: generate uapi header and system call table files
> > > > >   parisc: syscalls: ignore nfsservctl for other architectures
> > > >
> > > > Firoz, you may add
> > > > Acked-by: Helge Deller <deller@gmx.de>
> > > > to the whole parisc series.
> > >
> > > Sure, will do.
> > > I'm on a vacation right now. will send mid next week.
> >
> > That's ok, there is no urgency.
> >
> > Actually, I noticed that the generated files unistd_32.h
> > and unistd_64.h do have the same contents, since on parisc
> > we keep the syscall numbers the same for 32- and 64-bit.
> > With that in mind, we can simply generate on unistd.h
> > file for both variants.
> 
> It depends on what we want to do in the future. When we add
> around 20 new system calls fro y2038, my plan was to
> only add them for 32-bit architectures, leaving holes on
> 64-bit ones. 

Ok, I didn't thought of that.

> We can also assign the new numbers on parisc64 but they would have the
> same entry point as existing calls.

> If you prefer doing it like that, your patch seems fine for that,
> it's just slightly inconsistent with the other 64-bit architectures
> then.

I really prefer to stay in sync with other major architectures.
So, please drop my last patch.

Instead please apply only the next one, which drops the NR_Linux
offset value (which is 0 anyway).

Thanks,
Helge


diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index 6e31f58ad6b5..98dc953656af 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -2,7 +2,6 @@
 #ifndef _UAPI_ASM_PARISC_UNISTD_H_
 #define _UAPI_ASM_PARISC_UNISTD_H_
 
-#define __NR_Linux		0
 #ifdef __LP64__
 #include <asm/unistd_64.h>
 #else
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index defa8878f6d2..4dcc5c9ae7f2 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -12,22 +12,18 @@ systbl := $(srctree)/$(src)/syscalltbl.sh
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
 		   '$(syshdr_abis_$(basetarget))'		\
-		   '$(syshdr_pfx_$(basetarget))'		\
-		   '$(syshdr_offset_$(basetarget))'
+		   '$(syshdr_pfx_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+		   '$(systbl_abi_$(basetarget))'
 
 syshdr_abis_unistd_32 := common,32
-syshdr_offset_unistd_32 := __NR_Linux
 $(uapi)/unistd_32.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
 syshdr_abis_unistd_64 := common,64
-syshdr_offset_unistd_64 := __NR_Linux
 $(uapi)/unistd_64.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
