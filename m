From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 4/5] of/powerpc: Move build to use generic dts->dtb rule
Date: Tue, 16 Nov 2010 14:41:39 -0800
Message-ID: <dae91d8292876db96f96896b79076c32cd2bf467.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1289943240.git.dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch changes arch/powerpc/boot/Makefile to use the generic
rule build the device tree blobs in scripts/Makefile.lib

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/powerpc/boot/Makefile |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index fae8192..d90c674 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -147,8 +147,6 @@ targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
-dtstree		:= $(srctree)/$(src)/dts
-
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
 			$(wrapper) FORCE
@@ -331,11 +329,6 @@ $(obj)/treeImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
 
-# Rule to build device tree blobs
-DTC = $(objtree)/scripts/dtc/dtc
-
-$(obj)/%.dtb: $(dtstree)/%.dts
-	$(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts
 
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
-- 
1.7.2.3
