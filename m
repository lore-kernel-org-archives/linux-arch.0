From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Tue, 23 Aug 2016 14:01:29 +0200
Message-ID: <2466265.8og15RQ8jv@wuerfel>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Friday, August 12, 2016 6:19:17 PM CEST Nicholas Piggin wrote:
> Erratum 657417 is worked around by the linker by inserting additional
> branch trampolines to avoid problematic branch target locations. This
> results in much higher linking time and presumably slower and larger
> generated code. The workaround also seems to only be required when
> linking thumb2 code, but the linker applies it for non-thumb2 code as
> well.
> 
> The workaround today is left to the linker to apply, which is overly
> conservative.
> 
> https://sourceware.org/ml/binutils/2009-05/msg00297.html
> 
> This patch adds an option which defaults to "y" in cases where we
> could possibly be running Cortex A8 and using Thumb2 instructions.
> In reality the workaround might not be required at all for the kernel
> if virtual instruction memory is linear in physical memory. However it
> is more conservative to keep the workaround, and it may be the case
> that the TLB lookup would be required in order to catch branches to
> unmapped or no-execute pages.
> 
> In an allyesconfig build, this workaround causes a large load on
> the linker's branch stub hash and slows down the final link by a
> factor of 5.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 

Thanks a lot for finding this issue. I can confirm that your patch
helps noticeably in all configurations, reducing time for a relink
from 18 minutes to 9 minutes on my machine in the best case, but
the factor 10 slowdown of the final link with your thin archives
and gc-sections patches remains.

I suspect there is still something else going on besides the 657417
slowing things down, but it's also possible that I'm doing something
wrong here.

Aside from that, I notice that for the purpose of speeding up
"allyesconfig", we don't actually need to make this user
configurable, it's sufficient to disable the workaround when
CONFIG_THUMB2_KERNEL is disabled, which is what allyesconfig
and all the defconfig files (but not randconfig) use. I also found
that using THUMB2_KERNEL itself causes a 50% slowdown. I have
patches on my "randconfig" test tree that have the side-effect
of enabling THUMB2_KERNEL for allyesconfig, which is one reason
I have been getting worse results than others.

I could also try to revive an older patch I started, to annotate
the specific CPU core on each ARMv7 platform. I think I have all the
information we need for that, and there are other advantages in
doing it: we could be more selective with all the ARMv7 errata,
and automatically determine whether some optional CPU features
(LPAE, virtualization, integer divide) are available on all
of the selected CPU cores.

	Arnd
---
Full link timing results follow

|| THUMB2, thin archive + gc-sections, before: 18 minutes

09:56:47   LINK    vmlinux
09:56:47  AR      built-in.o
09:56:49  LD      vmlinux.o
10:04:27   MODPOST vmlinux.o
10:04:29  GEN     .version
10:04:29   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
10:04:29   CC      init/version.o
10:04:29   AR      init/built-in.o
10:07:39  KSYM    .tmp_kallsyms1.o
10:11:05  KSYM    .tmp_kallsyms2.o
10:11:16  LD      vmlinux
10:14:30  SORTEX  vmlinux
10:14:30  SYSMAP  System.map

|| THUMB2, thin archive + gc-sections, after: 9 minutes

10:16:01   CHK     include/generated/uapi/linux/version.h
10:16:02   LINK    vmlinux
10:16:02  AR      built-in.o
10:16:03  LD      vmlinux.o
10:23:43   MODPOST vmlinux.o
10:23:46  GEN     .version
10:23:46   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
10:23:46   CC      init/version.o
10:23:47   AR      init/built-in.o
10:24:04  KSYM    .tmp_kallsyms1.o
10:24:32  KSYM    .tmp_kallsyms2.o
10:24:45  LD      vmlinux
10:25:00  SORTEX  vmlinux
10:25:00  SYSMAP  System.map

|| THUMB2, no thin archive + gc-sections, before: 93 seconds

10:44:35   CHK     include/generated/uapi/linux/version.h
10:44:35   LINK    vmlinux
10:44:35  LD      vmlinux.o
10:44:39   MODPOST vmlinux.o
10:44:41  GEN     .version
10:44:41   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
10:44:41   CC      init/version.o
10:44:41   LD      init/built-in.o
10:45:02  KSYM    .tmp_kallsyms1.o
10:45:35  KSYM    .tmp_kallsyms2.o
10:45:47  LD      vmlinux
10:46:06  SORTEX  vmlinux
10:46:06  SYSMAP  System.map
10:46:08   OBJCOPY arch/arm/boot/Image

|| THUMB2, no thin archive + gc-sections, after: 52 seconds

10:41:46   LINK    vmlinux
10:41:46  LD      vmlinux.o
10:41:49   MODPOST vmlinux.o
10:41:52  GEN     .version
10:41:52   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
10:41:52   CC      init/version.o
10:41:52   LD      init/built-in.o
10:41:58  KSYM    .tmp_kallsyms1.o
10:42:17  KSYM    .tmp_kallsyms2.o
10:42:31  LD      vmlinux
10:42:36  SORTEX  vmlinux
10:42:36  SYSMAP  System.map
10:42:38   OBJCOPY arch/arm/boot/Image

|| THUMB2_KERNEL disabled, no thin archives + gc-sections, before: 59 seconds

11:25:05   LINK    vmlinux
11:25:05  LD      vmlinux.o
11:25:07   MODPOST vmlinux.o
11:25:10  GEN     .version
11:25:10   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
11:25:10   CC      init/version.o
11:25:10   LD      init/built-in.o
11:25:19  KSYM    .tmp_kallsyms1.o
11:25:41  KSYM    .tmp_kallsyms2.o
11:25:53  LD      vmlinux
11:26:03  SORTEX  vmlinux
11:26:03  SYSMAP  System.map
  Building modules, stage 2.

|| THUMB2_KERNEL disabled, no thin archives + gc-sections, after: 46 seconds

11:27:36   LINK    vmlinux
11:27:36  LD      vmlinux.o
11:27:39   MODPOST vmlinux.o
11:27:41  GEN     .version
11:27:41   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
11:27:41   CC      init/version.o
11:27:41   LD      init/built-in.o
11:27:46  KSYM    .tmp_kallsyms1.o
11:28:04  KSYM    .tmp_kallsyms2.o
11:28:15  LD      vmlinux
11:28:20  SORTEX  vmlinux
11:28:20  SYSMAP  System.map
11:28:22   OBJCOPY arch/arm/boot/Image

|| THUMB2_KERNEL disabled, thin archives+gc-sections, before: 12 minutes

13:18:39   LINK    vmlinux
13:18:39  AR      built-in.o
13:18:40  LD      vmlinux.o
13:24:44   MODPOST vmlinux.o
13:24:46  GEN     .version
13:24:46   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
13:24:46   CC      init/version.o
13:24:46   AR      init/built-in.o
13:26:34  KSYM    .tmp_kallsyms1.o
13:28:32  KSYM    .tmp_kallsyms2.o
13:28:43  LD      vmlinux
13:30:31  SORTEX  vmlinux
13:30:31  SYSMAP  System.map
13:30:33   OBJCOPY arch/arm/boot/Image

|| THUMB2_KERNEL disabled, thin archives+gc-sections, after: 7 minutes

12:43:15   LINK    vmlinux
12:43:15  AR      built-in.o
12:43:16  LD      vmlinux.o
12:49:19   MODPOST vmlinux.o
12:49:21  GEN     .version
12:49:21   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
12:49:22   CC      init/version.o
12:49:22   AR      init/built-in.o
12:49:33  KSYM    .tmp_kallsyms1.o
12:49:56  KSYM    .tmp_kallsyms2.o
12:50:07  LD      vmlinux
12:50:19  SORTEX  vmlinux
12:50:19  SYSMAP  System.map
12:50:21   OBJCOPY arch/arm/boot/Image
  Building modules, stage 2.
