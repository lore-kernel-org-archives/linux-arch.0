From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/5] of: add scripts/dtc/include-prefixes to search path for both CPP and DTC
Date: Mon, 15 May 2017 20:14:48 +0900
Message-ID: <1494846888-18966-6-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

We had include/dt-bindings as an include path only for CPP, and this
makes sense because header files in dt-bindings contain useful macros
that parsed by pre-processor.

Commit 4027494ae6e3 ("ARM: dts: add arm/arm64 include symlinks") and
commit 0a6081b673bb ("arm64: dts: add arm/arm64 include symlinks")
allow us cross-arch DT reference, but this is only available for
CPP's include directives, like
    #include <arm/foo.dtsi>

It makes as much sense to include DT from another architecture by
DTC's builtin include directive, like
    /include/ "arm/foo.dtsi"

To achieve this, scripts/dtc/include-prefixes should be passed to
both CPP and DTC.  I refactored Makefile.lib a bit to not repeat the
same path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9c8f38a..dcc0d5f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -173,8 +173,10 @@ cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 
 ld_flags       = $(LDFLAGS) $(ldflags-y)
 
+DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
+
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
-		 -I$(srctree)/scripts/dtc/include-prefixes               \
+		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
 # Finds the multi-part object the current object will be linked into
@@ -315,7 +317,7 @@ quiet_cmd_dtc = DTC     $@
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) $(DTC_FLAGS) \
+		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
-- 
2.7.4
