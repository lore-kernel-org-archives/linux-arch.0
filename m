Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbfH2PvK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:10 -0400
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 2/2] docs: powerpc: Add ELF note documentation
Date: Thu, 29 Aug 2019 12:50:21 -0300
Message-ID: <20190829155021.2915-3-maxiwell@linux.ibm.com>
In-Reply-To: <20190829155021.2915-1-maxiwell@linux.ibm.com>
References: <20190829155021.2915-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au, andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com, cclaudio@linux.ibm.com, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190829155021.SKMi-ApRyU3Kb41RLzd-fGTIGD1ja5kEAHtxD37STlY@z>

The ELF note documentation describes the types and descriptors to be
used with the PowerPC namespace.

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
---
 Documentation/powerpc/elfnote.rst | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/powerpc/elfnote.rst

diff --git a/Documentation/powerpc/elfnote.rst b/Documentation/powerpc/elfnote.rst
new file mode 100644
index 000000000000..2a5c4beeb809
--- /dev/null
+++ b/Documentation/powerpc/elfnote.rst
@@ -0,0 +1,42 @@
+==========================
+ELF Note PowerPC Namespace
+==========================
+
+The PowerPC namespace in an ELF Note of the kernel binary is used to store
+capabilities and information which can be used by a bootloader or userland.
+
+Types and Descriptors
+---------------------
+
+The types to be used with the "PowerPC" namesapce are defined in the
+include/uapi/asm/elfnote.h
+
+	1) PPC_ELFNOTE_CAPABILITIES
+
+Define the capabilities supported/required by the kernel. This type uses a
+bitmap as "descriptor" field. Each bit is described below:
+
+- Ultravisor-capable bit (PowerNV only).
+
+	#define PPCCAP_ULTRAVISOR_BIT (1 << 0)
+
+	Indicate that the powerpc kernel binary knows how to run in an
+	ultravisor-enabled system.
+
+	In an ultravisor-enabled system, some machine resources are now controlled
+	by the ultravisor. If the kernel is not ultravisor-capable, but it ends up
+	being run on a machine with ultravisor, the kernel will probably crash
+	trying to access ultravisor resources. For instance, it may crash in early
+	boot trying to set the partition table entry 0.
+
+	In an ultravisor-enabled system, a bootloader could warn the user or prevent
+   	the kernel from being run if the PowerPC ultravisor capability doesn't exist
+	or the Ultravisor-capable bit is not set.
+
+References
+----------
+
+arch/powerpc/include/asm/elfnote.h
+arch/powerpc/kernel/note.S
+
+
-- 
2.20.1
