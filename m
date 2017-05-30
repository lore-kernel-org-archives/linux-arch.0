From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/4][V3] Improve watchdog config for arch watchdogs
Date: Tue, 30 May 2017 11:26:55 +1000
Message-ID: <20170530012659.16791-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34962 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdE3B1L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 21:27:11 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Since last time:

- Have the perf based hardlockup detector use arch_touch_nmi_watchdog()
  rather than hld_touch_nmi_watchdog(). This changes direction slightly
  to make the perf-based hard lockup detector an alternative that an
  arch may select, rather than standalone. This better reflects how the
  code works in practice).

- Hopefully fixed the Kconfig options. There's still a bit of ugliness
  that will require another pass or two over interfaces and config
  scheme, but the idea is to make a minimal change to get the powerpc
  HLD in, which gives a reasonable starting point to improve things
  further.

Nicholas Piggin (4):
  watchdog: remove unused declaration
  watchdog: Introduce arch_touch_nmi_watchdog()
  watchdog: Split up config options
  watchdog: Provide watchdog_reconfigure() for arch watchdogs

 arch/blackfin/include/asm/nmi.h            |   2 +
 arch/blackfin/kernel/nmi.c                 |   2 +-
 arch/mn10300/include/asm/nmi.h             |   2 +
 arch/mn10300/kernel/mn10300-watchdog-low.S |   8 +-
 arch/mn10300/kernel/mn10300-watchdog.c     |   2 +-
 arch/powerpc/kernel/setup_64.c             |   2 +-
 arch/sparc/include/asm/nmi.h               |   1 +
 arch/sparc/kernel/nmi.c                    |   6 +-
 arch/x86/kernel/apic/hw_nmi.c              |   2 +-
 include/linux/nmi.h                        |  57 ++++---
 kernel/Makefile                            |   2 +-
 kernel/sysctl.c                            |  18 +-
 kernel/watchdog.c                          | 263 +++++++++++++++++++----------
 kernel/watchdog_hld.c                      |  37 +---
 lib/Kconfig.debug                          |  29 +++-
 15 files changed, 263 insertions(+), 170 deletions(-)

-- 
2.11.0
