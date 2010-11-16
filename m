From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/5] x86/of:  Add building device tree blob(s) into image.
Date: Tue, 16 Nov 2010 14:41:38 -0800
Message-ID: <35263573f57fd7e780dede628cf489212bfa1400.1289943240.git.dirk.brandewie@gmail.com>
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

This patch adds linking device tree blobs into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.
e.g:
  obj-$(CONFIG_TEST_DTB) += test.dtb.o

The set of DTB linked into the image is controlled the Kconfig file
in arch/x86/kernel/dts/Kconfig

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/x86/Kconfig            |    6 +++++-
 arch/x86/kernel/Makefile    |    6 ++++++
 arch/x86/kernel/dts/Kconfig |    7 +++++++
 3 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100644 arch/x86/kernel/dts/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5904f38..f2f516a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -299,13 +299,17 @@ config X86_BIGSMP
 	---help---
 	  This option is needed for the systems that have more than 8 CPUs
 
-config X86_OF
+menuconfig X86_OF
 	bool "Support for device tree"
 	select OF
 	select OF_FLATTREE
 	---help---
 	  Device tree support on X86.
 
+if X86_OF
+source arch/x86/kernel/dts/Kconfig
+endif
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 586df14..49e017d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -114,6 +114,12 @@ obj-$(CONFIG_SWIOTLB)			+= pci-swiotlb.o
 obj-$(CONFIG_X86_OF)			+= prom.o
 
 ###
+# device tree blobs
+obj-$(CONFIG_CE4100_DTB) += ce4100.dtb.o
+obj-$(CONFIG_TEST_DTB) += test.dtb.o
+
+
+###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_AUDIT)		+= audit_64.o
diff --git a/arch/x86/kernel/dts/Kconfig b/arch/x86/kernel/dts/Kconfig
new file mode 100644
index 0000000..d3e5cd4
--- /dev/null
+++ b/arch/x86/kernel/dts/Kconfig
@@ -0,0 +1,7 @@
+config CE4100_DTB
+       bool "Intel CE4100"
+
+config TEST_DTB
+       bool "Test DTS"
+
+
-- 
1.7.2.3
