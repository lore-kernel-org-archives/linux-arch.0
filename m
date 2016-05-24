Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0076.outbound.protection.outlook.com ([207.46.100.76]:17680
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752441AbcEXAFL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 May 2016 20:05:11 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 02/23] all: introduce COMPAT_WRAPPER option and enable it for s390
Date: Tue, 24 May 2016 03:04:31 +0300
Message-ID: <1464048292-30136-3-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
Message-ID: <20160524000431.gNcJY15BbePW-LUFQiQ34Pgba83-iH--YmAWRwlANoM@z>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/Kconfig      | 4 ++++
 arch/s390/Kconfig | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 81869a5..92fcbd4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -589,6 +589,10 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config COMPAT_WRAPPER
+	bool
+	depends on COMPAT
+
 #
 # ABI hall of shame
 #
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf24ab1..6d643b3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -340,6 +340,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select COMPAT_WRAPPER
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
-- 
2.5.0

