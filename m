From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v4 00/16] genrtc removal
Date: Mon, 30 May 2016 20:57:48 +0200
Message-ID: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDEKVJM7XAHRBPU2WK5AKGQEYDMY6AY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

This is the promised resend of the removal of the genrtc driver and some
related code, now that we are at a good time to merge this for the coming
merge window.

The contents are the same as before, except fixing the build regressions
reported by the 0day builder: on both x86 and mn10300 the rearranging
of the header files caused some missing headers that were included
implicitly before.

Things regarding rtc are a bit intertwined, so I'm mixing patches for
drivers/rtc with drivers/char and arch. This series should make that
better in the end.

This now thoroughly removes the genrtc driver including the asm/rtc.h
headers it uses. For all architectures that still have a meaningful
asm/rtc.h, this goes through two stages:

1) make the rtc-generic implementation independent of asm/rtc.h
2) remove the asm/rtc.h header and disallow the gen_rtc driver

As the last step, the driver itself gets removed. There are a
couple of follow-up cleanup tasks that we could do once this is
all merged, including removing all the remaining nonstandard
RTC drivers from drivers/char:
 
- alpha most likely doesn't ever use CONFIG_RTC, as it has its
  own replacement driver in arch/alpha/kernel/rtc.c, and the legacy
  driver is slightly broken on at least one alpha machine

- loongson64 is the only MIPS machine that has the option of running
  the legacy CONFIG_RTC driver, but it should also work with rtc-cmos,
  and support for that was added in 2010 with 5df74352876 ("MIPS:
  Loongson: Define rtc device on MC146818-equipped systems").

- with the above two gone, the only remaining user of CONFIG_RTC
  is arch/mn10300, and that just needs to register the appropriate
  platform device to use the RTC_CMOS driver instead. I'm sure the
  only reason that hasn't happened is because there is very little
  active development on this architecture.

- CONFIG_JS_RTC depends on SPARC32, but can not be selected there
  because SPARC unconditionally selects RTC_CLASS since 2008, so
  this is effectively dead code. Interestingly, this is not even
  a separate driver, but actually uses the same code as CONFIG_RTC
  with some #ifdef

- CONFIG_EFI_RTC is actively used on all six Itanium configurations,
  though the CONFIG_RTC_DRV_EFI replacement driver is also available
  there (and has been Itanium-only until ARM64 support for EFI was
  merged). I suspect it's just a matter of getting an Ack from the
  Itanium maintainers to remove it and change the defconfigs.

- the last remaining legacy RTC driver after those is CONFIG_DS1302,
  which has a slightly nonstandard ioctl interface and is only used
  on arch/m32r. I have experimented with this a bit and think it
  can be converted in a backward-compatible way as well.

- Regarding the users of RTC_DRV_GENERIC, it would be nice to convert
  them into hardware-specific drivers that look more like the other
  drivers. parisc is particularly easy, it just needs to call
  platform_create_bundle() instead of platform_device_register.
  The three other architectures have their own abstraction layer
  on top of rtc-generic and should kill that off. There are only
  a few drivers in each case: m68k has one (q40), sh has two
  (dreamcast and sh3) and powerpc has four (rtas, mpc8xx, chrp
  and pmac).

- Once all RTC support uses the RTC class subsystem, we should
  remove all implementations of read_persistent_clock{,64} that only
  access the RTC or return a hardwired time, and we should
  remove all update_persistent_clock{,64} users and
  CONFIG_GENERIC_CMOS_UPDATE, as both are replaced with
  generic rtc code.

	Arnd

Cc: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: deller-Mmb7MZpHnFY@public.gmane.org
Cc: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org
Cc: dalias-8zAoT0mYgF4@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Arnd Bergmann (16):
  rtc: cmos: remove empty asm/mc146818rtc.h files
  rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h
  char/genrtc: x86: remove remnants of asm/rtc.h
  rtc: sh: provide rtc_class_ops directly
  char/genrtc: remove alpha support
  char/genrtc: remove mn10300 support
  rtc: parisc: provide rtc_class_ops directly
  char/genrtc: remove parisc support
  rtc: m68k: provide rtc_class_ops directly
  rtc: m68k: provide ioctl for q40
  char/genrtc: remove m68k support
  rtc: powerpc: provide rtc_class_ops directly
  char/genrtc: remove powerpc support
  rtc: generic: remove get_rtc_time/set_rtc_time wrappers
  char/genrtc: remove asm-generic/rtc.h from mips
  char/genrtc: remove the rest of the driver

 arch/alpha/include/asm/rtc.h                 |   1 -
 arch/alpha/kernel/core_marvel.c              |   1 -
 arch/alpha/kernel/rtc.c                      |   6 +-
 arch/frv/include/asm/mc146818rtc.h           |  16 -
 arch/h8300/include/asm/mc146818rtc.h         |   9 -
 arch/ia64/include/asm/mc146818rtc.h          |  10 -
 arch/m68k/amiga/config.c                     |   1 -
 arch/m68k/apollo/config.c                    |   1 -
 arch/m68k/bvme6000/config.c                  |   1 -
 arch/m68k/hp300/config.c                     |   2 +-
 arch/m68k/include/asm/rtc.h                  |  79 ----
 arch/m68k/kernel/time.c                      |  48 ++-
 arch/m68k/mac/config.c                       |   3 +-
 arch/m68k/mac/misc.c                         |   1 -
 arch/m68k/mvme147/config.c                   |   1 -
 arch/m68k/mvme16x/config.c                   |   1 -
 arch/m68k/q40/config.c                       |   2 +-
 arch/m68k/sun3/config.c                      |   1 -
 arch/m68k/sun3/intersil.c                    |   2 +-
 arch/m68k/sun3x/time.c                       |   2 +-
 arch/mips/sni/time.c                         |   1 -
 arch/mn10300/include/asm/rtc.h               |   2 -
 arch/mn10300/kernel/rtc.c                    |   2 +-
 arch/mn10300/proc-mn103e010/proc-init.c      |   1 +
 arch/mn10300/proc-mn2ws0050/proc-init.c      |   1 +
 arch/parisc/include/asm/mc146818rtc.h        |   9 -
 arch/parisc/include/asm/rtc.h                | 131 -------
 arch/parisc/kernel/time.c                    |  36 +-
 arch/powerpc/include/asm/rtc.h               |  78 ----
 arch/powerpc/kernel/time.c                   |  29 +-
 arch/powerpc/platforms/Kconfig               |  11 +
 arch/powerpc/platforms/ps3/time.c            |   2 +-
 arch/sh/include/asm/mc146818rtc.h            |   7 -
 arch/sh/include/asm/rtc.h                    |  11 -
 arch/sh/kernel/time.c                        |  33 +-
 arch/x86/include/asm/mc146818rtc.h           |   1 -
 arch/x86/include/asm/rtc.h                   |   1 -
 arch/x86/kernel/hpet.c                       |   3 +-
 arch/x86/kernel/rtc.c                        |   3 +-
 arch/x86/platform/efi/efi.c                  |   1 -
 arch/x86/platform/efi/efi_64.c               |   1 +
 arch/x86/platform/intel-mid/intel_mid_vrtc.c |   1 +
 drivers/acpi/acpi_cmos_rtc.c                 |   2 +-
 drivers/base/power/trace.c                   |   6 +-
 drivers/char/Kconfig                         |  26 --
 drivers/char/Makefile                        |   1 -
 drivers/char/genrtc.c                        | 539 ---------------------------
 drivers/rtc/rtc-cmos.c                       |  12 +-
 drivers/rtc/rtc-generic.c                    |  36 +-
 drivers/rtc/rtc-mrst.c                       |   2 +-
 include/asm-generic/rtc.h                    | 247 ------------
 include/linux/mc146818rtc.h                  | 194 ++++++++++
 52 files changed, 362 insertions(+), 1256 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rtc.h
 delete mode 100644 arch/frv/include/asm/mc146818rtc.h
 delete mode 100644 arch/h8300/include/asm/mc146818rtc.h
 delete mode 100644 arch/ia64/include/asm/mc146818rtc.h
 delete mode 100644 arch/m68k/include/asm/rtc.h
 delete mode 100644 arch/parisc/include/asm/mc146818rtc.h
 delete mode 100644 arch/parisc/include/asm/rtc.h
 delete mode 100644 arch/powerpc/include/asm/rtc.h
 delete mode 100644 arch/sh/include/asm/mc146818rtc.h
 delete mode 100644 arch/x86/include/asm/rtc.h
 delete mode 100644 drivers/char/genrtc.c
 delete mode 100644 include/asm-generic/rtc.h

-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
