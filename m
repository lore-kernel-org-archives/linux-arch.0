From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/3] pci: Move multiple declarations of
 pci_mmap_page_range() to <linux/pci.h>
Date: Wed, 15 Mar 2017 17:18:00 +0000
Message-ID: <1489598280.86622.14.camel@infradead.org>
References: <0e5266c6c883baa0e4a98dce796f8ab2ee18e71f.1489598108.git.dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-FCCFbISCFFY2xWogioOc"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51786 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdCORSQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2017 13:18:16 -0400
In-Reply-To: <0e5266c6c883baa0e4a98dce796f8ab2ee18e71f.1489598108.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-FCCFbISCFFY2xWogioOc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

We can declare it <linux/pci.h> even on platforms where it isn't going
to be defined. There's no need to have it littered through the various
<asm/pci.h> files.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm/include/asm/pci.h        | 2 --
 arch/arm64/include/asm/pci.h      | 2 --
 arch/cris/include/asm/pci.h       | 3 ---
 arch/ia64/include/asm/pci.h       | 2 --
 arch/microblaze/include/asm/pci.h | 3 ---
 arch/mips/include/asm/pci.h       | 3 ---
 arch/mn10300/include/asm/pci.h    | 3 ---
 arch/parisc/include/asm/pci.h     | 3 ---
 arch/powerpc/include/asm/pci.h    | 3 ---
 arch/sh/include/asm/pci.h         | 3 +--
 arch/sparc/include/asm/pci_64.h   | 4 ----
 arch/unicore32/include/asm/pci.h  | 2 --
 arch/x86/include/asm/pci.h        | 4 ----
 arch/xtensa/include/asm/pci.h     | 4 ----
 include/linux/pci.h               | 7 +++++++
 15 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 057d381..51118a0 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -29,8 +29,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define PCI_DMA_BUS_IS_PHYS     (1)
=20
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-                               enum pci_mmap_state mmap_state, int write_c=
ombine);
=20
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 53b1541..10fd0c2 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -39,8 +39,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
=20
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	1
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-			       enum pci_mmap_state mmap_state, int write_combine);
=20
 #endif  /* __KERNEL__ */
 #endif  /* __ASM_PCI_H */
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
index b1b289d..65198cb 100644
--- a/arch/cris/include/asm/pci.h
+++ b/arch/cris/include/asm/pci.h
@@ -42,9 +42,6 @@ struct pci_dev;
 #define PCI_DMA_BUS_IS_PHYS	(1)
=20
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-			       enum pci_mmap_state mmap_state, int write_combine);
-
=20
 #endif /* __KERNEL__ */
=20
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 6283758..fc60b3d 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -53,8 +53,6 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	1
=20
-extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct=
 *vma,
-				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/as=
m/pci.h
index 2a120bb..ab381d2 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -46,9 +46,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
 extern int pci_proc_domain(struct pci_bus *bus);
=20
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
=20
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 30d1129..3141e2a 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -111,9 +111,6 @@ extern void pcibios_set_master(struct pci_dev *dev);
=20
 #define HAVE_PCI_MMAP
=20
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
=20
 /*
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.=
h
index 51159ff..082b6de 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -74,9 +74,6 @@ static inline int pci_controller_num(struct pci_dev *dev)
 }
=20
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
=20
 #endif /* __KERNEL__ */
=20
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index defebd9..bb9ea90 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -201,7 +201,4 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev=
 *dev, int channel)
=20
 #define HAVE_PCI_MMAP
=20
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-	enum pci_mmap_state mmap_state, int write_combine);
-
 #endif /* __ASM_PARISC_PCI_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.=
h
index b5b68c6..55887d1 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -77,9 +77,6 @@ extern int pci_domain_nr(struct pci_bus *bus);
 extern int pci_proc_domain(struct pci_bus *bus);
=20
 struct vm_area_struct;
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
=20
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does =
WC */
 #define HAVE_PCI_MMAP		1
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 644314f..46abbc9 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -66,8 +66,7 @@ extern unsigned long PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM;
 struct pci_dev;
=20
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-	enum pci_mmap_state mmap_state, int write_combine);
+
 extern void pcibios_set_master(struct pci_dev *dev);
=20
 /* Dynamic DMA mapping stuff.
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_6=
4.h
index 2303635..516fda7 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -45,10 +45,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
=20
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine);
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/=
pci.h
index 37e55d0..a5129086 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -17,8 +17,6 @@
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
=20
 #define HAVE_PCI_MMAP
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-	enum pci_mmap_state mmap_state, int write_combine);
=20
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f6e22c2..734cc94 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -104,10 +104,6 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int p=
in, int irq);
=20
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_wc()	pat_enabled()
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
-
=20
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index f106879..e594eee 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -46,10 +46,6 @@ struct pci_dev;
=20
 #define PCI_DMA_BUS_IS_PHYS	(1)
=20
-/* Map a range of PCI memory or I/O space for a device into user space */
-int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
-
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP		1
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..1882797 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -823,6 +823,13 @@ void pcibios_update_irq(struct pci_dev *, int irq);
 /* Weak but can be overriden by arch */
 void pci_fixup_cardbus(struct pci_bus *);
=20
+/* Map a range of PCI memory or I/O space for a device into user space.
+ * Architectures provide this function if they set HAVE_PCI_MMAP, and
+ * it accepts the 'write_combine' argument when arch_can_pci_mmap_wc()
+ * evaluates to nonzero. */
+int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine);
+
 /* Generic PCI functions used internally */
=20
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *r=
egion,
--=20
dwmw2
--=-FCCFbISCFFY2xWogioOc
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDzUw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggU9MIIEJaADAgECAhBqC1BYlVMtBFBN4igR/howMA0GCSqGSIb3DQEBCwUAMIGbMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
MRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYxMjIwMDAwMDAwWhcN
MTcxMjIwMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwbTrFaiGdvN2pThnR9q+4eaXB2wQZQNqhter5ZrJ
pPO47e87bZ+f1tmYoh6+rB90G/XN24NErPRfvU4zVzNT9pCtCzSSVnBlZQBpaEYMKhcXo5PGKNsm
An8BoGwNXjlxwbBNRaNO+ky0wNCaMNd1JLxEuvqg9J7rrcpHhWmnpXD5IKa8gv9GyVAJgOpiBOts
p91sShc2kHvWJ5waPEWPCHDH9J+twGGKqKIIU7fdbURLUgUL1wlDSAHf/lgIAVCSj2H2HpoGqHpy
HgOAClX9iRSLNa0Znj8HTaqfOwxXevsz1KkLFY+Ahm426GIEqdfkK2iT6Hhgc7tjNO3f8i5ALQID
AQABo4IB8TCCAe0wHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFILE
dmHLtK6oxmFJZvBhTQhvqrS0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQA+AfvNhFwtapF5Lzjapgul3zYuEnMfR538Ya1vhP8wuOkcoJeT2gEFXzVO2WUu
eWM0g0/DumnRB53htV/Qq/+vsL0i6a2+iOO7kHi5O7bZkgbdNv0t2lzonDUHi6LTa7NUj+tv+j6y
hW+iNquC3ACP1dIZH8gJmicHblW63qRgp6wxhn315MLBeavi3uiSag2eeKFePiTIwJjN2UYq6kWg
PL5G/Ycf9x/xN1XBTfJiURc0FsXhrA98VMWnt52C5Lo4txhGjzTI+IZg40b3YDs6E7mTYb5KKmbc
QZA9priOFDdj1z5W9BdWhU6I/D0P9y8Z4Tr6+ZscMUVD0RqWy2LeMIIFPTCCBCWgAwIBAgIQagtQ
WJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMB4XDTE2MTIyMDAwMDAwMFoXDTE3MTIyMDIzNTk1OVowJDEiMCAGCSqG
SIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMG06xWohnbzdqU4Z0favuHmlwdsEGUDaobXq+WayaTzuO3vO22fn9bZmKIevqwfdBv1zduD
RKz0X71OM1czU/aQrQs0klZwZWUAaWhGDCoXF6OTxijbJgJ/AaBsDV45ccGwTUWjTvpMtMDQmjDX
dSS8RLr6oPSe663KR4Vpp6Vw+SCmvIL/RslQCYDqYgTrbKfdbEoXNpB71iecGjxFjwhwx/SfrcBh
iqiiCFO33W1ES1IFC9cJQ0gB3/5YCAFQko9h9h6aBqh6ch4DgApV/YkUizWtGZ4/B02qnzsMV3r7
M9SpCxWPgIZuNuhiBKnX5Ctok+h4YHO7YzTt3/IuQC0CAwEAAaOCAfEwggHtMB8GA1UdIwQYMBaA
FJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSCxHZhy7SuqMZhSWbwYU0Ib6q0tDAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQED
BQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYB
BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0
dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8v
Y3J0LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0R
BBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAPgH7zYRcLWqReS84
2qYLpd82LhJzH0ed/GGtb4T/MLjpHKCXk9oBBV81TtllLnljNINPw7pp0Qed4bVf0Kv/r7C9Iumt
vojju5B4uTu22ZIG3Tb9Ldpc6Jw1B4ui02uzVI/rb/o+soVvojargtwAj9XSGR/ICZonB25Vut6k
YKesMYZ99eTCwXmr4t7okmoNnnihXj4kyMCYzdlGKupFoDy+Rv2HH/cf8TdVwU3yYlEXNBbF4awP
fFTFp7edguS6OLcYRo80yPiGYONG92A7OhO5k2G+Sipm3EGQPaa4jhQ3Y9c+VvQXVoVOiPw9D/cv
GeE6+vmbHDFFQ9Ealsti3jGCA9MwggPPAgEBMIGwMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0Eg
TGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEGoLUFiVUy0EUE3iKBH+GjAwDQYJYIZIAWUDBAIBBQCgggHzMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDMxNTE3MTgwMFowLwYJ
KoZIhvcNAQkEMSIEIJ7xzGJKVsFKR91cw4pacJCd6SV3IYcV7agWXH+lBwRwMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQBKc3EvgaUgBzr51YLIE05xvuf52e66SjDHP3AOmtP8246bjXraEMv60aKvg3ZQ5CGgzpTS/L20
kHs9TaG71rbWsvEVUhJESXAlYqx0zY2dddl6TJ8WvDOgtzlqUNhxsammTRmcWyyCEn0Cxns6xa2u
FzsU25AiUgHzWlpqbBFuOHPS7cjs98S/TpA7UBdNwN0aTCqyAsUysROxNvrpyMz4sQ2hasXMXUzM
0qK1cA7+TDg4TwvnT0Qbk7rZun4s2WNe0OQAqn1Sfo1sdzDbzMmhCK8pwjR5o83mRjFda7uUXJkF
ot3f6wb93xs5aoCGjyAHmfrEEs9o2jCEbFUolTb6AAAAAAAA


--=-FCCFbISCFFY2xWogioOc--
