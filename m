From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 16/16] ktest: remove obsolete architectures
Date: Wed, 14 Mar 2018 15:53:07 +0100
Message-ID: <20180314145317.2128199-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

A number of architectures are being removed from the kernel, so
we no longer need to test them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/testing/ktest/examples/crosstests.conf | 31 +---------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/tools/testing/ktest/examples/crosstests.conf b/tools/testing/ktest/examples/crosstests.conf
index a1203148dfa1..6907f32590b2 100644
--- a/tools/testing/ktest/examples/crosstests.conf
+++ b/tools/testing/ktest/examples/crosstests.conf
@@ -59,7 +59,7 @@ DO_DEFAULT := 1
 
 # By setting both DO_FAILED and DO_DEFAULT to zero, you can pick a single
 # arch that you want to test. (uncomment RUN and chose your arch)
-#RUN := m32r
+#RUN := arm
 
 # At the bottom of the config file exists a bisect test. You can update that
 # test and set DO_FAILED and DO_DEFAULT to zero, and uncomment this variable
@@ -106,33 +106,11 @@ TEST_START IF ${RUN} == arm || ${DO_DEFAULT}
 CROSS = arm-unknown-linux-gnueabi
 ARCH = arm
 
-# black fin
-TEST_START IF ${RUN} == bfin || ${DO_DEFAULT}
-CROSS = bfin-uclinux
-ARCH = blackfin
-BUILD_OPTIONS = -j8 vmlinux
-
-# cris - FAILS?
-TEST_START IF ${RUN} == cris || ${RUN} == cris64 || ${DO_FAILED}
-CROSS = cris-linux
-ARCH = cris
-
-# cris32 - not right arch?
-TEST_START IF ${RUN} == cris || ${RUN} == cris32 || ${DO_FAILED}
-CROSS = crisv32-linux
-ARCH = cris
-
 # ia64
 TEST_START IF ${RUN} == ia64 || ${DO_DEFAULT}
 CROSS = ia64-linux
 ARCH = ia64
 
-# frv
-TEST_START IF ${RUN} == frv || ${DO_FAILED}
-CROSS = frv-linux
-ARCH = frv
-GCC_VER = 4.5.1
-
 # m68k fails with error?
 TEST_START IF ${RUN} == m68k || ${DO_DEFAULT}
 CROSS = m68k-linux
@@ -148,13 +126,6 @@ TEST_START IF ${RUN} == mips || ${RUN} == mips32 || ${DO_DEFAULT}
 CROSS = mips-linux
 ARCH = mips
 
-# m32r
-TEST_START IF ${RUN} == m32r || ${DO_FAILED}
-CROSS = m32r-linux
-ARCH = m32r
-GCC_VER = 4.5.1
-BUILD_OPTIONS = -j8 vmlinux
-
 # parisc64 failed?
 TEST_START IF ${RUN} == hppa || ${RUN} == hppa64 || ${DO_FAILED}
 CROSS = hppa64-linux
-- 
2.9.0
