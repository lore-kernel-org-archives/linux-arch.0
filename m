From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
Date: Tue, 11 Apr 2017 13:28:44 +0100
Message-ID: <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pci@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Matt Turner <mattst88@gmail.com>, Haa
List-Id: linux-arch.vger.kernel.org

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
Posting") mandate non-posted configuration transactions. As further
highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
Considerations for the Enhanced Configuration Access Mechanism"),
through ECAM and ECAM-derivative configuration mechanism, the memory
mapped transactions from the host CPU into Configuration Requests on the
PCI express fabric may create ordering problems for software because
writes to memory address are typically posted transactions (unless the
architecture can enforce through virtual address mapping non-posted
write transactions behaviour) but writes to Configuration Space are not
posted on the PCI express fabric.

Current DT and ACPI host bridge controllers map PCI configuration space
(ECAM and ECAM-derivative) into the virtual address space through
ioremap() calls, that are non-cacheable device accesses on most
architectures, but may provide "bufferable" or "posted" write semantics
in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
to be buffered in the bus connecting the host CPU to the PCI fabric;
this behaviour, as underlined in the PCIe specifications, may trigger
transactions ordering rules and must be prevented.

Introduce a new generic and explicit API to create a memory mapping for
ECAM and ECAM-derivative config space area (and a corresponding generic
asm-generic header file) that defaults to ioremap_nocache() (which
should provide a sane default behaviour) and can be included by
all architectures that do not require an arch specific memory mapping
for ioremap_nopost() to guarantee non-posted writes behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/ioremap-nopost.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/asm-generic/ioremap-nopost.h

diff --git a/include/asm-generic/ioremap-nopost.h b/include/asm-generic/ioremap-nopost.h
new file mode 100644
index 0000000..015911f
--- /dev/null
+++ b/include/asm-generic/ioremap-nopost.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_GENERIC_IOREMAP_NOPOST_H
+#define __ASM_GENERIC_IOREMAP_NOPOST_H
+
+static inline void __iomem *ioremap_nopost(phys_addr_t offset, size_t size)
+{
+	return ioremap_nocache(offset, size);
+}
+
+#endif /* __ASM_GENERIC_IOREMAP_NOPOST_H */
-- 
2.10.0
