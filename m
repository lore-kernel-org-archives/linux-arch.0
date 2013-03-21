From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: host gcc 4.7 warning when generating defconfig
Date: Thu, 21 Mar 2013 12:20:21 +0530
Message-ID: <514AADAD.1060503@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi,

We do cross compile builds for ARC Linux. To avoid the env var set, we have a
defconfig entry for CONFIG_CROSS_COMPILE.
This worked fine so far (host gcc 4.4 i.e.). When switched to a new host distro
(gcc 4.7), a defconfig build spews out the warning.

------------------->8--------------------------
mymake defconfig
gcc: error: unrecognized command line option '-marc600'
gcc: error: unrecognized command line option '-mA7'
gcc: error: unrecognized command line option '-mno-sdata'
gcc: error: unrecognized command line option '-mno-mpy'
*** Default configuration is based on 'fpga_defconfig'
#
# configuration written to .config
------------------->8--------------------------

While the following trivial fix seems to fix this, it seems that the spew is
coming due to LIBGCC definition line, which is strange to be called for defconfig
generation. Any thoughts ?

---------------->
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 4232d4e..97e6c20 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -8,6 +8,10 @@
 
 UTS_MACHINE := arc
 
+ifeq ($(CROSS_COMPILE),)
+#CROSS_COMPILE := arc-elf32-
+endif
+
 KBUILD_DEFCONFIG := fpga_defconfig

Thx,
-Vineet
