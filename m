From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v7 0/5] parisc: system call table generation support
Date: Fri, 16 Nov 2018 22:55:02 +0100
Message-ID: <20181116215502.GA6585@ls3530.dellerweb.de>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
 <58c3c4a4-7f55-bf08-1c96-ef1aa7f97072@gmx.de>
 <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALxhOngc1cSSDVznnX+iLg-Ne9+k0ct0wT-z0MXKSeKxJE3Vsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>
Cc: Helge Deller <deller@gmx.de>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

> On Fri, 16 Nov 2018 at 01:01, Helge Deller <deller@gmx.de> wrote:
> >
> > On 14.11.2018 07:34, Firoz Khan wrote:
> > > The purpose of this patch series is, we can easily
> > > add/modify/delete system call table support by cha-
> > > nging entry in syscall.tbl file instead of manually
> > > changing many files. The other goal is to unify the
> > > system call table generation support implementation
> > > across all the architectures.
> > >
> > > The system call tables are in different format in
> > > all architecture. It will be difficult to manually
> > > add, modify or delete the system calls in the resp-
> > > ective files manually. To make it easy by keeping a
> > > script and which'll generate uapi header file and
> > > syscall table file.
> > >
> > > syscall.tbl contains the list of available system
> > > calls along with system call number and correspond-
> > > ing entry point. Add a new system call in this arch-
> > > itecture will be possible by adding new entry in the
> > > syscall.tbl file.
> > >
> > > Adding a new table entry consisting of:
> > >         - System call number.
> > >         - ABI.
> > >         - System call name.
> > >         - Entry point name.
> > >
> > > ....
> > > Firoz Khan (5):
> > >   parisc: move __IGNORE* entries to non uapi header
> > >   parisc: add __NR_syscalls along with __NR_Linux_syscalls
> > >   parisc: add system call table generation support
> > >   parisc: generate uapi header and system call table files
> > >   parisc: syscalls: ignore nfsservctl for other architectures
> >
> > Firoz, you may add
> > Acked-by: Helge Deller <deller@gmx.de>
> > to the whole parisc series.
> 
> Sure, will do.
> I'm on a vacation right now. will send mid next week.

That's ok, there is no urgency.

Actually, I noticed that the generated files unistd_32.h
and unistd_64.h do have the same contents, since on parisc
we keep the syscall numbers the same for 32- and 64-bit.
With that in mind, we can simply generate on unistd.h
file for both variants.

Additionally, in the past we had __NR_Linux defined (as 0)
because we initially wanted to support HP-UX syscalls as well,
with NR_Linux being an offset.
The idea to support HP-UX is long gone, so there is no
need to keep that define.

My patch below is on top of your series and cleans up both
items mentioned above.
I suggest you fold it into your patch series before sending
the next version.

Thanks,
Helge

> > >  arch/parisc/Makefile                      |   3 +
> > >  arch/parisc/include/asm/Kbuild            |   3 +
> > >  arch/parisc/include/asm/unistd.h          |   8 +
> > >  arch/parisc/include/uapi/asm/Kbuild       |   2 +
> > >  arch/parisc/include/uapi/asm/unistd.h     | 382 +------------------------
> > >  arch/parisc/kernel/syscall.S              |  11 +-
> > >  arch/parisc/kernel/syscall_table.S        | 459 ------------------------------
> > >  arch/parisc/kernel/syscalls/Makefile      |  57 ++++
> > >  arch/parisc/kernel/syscalls/syscall.tbl   | 369 ++++++++++++++++++++++++
> > >  arch/parisc/kernel/syscalls/syscallhdr.sh |  36 +++
> > >  arch/parisc/kernel/syscalls/syscalltbl.sh |  36 +++
> > >  scripts/checksyscalls.sh                  |   1 +
> > >  12 files changed, 531 insertions(+), 836 deletions(-)


diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index d31b4261cafc..8fdc63ea83ee 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,8 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generated-y += unistd_32.h
-generated-y += unistd_64.h
+generated-y += unistd.h
 generic-y += auxvec.h
 generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
deleted file mode 100644
index 6e31f58ad6b5..000000000000
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_ASM_PARISC_UNISTD_H_
-#define _UAPI_ASM_PARISC_UNISTD_H_
-
-#define __NR_Linux		0
-#ifdef __LP64__
-#include <asm/unistd_64.h>
-#else
-#include <asm/unistd_32.h>
-#endif
-
-#define LINUX_GATEWAY_ADDR	0x100
-
-#endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index defa8878f6d2..f938acd26145 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -12,23 +12,15 @@ systbl := $(srctree)/$(src)/syscalltbl.sh
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
-$(uapi)/unistd_32.h: $(syscall) $(syshdr)
-	$(call if_changed,syshdr)
-
-syshdr_abis_unistd_64 := common,64
-syshdr_offset_unistd_64 := __NR_Linux
-$(uapi)/unistd_64.h: $(syscall) $(syshdr)
+$(uapi)/unistd.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
 systbl_abis_syscall_table_32 := common,32
@@ -44,7 +36,7 @@ systbl_abi_syscall_table_c32 := c32
 $(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
 
-uapisyshdr-y		+= unistd_32.h unistd_64.h
+uapisyshdr-y		+= unistd.h
 kapisyshdr-y		+= syscall_table_32.h		\
 			   syscall_table_64.h		\
 			   syscall_table_c32.h
diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
index 50242b747d7c..2305707898aa 100644
--- a/arch/parisc/kernel/syscalls/syscallhdr.sh
+++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
@@ -5,7 +5,6 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 prefix="$4"
-offset="$5"
 
 fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
 	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
@@ -17,13 +16,8 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
 	nxt=0
 	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
+		printf "#define __NR_%s%s\t%s\n" \
+			"${prefix}" "${name}" "${nr}"
 		nxt=$((nr+1))
 	done
 
@@ -32,5 +26,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
+	printf "#define LINUX_GATEWAY_ADDR\t0x100\n"
+	printf "\n"
 	printf "#endif /* %s */" "${fileguard}"
 ) > "$out"
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
index 45b5bae26240..7627f2d77f61 100644
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
+++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
@@ -5,7 +5,7 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 my_abi="$4"
-offset="$5"
+offset=""
 
 emit() {
 	t_nxt="$1"
