From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 03/18] arm64: ensure the kernel is compiled for LP64
Date: Wed, 17 Aug 2016 14:46:28 +0300
Message-ID: <1471434403-25291-4-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <libc-alpha-return-72561-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

From: Andrew Pinski <apinski@cavium.com>

The kernel needs to be compiled as a LP64 binary for ARM64, even when
using a compiler that defaults to code-generation for the ILP32 ABI.
Consequently, we need to explicitly pass '-mabi=lp64' (supported on
gcc-4.9 and newer).

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b54f8c..4800227 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -34,14 +34,19 @@ KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 KBUILD_AFLAGS	+= $(lseinstr)
 
+KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
+KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
 LD		+= -EB
+LDFLAGS		+= -maarch64linuxb
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 AS		+= -EL
 LD		+= -EL
+LDFLAGS		+= -maarch64linux
 endif
 
 CHECKFLAGS	+= -D__aarch64__
-- 
2.7.4
