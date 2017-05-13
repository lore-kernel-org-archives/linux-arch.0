From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] devicetree: Move include prefixes from arch to separate directory
Date: Fri, 12 May 2017 20:34:31 -0700
Message-ID: <1494646471-24624-1-git-send-email-olof@lixom.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33002 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdEMDfG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2017 23:35:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id a23so8946180pfe.0
        for <linux-arch@vger.kernel.org>; Fri, 12 May 2017 20:35:06 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>

We use a directory under arch/$ARCH/boot/dts as an include path
that has links outside of the subtree to find dt-bindings from under
include/dt-bindings. That's been working well, but new DT architectures
haven't been adding them by default.

Recently there's been a desire to share some of the DT material between
arm and arm64, which originally caused developers to create symlinks or
relative includes between the subtrees. This isn't ideal -- it breaks
if the DT files aren't stored in the exact same hierarchy as the kernel
tree, and generally it's just icky.

As a somewhat cleaner solution we decided to add a $ARCH/ prefix link
once, and allow DTS files to reference dtsi (and dts) files in other
architectures that way.

Original approach was to create these links under each architecture,
but it lead to the problem of recursive symlinks.

As a remedy, move the include link directories out of the architecture
trees into a common location. At the same time, they can now share one
directory and one dt-bindings/ link as well.

Fixes: 4027494ae6e3 ('ARM: dts: add arm/arm64 include symlinks')
Reported-by: Russell King <linux@armlinux.org.uk>
Reported-by: Omar Sandoval <osandov@osandov.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/include/arm             | 1 -
 arch/arm/boot/dts/include/arm64           | 1 -
 arch/arm/boot/dts/include/dt-bindings     | 1 -
 arch/arm64/boot/dts/include/arm           | 1 -
 arch/arm64/boot/dts/include/arm64         | 1 -
 arch/arm64/boot/dts/include/dt-bindings   | 1 -
 arch/cris/boot/dts/include/dt-bindings    | 1 -
 arch/metag/boot/dts/include/dt-bindings   | 1 -
 arch/mips/boot/dts/include/dt-bindings    | 1 -
 arch/powerpc/boot/dts/include/dt-bindings | 1 -
 scripts/Makefile.lib                      | 2 +-
 scripts/dtc/include-prefixes/arc          | 1 +
 scripts/dtc/include-prefixes/arm          | 1 +
 scripts/dtc/include-prefixes/arm64        | 1 +
 scripts/dtc/include-prefixes/c6x          | 1 +
 scripts/dtc/include-prefixes/cris         | 1 +
 scripts/dtc/include-prefixes/dt-bindings  | 1 +
 scripts/dtc/include-prefixes/h8300        | 1 +
 scripts/dtc/include-prefixes/metag        | 1 +
 scripts/dtc/include-prefixes/microblaze   | 1 +
 scripts/dtc/include-prefixes/mips         | 1 +
 scripts/dtc/include-prefixes/nios2        | 1 +
 scripts/dtc/include-prefixes/openrisc     | 1 +
 scripts/dtc/include-prefixes/powerpc      | 1 +
 scripts/dtc/include-prefixes/sh           | 1 +
 scripts/dtc/include-prefixes/xtensa       | 1 +
 26 files changed, 16 insertions(+), 11 deletions(-)
 delete mode 120000 arch/arm/boot/dts/include/arm
 delete mode 120000 arch/arm/boot/dts/include/arm64
 delete mode 120000 arch/arm/boot/dts/include/dt-bindings
 delete mode 120000 arch/arm64/boot/dts/include/arm
 delete mode 120000 arch/arm64/boot/dts/include/arm64
 delete mode 120000 arch/arm64/boot/dts/include/dt-bindings
 delete mode 120000 arch/cris/boot/dts/include/dt-bindings
 delete mode 120000 arch/metag/boot/dts/include/dt-bindings
 delete mode 120000 arch/mips/boot/dts/include/dt-bindings
 delete mode 120000 arch/powerpc/boot/dts/include/dt-bindings
 create mode 120000 scripts/dtc/include-prefixes/arc
 create mode 120000 scripts/dtc/include-prefixes/arm
 create mode 120000 scripts/dtc/include-prefixes/arm64
 create mode 120000 scripts/dtc/include-prefixes/c6x
 create mode 120000 scripts/dtc/include-prefixes/cris
 create mode 120000 scripts/dtc/include-prefixes/dt-bindings
 create mode 120000 scripts/dtc/include-prefixes/h8300
 create mode 120000 scripts/dtc/include-prefixes/metag
 create mode 120000 scripts/dtc/include-prefixes/microblaze
 create mode 120000 scripts/dtc/include-prefixes/mips
 create mode 120000 scripts/dtc/include-prefixes/nios2
 create mode 120000 scripts/dtc/include-prefixes/openrisc
 create mode 120000 scripts/dtc/include-prefixes/powerpc
 create mode 120000 scripts/dtc/include-prefixes/sh
 create mode 120000 scripts/dtc/include-prefixes/xtensa

diff --git a/arch/arm/boot/dts/include/arm b/arch/arm/boot/dts/include/arm
deleted file mode 120000
index a96aa0e..0000000
--- a/arch/arm/boot/dts/include/arm
+++ /dev/null
@@ -1 +0,0 @@
-..
\ No newline at end of file
diff --git a/arch/arm/boot/dts/include/arm64 b/arch/arm/boot/dts/include/arm64
deleted file mode 120000
index 074a835..0000000
--- a/arch/arm/boot/dts/include/arm64
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm64/boot/dts
\ No newline at end of file
diff --git a/arch/arm/boot/dts/include/dt-bindings b/arch/arm/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/arm/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/include/arm b/arch/arm64/boot/dts/include/arm
deleted file mode 120000
index cf63d80..0000000
--- a/arch/arm64/boot/dts/include/arm
+++ /dev/null
@@ -1 +0,0 @@
-../../../../arm/boot/dts
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/include/arm64 b/arch/arm64/boot/dts/include/arm64
deleted file mode 120000
index a96aa0e..0000000
--- a/arch/arm64/boot/dts/include/arm64
+++ /dev/null
@@ -1 +0,0 @@
-..
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/arm64/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/cris/boot/dts/include/dt-bindings b/arch/cris/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/cris/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/metag/boot/dts/include/dt-bindings b/arch/metag/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/metag/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/mips/boot/dts/include/dt-bindings b/arch/mips/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/mips/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/powerpc/boot/dts/include/dt-bindings b/arch/powerpc/boot/dts/include/dt-bindings
deleted file mode 120000
index 08c00e4..0000000
--- a/arch/powerpc/boot/dts/include/dt-bindings
+++ /dev/null
@@ -1 +0,0 @@
-../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c9f975a..2c759b0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -175,7 +175,7 @@ ld_flags       = $(LDFLAGS) $(ldflags-y)
 
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
-		 -I$(srctree)/arch/$(SRCARCH)/boot/dts/include           \
+		 -I$(srctree)/scripts/dtc/include-prefixes               \
 		 -I$(srctree)/drivers/of/testcase-data                   \
 		 -undef -D__DTS__
 
diff --git a/scripts/dtc/include-prefixes/arc b/scripts/dtc/include-prefixes/arc
new file mode 120000
index 0000000..5d21b5a
--- /dev/null
+++ b/scripts/dtc/include-prefixes/arc
@@ -0,0 +1 @@
+../../../arch/arc/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/arm b/scripts/dtc/include-prefixes/arm
new file mode 120000
index 0000000..eb14d45
--- /dev/null
+++ b/scripts/dtc/include-prefixes/arm
@@ -0,0 +1 @@
+../../../arch/arm/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/arm64 b/scripts/dtc/include-prefixes/arm64
new file mode 120000
index 0000000..275c42c
--- /dev/null
+++ b/scripts/dtc/include-prefixes/arm64
@@ -0,0 +1 @@
+../../../arch/arm64/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/c6x b/scripts/dtc/include-prefixes/c6x
new file mode 120000
index 0000000..49ded4c
--- /dev/null
+++ b/scripts/dtc/include-prefixes/c6x
@@ -0,0 +1 @@
+../../../arch/c6x/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/cris b/scripts/dtc/include-prefixes/cris
new file mode 120000
index 0000000..736d998
--- /dev/null
+++ b/scripts/dtc/include-prefixes/cris
@@ -0,0 +1 @@
+../../../arch/cris/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/dt-bindings b/scripts/dtc/include-prefixes/dt-bindings
new file mode 120000
index 0000000..04fdbb3
--- /dev/null
+++ b/scripts/dtc/include-prefixes/dt-bindings
@@ -0,0 +1 @@
+../../../include/dt-bindings
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/h8300 b/scripts/dtc/include-prefixes/h8300
new file mode 120000
index 0000000..3bdaa33
--- /dev/null
+++ b/scripts/dtc/include-prefixes/h8300
@@ -0,0 +1 @@
+../../../arch/h8300/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/metag b/scripts/dtc/include-prefixes/metag
new file mode 120000
index 0000000..87a3c84
--- /dev/null
+++ b/scripts/dtc/include-prefixes/metag
@@ -0,0 +1 @@
+../../../arch/metag/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/microblaze b/scripts/dtc/include-prefixes/microblaze
new file mode 120000
index 0000000..d983033
--- /dev/null
+++ b/scripts/dtc/include-prefixes/microblaze
@@ -0,0 +1 @@
+../../../arch/microblaze/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/mips b/scripts/dtc/include-prefixes/mips
new file mode 120000
index 0000000..ae8d494
--- /dev/null
+++ b/scripts/dtc/include-prefixes/mips
@@ -0,0 +1 @@
+../../../arch/mips/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/nios2 b/scripts/dtc/include-prefixes/nios2
new file mode 120000
index 0000000..5177233
--- /dev/null
+++ b/scripts/dtc/include-prefixes/nios2
@@ -0,0 +1 @@
+../../../arch/nios2/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/openrisc b/scripts/dtc/include-prefixes/openrisc
new file mode 120000
index 0000000..71c3bc7
--- /dev/null
+++ b/scripts/dtc/include-prefixes/openrisc
@@ -0,0 +1 @@
+../../../arch/openrisc/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/powerpc b/scripts/dtc/include-prefixes/powerpc
new file mode 120000
index 0000000..7cd6ec1
--- /dev/null
+++ b/scripts/dtc/include-prefixes/powerpc
@@ -0,0 +1 @@
+../../../arch/powerpc/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/sh b/scripts/dtc/include-prefixes/sh
new file mode 120000
index 0000000..67d3780
--- /dev/null
+++ b/scripts/dtc/include-prefixes/sh
@@ -0,0 +1 @@
+../../../arch/sh/boot/dts
\ No newline at end of file
diff --git a/scripts/dtc/include-prefixes/xtensa b/scripts/dtc/include-prefixes/xtensa
new file mode 120000
index 0000000..d1eaf6e
--- /dev/null
+++ b/scripts/dtc/include-prefixes/xtensa
@@ -0,0 +1 @@
+../../../arch/xtensa/boot/dts
\ No newline at end of file
-- 
2.1.4
