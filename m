Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHFEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id o9so3243309plk.6
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:05 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 26/37] tools: Add the lkl host library to the common tools Makefile
Date: Fri,  8 Nov 2019 14:02:41 +0900
Message-Id: <80f1531053e8ab8d67ff1995e82f8db75457e0dc.1573179553.git.thehajime@gmail.com>
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Thomas Liebetraut <thomas@tommie-lie.de>

From: Thomas Liebetraut <thomas@tommie-lie.de>

This patch includes the lkl host library to the Kernel tools buildsystem.
This also means that lkl can now be compiled like any other "tool" using:

  $ make tools/lkl ARCH=um UMMODE=library

Signed-off-by: Thomas Liebetraut <thomas@tommie-lie.de>
[Octavian: remove make ARCH=lkl defconfig as it is not (yet) necessary]
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 68defd7ecf5d..0506d7dde63f 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -23,6 +23,7 @@ help:
 	@echo '  kvm_stat               - top-like utility for displaying kvm statistics'
 	@echo '  leds                   - LEDs  tools'
 	@echo '  liblockdep             - user-space wrapper for kernel locking-validator'
+	@echo '  lkl                    - The Linux Kernel Library host libraries and tools'
 	@echo '  bpf                    - misc BPF tools'
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
@@ -63,7 +64,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup firewire hv guest spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
+cgroup firewire hv guest lkl spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging: FORCE
 	$(call descend,$@)
 
 liblockdep: FORCE
@@ -107,7 +108,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install firewire_install gpio_install hv_install iio_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
+cgroup_install firewire_install gpio_install hv_install iio_install lkl_install perf_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install:
 	$(call descend,$(@:_install=),install)
 
 liblockdep_install:
@@ -133,7 +134,7 @@ install: acpi_install cgroup_install cpupower_install gpio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
-		wmi_install pci_install debugging_install intel-speed-select_install
+		wmi_install lkl_install pci_install debugging_install intel-speed-select_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -141,7 +142,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean hv_clean firewire_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
+cgroup_clean hv_clean firewire_clean lkl_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean:
 	$(call descend,$(@:_clean=),clean)
 
 liblockdep_clean:
@@ -179,7 +180,7 @@ clean: acpi_clean cgroup_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean spi_clean usb_clean virtio_clean \
 		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean liblockdep_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
+		gpio_clean objtool_clean leds_clean wmi_clean lkl_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean
 
 .PHONY: FORCE
-- 
2.20.1 (Apple Git-117)
