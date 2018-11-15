From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] arm: remove EISA kconfig option
Date: Thu, 15 Nov 2018 20:05:29 +0100
Message-ID: <20181115190538.17016-2-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
which provides support for things like PCI to EISA bridges, so it is most
likely dead.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..f24a7435d19a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -163,21 +163,6 @@ config HAVE_PROC_CPU
 config NO_IOPORT_MAP
 	bool
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
 config SBUS
 	bool
 
-- 
2.19.1
