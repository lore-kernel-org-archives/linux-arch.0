From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/2] restrict /dev/mem to idle io memory ranges
Date: Mon, 23 Nov 2015 16:05:53 -0800
Message-ID: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27278 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbbKXAGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Nov 2015 19:06:21 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will.deacon@arm.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org

Changes since v1 [1]:

1/ Introduce ARCH_HAS_DEVMEM_IS_ALLOWED to flag archs where
   CONFIG_STRICT_DEVMEM will compile (Ingo)

2/ Drop "default y" for s390 (Heiko)

3/ Fix iomem_is_exclusive() return value in the
   CONFIG_IO_STRICT_DEVMEM=y case.

[1]: https://lkml.org/lkml/2015/11/21/183

---

Dan Williams (2):
      arch: consolidate CONFIG_STRICT_DEVM in lib/Kconfig.debug
      restrict /dev/mem to idle io memory ranges


 arch/arm/Kconfig             |    1 +
 arch/arm/Kconfig.debug       |   14 --------------
 arch/arm64/Kconfig           |    1 +
 arch/arm64/Kconfig.debug     |   14 --------------
 arch/frv/Kconfig             |    1 +
 arch/m32r/Kconfig            |    1 +
 arch/powerpc/Kconfig         |    1 +
 arch/powerpc/Kconfig.debug   |   12 ------------
 arch/s390/Kconfig            |    1 +
 arch/s390/Kconfig.debug      |   12 ------------
 arch/tile/Kconfig            |    4 +---
 arch/unicore32/Kconfig       |    1 +
 arch/unicore32/Kconfig.debug |   14 --------------
 arch/x86/Kconfig             |    1 +
 arch/x86/Kconfig.debug       |   17 -----------------
 kernel/resource.c            |   11 +++++++++--
 lib/Kconfig.debug            |   39 +++++++++++++++++++++++++++++++++++++++
 17 files changed, 57 insertions(+), 88 deletions(-)
