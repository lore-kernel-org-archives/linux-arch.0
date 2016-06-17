From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 19/19] arm64:ilp32: add ARM64_ILP32 to Kconfig
Date: Sat, 18 Jun 2016 02:54:28 +0300
Message-ID: <1466207668-10549-20-git-send-email-ynorov@caviumnetworks.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

From: Andrew Pinski <apinski@cavium.com>

This patch adds the config option for ILP32.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Kconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f5735ec..2897648 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -972,7 +972,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool
-	depends on AARCH32_EL0
+	depends on AARCH32_EL0 || ARM64_ILP32
 
 config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
@@ -994,6 +994,14 @@ config AARCH32_EL0
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config ARM64_ILP32
+	bool "Kernel support for ILP32"
+	select COMPAT
+	help
+	  This option enables support for AArch64 ILP32 user space.  ILP32
+	  is an ABI where long and pointers are 32bits but it uses the AARCH64
+	  instruction set.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
-- 
2.7.4
