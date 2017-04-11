From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 02/32] asm-generic/pgtable.h: introduce pgprot_nonposted
 remap attribute
Date: Tue, 11 Apr 2017 13:28:42 +0100
Message-ID: <20170411122923.6285-3-lorenzo.pieralisi@arm.com>
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

According to the PCI local bus specifications (Revision 3.0, 3.2.5),
I/O Address space transactions are non-posted. On architectures where
I/O space is implemented through a chunk of memory mapped space mapped
to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
region backing I/O Address Space transactions determines the I/O
transactions attributes (before the transactions actually reaches the
PCI bus where it is handled according to the PCI specifications).

The kernel lacks a pgprot_* attribute to map memory with type
generating non-posted writes transactions, which therefore needs to
be added.

Add a pgprot_nonposted mapping prot to create a memory mapping for
memory areas requiring non-posted write transactions; make it default to
pgprot_noncached (which should provide a sane default behaviour) but
still allowing architectures on which pgprot_noncached results in posted
write transactions to override the prot with an arch specific
implementation that guarantees non-posted writes transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 1fad160..2070172 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -399,6 +399,10 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 #define pgprot_device pgprot_noncached
 #endif
 
+#ifndef pgprot_nonposted
+#define pgprot_nonposted pgprot_noncached
+#endif
+
 #ifndef pgprot_modify
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
-- 
2.10.0
