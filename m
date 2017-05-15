From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/5] of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
Date: Mon, 15 May 2017 20:14:47 +0900
Message-ID: <1494846888-18966-5-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Having arch/$(SRCARCH)/boot/dts as an include search path is not
very useful these days because some architectures such as ARM64,
MIPS have no DT in this directory.  Instead, they have DT in vendor
sub-directories.

With some DT files in ARM and PowerPC fixed, we can now drop this
include search path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 011d464..9c8f38a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -174,7 +174,6 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 ld_flags       = $(LDFLAGS) $(ldflags-y)
 
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
-		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
 		 -I$(srctree)/scripts/dtc/include-prefixes               \
 		 -undef -D__DTS__
 
-- 
2.7.4
