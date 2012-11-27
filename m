From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V7 2/7] ARM: dt: change .dtb build rules to build in dts
 directory
Date: Tue, 27 Nov 2012 16:29:11 -0700
Message-ID: <1354058956-7199-2-git-send-email-swarren@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Marek <mmarek@suse.cz>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>

The current rules have the .dtb files build in a different directory
from the .dts files. The only reason for this is that it was what
PowerPC has done historically. This patch changes ARM to use the generic
dtb rule which builds .dtb files in the same directory as the source .dts.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
[swarren: added rm command for old stale .dtb files]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v7: New patch.
---
 arch/arm/Makefile          |    4 ++--
 arch/arm/boot/Makefile     |   12 ------------
 arch/arm/boot/dts/Makefile |    8 ++++++++
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1ec5f67..5f92252 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -291,10 +291,10 @@ zinstall uinstall install: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
 %.dtb: scripts
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
 
 dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
+	$(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) dtbs
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 9137df5..abfce28 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -15,8 +15,6 @@ ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
-include $(srctree)/arch/arm/boot/dts/Makefile
-
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
@@ -59,16 +57,6 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 
 endif
 
-targets += $(dtb-y)
-
-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/dts/%.dts FORCE
-	$(call if_changed_dep,dtc)
-
-$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
-
-clean-files := *.dtb
-
 ifneq ($(LOADADDR),)
   UIMAGE_LOADADDR=$(LOADADDR)
 else
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a17d5ab..cb217f8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,4 +136,12 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 	wm8650-mid.dtb
 dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb
 
+targets += dtbs
 endif
+
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	# *.dtb used to be generated in the directory above. Clean out the
+	# old build results so people don't accidentally use them.
+	rm -f $(obj)/../*.dtb
+
+clean-files := *.dtb
-- 
1.7.10.4
