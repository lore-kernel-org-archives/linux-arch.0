From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] of: search scripts/dtc/include-prefixes path for both CPP and DTC
Date: Tue, 25 Jul 2017 11:23:36 +0900
Message-ID: <1500949416-24105-4-git-send-email-yamada.masahiro@socionext.com>
References: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since commit d5d332d3f7e8 ("devicetree: Move include prefixes from
arch to separate directory"), cross-arch DT reference works well,
but only for CPP style #include directives.

It makes as much sense to share DT between different architectures
by using DTC's /include/ directives.

So, scripts/dtc/include-prefixes should be passed to both CPP and DTC.
I refactored Makefile.lib a bit to not repeat the same path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9c8f38ac2620..dcc0d5fdf5a2 100644
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

