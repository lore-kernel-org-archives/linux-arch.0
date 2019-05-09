Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEIMyB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 May 2019 08:54:01 -0400
From: guoren@kernel.org
Subject: [GIT PULL] csky perf unwind libdw patch for v5.2-rc1
Date: Thu,  9 May 2019 20:53:53 +0800
Message-ID: <1557406433-28868-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190509125353.7bc4fdPwz-uZoYxuZYUAbBnxaBoWtpSOHYDsHXHt0lM@z>

Hi Linus,

Another csky perf unwind libdw patch for v5.2-rc1:

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-perf-unwind-libdw

for you to fetch changes up to 3213486f2e442831e324cc6201a2f9e924ecc235:

  csky: Add support for perf unwind-libdw (2019-05-09 20:36:42 +0800)

----------------------------------------------------------------
arch/csky perf unwind libdw patch for v5.2-rc1

Here is another patch for arch/csky v5.2-rc1:

 - Add support for perf unwind-libdw

----------------------------------------------------------------
Mao Han (1):
      csky: Add support for perf unwind-libdw

 tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
 tools/perf/Makefile.config                   |   6 +-
 tools/perf/arch/csky/Build                   |   1 +
 tools/perf/arch/csky/Makefile                |   3 +
 tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
 tools/perf/arch/csky/util/unwind-libdw.c     |  77 +++++++++++++++++++++
 8 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
