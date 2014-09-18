From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [PATCH v11 01/10] Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
Date: Thu, 18 Sep 2014 02:30:16 +0100
Message-ID: <1411003825-21521-2-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Device Tree ML <devicetree@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Tanmay Inamdar <tinamdar@apm.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

The inline version of ioport_map() that gets used when !CONFIG_GENERIC_IOMAP
is wrong. It returns a mapped (i.e. virtual) address that can start from
zero and completely ignores the PCI_IOBASE and IO_SPACE_LIMIT that most
architectures that use !CONFIG_GENERIC_MAP define.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Tanmay Inamdar <tinamdar@apm.com>
---
 include/asm-generic/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 975e1cc..2e2161b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -331,7 +331,7 @@ static inline void iounmap(void __iomem *addr)
 #ifndef CONFIG_GENERIC_IOMAP
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return (void __iomem *) port;
+	return (void __iomem *)(PCI_IOBASE + (port & IO_SPACE_LIMIT));
 }
 
 static inline void ioport_unmap(void __iomem *p)
-- 
2.1.0
