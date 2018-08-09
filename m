Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:26014
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIJ3J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 05:29:09 -0400
Subject: Re: [PATCH 2/3] microblaze: Added system call table generation
 support
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-3-git-send-email-firoz.khan@linaro.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <80094eae-05b8-a96f-b631-cc3b81e0e425@xilinx.com>
Date: Thu, 9 Aug 2018 09:05:10 +0200
MIME-Version: 1.0
In-Reply-To: <1533792466-4227-3-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20180809070510.VfVk9mpdyaX5v3See_yhSG5q-g4WS0C3omP3XO8_xm0@z>

On 9.8.2018 07:27, Firoz Khan wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
> 
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall.tbl file which'll be the input for the scripts.
> 
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry point.
> Add a new system call in this architecture will be possible
> by adding new entry in the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
> 
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd.h and syscall_table.h files respectively. File
> syscall_table.h is included by syscall.S - the real system
> call table. Both .sh files will parse the content syscall.tbl
> to generate the header and table files.
> 
> ARM, s390 and x86 architecuture does have the similar support.
> I leverage their implementation to come up with a generic
> solution. And this is the ground work for y2038 issue. We need
> to change 52 system call implementation and this work will
> reduce the effort by simply modify 52 entries in syscall.tbl.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/kernel/syscalls/Makefile      |  37 +++
>  arch/microblaze/kernel/syscalls/syscall.tbl   | 404 ++++++++++++++++++++++++++
>  arch/microblaze/kernel/syscalls/syscallhdr.sh |  33 +++
>  arch/microblaze/kernel/syscalls/syscalltbl.sh |  28 ++
>  4 files changed, 502 insertions(+)
>  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
>  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh

it is interesting that arm and x86 scripts and they are "almost" the
same. Is there any plan to put these script to generic location instead
of keeping the same copy in architecture?

fileguard name contains hardcoded macro prefix where in arm there is
uapi detection. The same should be done architecture and sholdn't matter
if you define macro with or without value.




>  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> 
> diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
> new file mode 100644
> index 0000000..7624044
> --- /dev/null
> +++ b/arch/microblaze/kernel/syscalls/Makefile
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +out := arch/$(SRCARCH)/include/generated/asm
> +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
> +
> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
> +	  $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +syscall := $(srctree)/$(src)/syscall.tbl
> +
> +syshdr := $(srctree)/$(src)/syscallhdr.sh
> +systbl := $(srctree)/$(src)/syscalltbl.sh
> +
> +quiet_cmd_syshdr = SYSHDR  $@
> +      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'  \
> +		   '$(syshdr_abi_$(basetarget))'          \
> +		   '$(syshdr_pfx_$(basetarget))'          \
> +		   '$(syshdr_offset_$(basetarget))'
> +
> +quiet_cmd_systbl = SYSTBL  $@
> +      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'  \
> +		   '$(systbl_abi_$(basetarget))'
> +
> +$(uapi)/unistd_32.h: $(syscall) $(syshdr)
> +	$(call if_changed,syshdr)
> +
> +$(out)/syscall_table.h: $(syscall) $(systbl)
> +	$(call if_changed,systbl)
> +
> +uapisyshdr-y			+= unistd_32.h
> +syshdr-y			+= syscall_table.h
> +
> +targets	+= $(uapisyshdr-y) $(syshdr-y)
> +
> +PHONY += all
> +all: $(addprefix $(uapi)/,$(uapisyshdr-y))
> +all: $(addprefix $(out)/,$(syshdr-y))
> +	@:
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> new file mode 100644
> index 0000000..219d940
> --- /dev/null
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -0,0 +1,404 @@
> +#
> +# Linux system call numbers and entry vectors
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point>
> +#
> +# The abi is always common for this file.
> +#
> +0       common  restart_syscall                 sys_restart_syscall
> +1       common  exit                            sys_exit
> +2       common  fork                            sys_fork
> +3       common  read                            sys_read

Arm(and partially s390) are using tabs for indentation. Any reason not
to use it here too?

Thanks,
Michal
