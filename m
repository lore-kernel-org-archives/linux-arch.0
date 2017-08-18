From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 5/6] drivers: pci: add support for relative addressing in quirk tables
Date: Fri, 18 Aug 2017 12:26:23 +0100
Message-ID: <20170818112624.24991-6-ard.biesheuvel@linaro.org>
References: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Steve
List-Id: linux-arch.vger.kernel.org

Allow the PCI quirk tables to be emitted in a way that avoids absolute
references to the hook functions. This reduces the size of the entries,
and, more importantly, makes them invariant under runtime relocation
(e.g., for KASLR)

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/quirks.c |  6 ++--
 include/linux/pci.h  | 32 ++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6967c6b4cf6b..0a7ba8c7f1f6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3547,9 +3547,9 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		     f->vendor == (u16) PCI_ANY_ID) &&
 		    (f->device == dev->device ||
 		     f->device == (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
+			calltime = fixup_debug_start(dev, pci_fixup_hook(f));
+			pci_fixup_hook(f)(dev);
+			fixup_debug_report(dev, calltime, pci_fixup_hook(f));
 		}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a75c13673852..58eb4e7a15c3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1735,7 +1735,11 @@ struct pci_fixup {
 	u16 device;		/* You can use PCI_ANY_ID here of course */
 	u32 class;		/* You can use PCI_ANY_ID here too */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	int hook_offset;
+#else
 	void (*hook)(struct pci_dev *dev);
+#endif
 };
 
 enum pci_fixup_pass {
@@ -1749,6 +1753,27 @@ enum pci_fixup_pass {
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook)			\
+	__ADDRESSABLE(hook)						\
+	asm(".section "	#sec ", \"a\"\n"				\
+	    ".balign	16\n"						\
+	    ".short "	#vendor ", " #device "\n"			\
+	    ".long "	#class ", " #class_shift "\n"			\
+	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .\n"		\
+	    ".previous\n")
+#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)			\
+	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)
+
+static inline
+void (*pci_fixup_hook(const struct pci_fixup *f))(struct pci_dev *)
+{
+	return (void *)((unsigned long)&f->hook_offset + f->hook_offset);
+}
+#else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
 				  class_shift, hook)			\
@@ -1756,6 +1781,13 @@ enum pci_fixup_pass {
 	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
 		= { vendor, device, class, class_shift, hook };
 
+static inline
+void (*pci_fixup_hook(const struct pci_fixup *f))(struct pci_dev *)
+{
+	return f->hook;
+}
+#endif
+
 #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
 					 class_shift, hook)		\
 	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,			\
-- 
2.11.0
