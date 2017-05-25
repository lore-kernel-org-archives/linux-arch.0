From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/4][V2] Improve watchdog config for arch watchdogs
Date: Thu, 25 May 2017 18:28:52 +1000
Message-ID: <20170525082856.21685-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34182 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdEYI3G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 04:29:06 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Don,

The kbuild 0day caught a compile bug on some archs, I think I've
got that fixed.

I'm resending without the powerpc watchdog example. However if you
decide to accept these changes for the next merge window, I may send
the powerpc patch through your tree with appropriate acks, because
it's not very intrusive.

So the basic idea of these 4 patches is to allow arch specific
(non-perf) hardlockup watchdogs to properly hook into the existing
watchdog interfaces (cmdline, sysctl, kernel apis).

sparc for example implements its own detector, but it can't use all
the same sysctls, some cmdline options are a bit different, etc.
powerpc wants to move to its own detector like sparc, but without
causing interface functionality to change.

Thanks,
Nick

Nicholas Piggin (4):
  watchdog: remove unused declaration
  watchdog: introduce arch_touch_nmi_watchdog()
  watchdog: split up config options
  watchdog: provide watchdog_reconfigure() for arch watchdogs

 arch/blackfin/include/asm/nmi.h            |   2 +
 arch/blackfin/kernel/nmi.c                 |   2 +-
 arch/mn10300/include/asm/nmi.h             |   2 +
 arch/mn10300/kernel/mn10300-watchdog-low.S |   8 +-
 arch/mn10300/kernel/mn10300-watchdog.c     |   2 +-
 arch/powerpc/kernel/setup_64.c             |   2 +-
 arch/sparc/include/asm/nmi.h               |   1 +
 arch/sparc/kernel/nmi.c                    |   6 +-
 arch/x86/kernel/apic/hw_nmi.c              |   2 +-
 include/linux/nmi.h                        |  58 ++++---
 kernel/Makefile                            |   2 +-
 kernel/sysctl.c                            |  18 +-
 kernel/watchdog.c                          | 262 +++++++++++++++++++----------
 kernel/watchdog_hld.c                      |  37 +---
 lib/Kconfig.debug                          |  27 ++-
 15 files changed, 261 insertions(+), 170 deletions(-)

-- 
2.11.0
