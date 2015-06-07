From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 00/19] ARCv2 port to Linux - (A) prepratory patches
Date: Sun, 7 Jun 2015 14:08:04 +0530
Message-ID: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:56887 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbFGIjD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:03 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi,

ARCv2 is the next generation ISA from Synopsys and basis for the
HS3{4,6,8} families of processors which retain the traditional ARC mantra of
low power and configurability and are now more performant and feature rich.

Linux has been ported to HS38x series, a 10 stage pipeline core which
supports MMU (with huge pages) and SMP (upto 4 cores) among other features.

 - www.synopsys.com/dw/ipdir.php?ds=arc-hs38-processor
 - http://news.synopsys.com/2014-10-14-New-DesignWare-ARC-HS38-Processor-Doubles-Performance-for-Embedded-Linux-Applications
 - http://www.embedded.com/electronics-news/4435975/Synopsys-ARC-HS38-core-gives-2X-boost-to-Linux-based-apps

This sub-series introduces changes to existing in-tree port of ARC700 core
(based on ARCompact ISA) to allow for better code sharing with new ARCv2 code.

The actual ARCv2 port will follow as a seperate series.

Please review !

Thx,
-Vineet

Vineet Gupta (19):
  ARC: mm/cache_arc700.c -> mm/cache.c
  ARC: cacheflush: move some code around, delete old comments
  ARC: cacheflush: No need to retain DC_CTRL from __before_dc_op()
  ARC: untangle cache flush loop
  ARC: entry.S: common'ize scrtach reg freeup in intr + exceptions
  ARC: entry.S: Introduce INTERRUPT_{PROLOGUE,EPILOGUE}
  ARC: entry.S: canonical'ize EXCEPTION_{PROLOGUE,EPILOGUE}
  ARC: entry.S: confine EXCEPTION_* macros to one file
  ARC: entry.S: FAKE_RET_FROM_EXCPN can always use r9
  ARC: entry.S: Trap handler to use r10 for syscall vs. brkpt decision
  ARC: entry.S: comments cleanup
  ARC: entry.S: Ensure that restore_regs is local to compilation unit
  ARC: entry.S: split into ARCompact ISA specific, common bits
  ARC: entry.S: move some code around for cache locality in return path
  ARC: entry.S: micro-optimize Trap handler
  ARC: entry.S: use single EXCEPTION_PROLOGUE
  ARC: entry.S: [arcompact] simplify SWITCH_TO_KERNEL_STK
  ARC: Make way for pt_regs != user_regs_struct
  ARC: intc: split into ARCompact ISA specific, common bits

 arch/arc/include/asm/arcregs.h          |   3 -
 arch/arc/include/asm/entry-compact.h    | 307 +++++++++++++++++++
 arch/arc/include/asm/entry.h            | 357 +---------------------
 arch/arc/include/asm/irqflags-compact.h | 181 +++++++++++
 arch/arc/include/asm/irqflags.h         | 168 +---------
 arch/arc/kernel/Makefile                |   4 +-
 arch/arc/kernel/entry-compact.S         | 393 ++++++++++++++++++++++++
 arch/arc/kernel/entry.S                 | 527 +++++---------------------------
 arch/arc/kernel/intc-compact.c          | 230 ++++++++++++++
 arch/arc/kernel/irq.c                   | 210 -------------
 arch/arc/kernel/process.c               |   3 +-
 arch/arc/kernel/ptrace.c                |  90 +++++-
 arch/arc/kernel/signal.c                |  55 +++-
 arch/arc/mm/Makefile                    |   2 +-
 arch/arc/mm/{cache_arc700.c => cache.c} | 367 ++++++++++------------
 arch/arc/mm/tlbex.S                     |  16 +-
 16 files changed, 1494 insertions(+), 1419 deletions(-)
 create mode 100644 arch/arc/include/asm/entry-compact.h
 create mode 100644 arch/arc/include/asm/irqflags-compact.h
 create mode 100644 arch/arc/kernel/entry-compact.S
 create mode 100644 arch/arc/kernel/intc-compact.c
 rename arch/arc/mm/{cache_arc700.c => cache.c} (77%)

-- 
1.9.1
