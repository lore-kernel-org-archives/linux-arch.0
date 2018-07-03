Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43709 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeGCFos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jul 2018 01:44:48 -0400
From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/6] Introduce struct __kernel_timex
Date: Mon,  2 Jul 2018 22:44:16 -0700
Message-ID: <20180703054422.12089-1-deepa.kernel@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com, davem@davemloft.net, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20180703054416.cSDvWfPciEoUA9wfPQRoY1MuS4b12KkulpLuEfr7VHQ@z>

The series introduces struct __kernel_timex as a substitute for
the non y2038 safe struct timex.

The series is based on the original series posted by Arnd Bergmann
in [1].

The overview of the series is as below:
1. Prepare for the compat timex interfaces to be used unconditionally.
2. Introduce struct __kernel_timex.
3. Use struct __kernel_timex in place of struct timex.
4. Switch syscalls to use struct __kernel_timex.

Deepa Dinamani (6):
  arm64: Make basic compat_* types always available
  sparc: Make thread_info.h available directly
  timex: prepare compat helpers for y2038 changes
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/alpha/kernel/osf_sys.c     |  2 +-
 arch/arm64/include/asm/compat.h | 22 ++++-----
 arch/sparc/include/asm/compat.h |  2 +
 drivers/ptp/ptp_clock.c         |  2 +-
 include/asm-generic/compat.h    |  8 +++-
 include/linux/compat.h          | 33 --------------
 include/linux/compat_time.h     | 34 ++++++++++++++
 include/linux/posix-clock.h     |  2 +-
 include/linux/syscalls.h        |  5 +--
 include/linux/timex.h           |  9 +++-
 include/uapi/linux/timex.h      | 41 +++++++++++++++++
 kernel/compat.c                 | 63 --------------------------
 kernel/time/ntp.c               | 12 ++---
 kernel/time/ntp_internal.h      |  2 +-
 kernel/time/posix-clock.c       |  2 +-
 kernel/time/posix-timers.c      | 14 ++----
 kernel/time/posix-timers.h      |  2 +-
 kernel/time/time.c              | 80 ++++++++++++++++++++++++++++++---
 kernel/time/timekeeping.c       |  4 +-
 19 files changed, 198 insertions(+), 141 deletions(-)


base-commit: 69877f06915f1c7a9f1704442993bcc12c13ace2
-- 
2.17.1

Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: netdev@vger.kernel.org
