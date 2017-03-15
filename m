From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/3] pci: Add arch_can_pci_mmap_wc() macro
Date: Wed, 15 Mar 2017 17:17:56 +0000
Message-ID: <1489598276.86622.13.camel@infradead.org>
References: <0e5266c6c883baa0e4a98dce796f8ab2ee18e71f.1489598108.git.dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-dI495LjDknZDXmFC69/O"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e5266c6c883baa0e4a98dce796f8ab2ee18e71f.1489598108.git.dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


--=-dI495LjDknZDXmFC69/O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

Most of the almost-identical versions of pci_mmap_page_range() silently
ignore the 'write_combine' argument and give uncached mappings.

Yet we allow the PCIIOC_WRITE_COMBINE ioctl in /proc/bus/pci, expose the
'resourceX_wc' file in sysfs, and allow an attempted mapping to apparently
succeed.

To fix this, introduce a macro arch_can_pci_mmap_wc() which indicates
whether the platform can do a write-combining mapping. On x86 this ends
up being pat_enabled(), while the few other platforms that support it
can just set it to a literal '1'.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/filesystems/sysfs-pci.txt |  4 ++++
 arch/arm64/include/asm/pci.h            |  1 +
 arch/ia64/include/asm/pci.h             |  2 ++
 arch/powerpc/include/asm/pci.h          |  5 +++--
 arch/x86/include/asm/pci.h              |  2 ++
 arch/xtensa/include/asm/pci.h           |  6 +++++-
 arch/xtensa/kernel/pci.c                |  2 +-
 drivers/pci/pci-sysfs.c                 |  6 ++++--
 drivers/pci/proc.c                      | 17 ++++++++++-------
 9 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesy=
stems/sysfs-pci.txt
index 6ea1ced..25b7f1c 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -117,6 +117,10 @@ code must define HAVE_PCI_MMAP and provide a pci_mmap_=
page_range function.
 Platforms are free to only support subsets of the mmap functionality, but
 useful return codes should be provided.
=20
+Platforms which support write-combining maps of PCI resources must define
+arch_can_pci_mmap_wc() which shall evaluate to non-zero at runtime when
+write-combining is permitted.
+
 Legacy resources are protected by the HAVE_PCI_LEGACY define.  Platforms
 wishing to support legacy functionality should define it and provide
 pci_legacy_read, pci_legacy_write and pci_mmap_legacy_page_range functions=
.
diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index f73734f..53b1541 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -38,6 +38,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #endif  /* CONFIG_PCI */
=20
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_wc()	1
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
=20
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index c0835b0..6283758 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -51,6 +51,8 @@ extern unsigned long ia64_max_iommu_merge_mask;
 #define PCI_DMA_BUS_IS_PHYS	(ia64_max_iommu_merge_mask =3D=3D ~0UL)
=20
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_wc()	1
+
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct=
 *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.=
h
index 93eded8..b5b68c6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -81,8 +81,9 @@ struct vm_area_struct;
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
=20
-/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+/* Tell drivers/pci/proc.c that we have pci_mmap_page_range() and it does =
WC */
+#define HAVE_PCI_MMAP		1
+#define arch_can_pci_mmap_wc()	1
=20
 extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
 			   size_t count);
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 1411dbe..f6e22c2 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <linux/scatterlist.h>
 #include <asm/io.h>
+#include <asm/pat.h>
 #include <asm/x86_init.h>
=20
 #ifdef __KERNEL__
@@ -102,6 +103,7 @@ int pcibios_set_irq_routing(struct pci_dev *dev, int pi=
n, int irq);
=20
=20
 #define HAVE_PCI_MMAP
+#define arch_can_pci_mmap_wc()	pat_enabled()
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
 			       enum pci_mmap_state mmap_state,
 			       int write_combine);
diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
index 5d6bd93..f106879 100644
--- a/arch/xtensa/include/asm/pci.h
+++ b/arch/xtensa/include/asm/pci.h
@@ -51,7 +51,11 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_=
area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
=20
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
-#define HAVE_PCI_MMAP	1
+#define HAVE_PCI_MMAP		1
+
+/* This was wrapped in #if 0 since the first merge of xtensa support...
+#define arch_can_pci_mmap_wc()	1
+*/
=20
 #endif /* __KERNEL__ */
=20
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index b848cc3..c5944d3 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -345,7 +345,7 @@ __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_ar=
ea_struct *vma,
=20
 	/* Set to write-through */
 	prot =3D (prot & _PAGE_CA_MASK) | _PAGE_CA_WT;
-#if 0
+#ifdef arch_can_pci_mmap_wc
 	if (!write_combine)
 		prot |=3D _PAGE_WRITETHRU;
 #endif
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25d010d..e0474f3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1206,10 +1206,12 @@ static int pci_create_resource_files(struct pci_dev=
 *pdev)
 			continue;
=20
 		retval =3D pci_create_attr(pdev, i, 0);
+#ifdef arch_can_pci_mmap_wc
 		/* for prefetchable resources, create a WC mappable file */
-		if (!retval && pdev->resource[i].flags & IORESOURCE_PREFETCH)
+		if (!retval && arch_can_pci_mmap_wc() &&
+		    pdev->resource[i].flags & IORESOURCE_PREFETCH)
 			retval =3D pci_create_attr(pdev, i, 1);
-
+#endif
 		if (retval) {
 			pci_remove_resource_files(pdev);
 			return retval;
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f82710a..5cd960c 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -209,15 +209,18 @@ static long proc_bus_pci_ioctl(struct file *file, uns=
igned int cmd,
 		fpriv->mmap_state =3D pci_mmap_mem;
 		break;
=20
+#ifdef arch_can_pci_mmap_wc
 	case PCIIOC_WRITE_COMBINE:
-		if (arg)
-			fpriv->write_combine =3D 1;
-		else
-			fpriv->write_combine =3D 0;
-		break;
-
+		if (arch_can_pci_mmap_wc()) {
+			if (arg)
+				fpriv->write_combine =3D 1;
+			else
+				fpriv->write_combine =3D 0;
+			break;
+		}
+		/* If arch decided it can't, fall through... */
+#endif /* arch_can_pci_mmap_wc */
 #endif /* HAVE_PCI_MMAP */
-
 	default:
 		ret =3D -EINVAL;
 		break;
--=20
dwmw2
--=-dI495LjDknZDXmFC69/O
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDMxNTE3MTc1NlowLwYJ
KoZIhvcNAQkEMSIEIInYTxgBDbBCZASyCHcmApTB00PD2HZC+fyZ2L1yKS6pMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQAIE2HQ9yqxchaBzlLnbK5k7SZTdi5UCPWyxJYef0cvc1cGcAvNcDEOLXgWo4FWku1S8oGie/Fn
wU8oEq+ymb/kEvMKsZyHjH45UNmykb+SdxTqOq4z5rxrLqYov4E1BvIK2uanvZ+1ZqKKCxfR/+jY
H0HQ30CZVw/4h1PFaQCSsUUi6mwQDljtWqpsfdb4sGvd3AGF3K3gz/AwX59Lm+WX6uQ6K8zQSbOO
nFC5c/D7UnrfflZqx4oAVRgX7grS6bI8/QEknoL0/2IJOH77J12aQDxOi1skq5ZtuLSRoFwrVotW
mb1rGxl0/lK6UroFTJxNwSHdeYi8T4aorfjvn2bnAAAAAAAA


--=-dI495LjDknZDXmFC69/O--
