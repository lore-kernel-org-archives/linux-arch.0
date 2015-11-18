From: Chen Gang <xili_gchen_5257@hotmail.com>
Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page
 and free_user_page
Date: Thu, 19 Nov 2015 03:40:25 +0800
Message-ID: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_39fd83d6-bde6-4911-8b59-17439349a786_"
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "vgupta@synopsys.com" <vgupta@synopsys.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "jonas@southpole.se" <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, linux@lists.openrisc.net, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

--_39fd83d6-bde6-4911-8b59-17439349a786_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 2001=0A=
From: Chen Gang <gang.chen.5i5j@gmail.com>=0A=
Date: Thu=2C 19 Nov 2015 03:24:42 +0800=0A=
Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page=
 and free_user_page=0A=
=0A=
They are not symmetric with each other=2C neither are used in real world=0A=
(can not be found by grep command in source code root directory)=2C so=0A=
remove them.=0A=
=0A=
Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>=0A=
---=0A=
=A0arch/arc/include/asm/page.h =A0 =A0 =A0 | 3 ---=0A=
=A0arch/arm/include/asm/page-nommu.h | 3 ---=0A=
=A0arch/frv/include/asm/page.h =A0 =A0 =A0 | 3 ---=0A=
=A0arch/m68k/include/asm/page_mm.h =A0 | 3 ---=0A=
=A0arch/m68k/include/asm/page_no.h =A0 | 3 ---=0A=
=A0arch/openrisc/include/asm/page.h =A0| 3 ---=0A=
=A0include/asm-generic/page.h =A0 =A0 =A0 =A0| 3 ---=0A=
=A07 files changed=2C 21 deletions(-)=0A=
=0A=
diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h=0A=
index 429957f..adf5cbb 100644=0A=
--- a/arch/arc/include/asm/page.h=0A=
+++ b/arch/arc/include/asm/page.h=0A=
@@ -13=2C9 +13=2C6 @@=0A=
=A0=0A=
=A0#ifndef __ASSEMBLY__=0A=
=A0=0A=
-#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)	free_page(addr)=0A=
-=0A=
=A0#define clear_page(paddr)		memset((paddr)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2C from)		memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-=
nommu.h=0A=
index d1b162a..503f488 100644=0A=
--- a/arch/arm/include/asm/page-nommu.h=0A=
+++ b/arch/arm/include/asm/page-nommu.h=0A=
@@ -17=2C9 +17=2C6 @@=0A=
=A0#define KTHREAD_SIZE PAGE_SIZE=0A=
=A0#endif=0A=
=A0=A0=0A=
-#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)	free_page(addr)=0A=
-=0A=
=A0#define clear_page(page)	memset((page)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2Cfrom)	memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
diff --git a/arch/frv/include/asm/page.h b/arch/frv/include/asm/page.h=0A=
index 8c97068..52ace96 100644=0A=
--- a/arch/frv/include/asm/page.h=0A=
+++ b/arch/frv/include/asm/page.h=0A=
@@ -8=2C9 +8=2C6 @@=0A=
=A0=0A=
=A0#ifndef __ASSEMBLY__=0A=
=A0=0A=
-#define get_user_page(vaddr)			__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)		free_page(addr)=0A=
-=0A=
=A0#define clear_page(pgaddr)			memset((pgaddr)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2Cfrom)			memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_m=
m.h=0A=
index 5029f73..e7a1946 100644=0A=
--- a/arch/m68k/include/asm/page_mm.h=0A=
+++ b/arch/m68k/include/asm/page_mm.h=0A=
@@ -6=2C9 +6=2C6 @@=0A=
=A0#include <linux/compiler.h>=0A=
=A0#include <asm/module.h>=0A=
=A0=0A=
-#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)	free_page(addr)=0A=
-=0A=
=A0/*=0A=
=A0 * We don't need to check for alignment etc.=0A=
=A0 */=0A=
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_n=
o.h=0A=
index ef20916..fa7f32d 100644=0A=
--- a/arch/m68k/include/asm/page_no.h=0A=
+++ b/arch/m68k/include/asm/page_no.h=0A=
@@ -6=2C9 +6=2C6 @@=0A=
=A0extern unsigned long memory_start=3B=0A=
=A0extern unsigned long memory_end=3B=0A=
=A0=0A=
-#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)	free_page(addr)=0A=
-=0A=
=A0#define clear_page(page)	memset((page)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2Cfrom)	memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/p=
age.h=0A=
index 108906f..e613d36 100644=0A=
--- a/arch/openrisc/include/asm/page.h=0A=
+++ b/arch/openrisc/include/asm/page.h=0A=
@@ -40=2C9 +40=2C6 @@=0A=
=A0=0A=
=A0#ifndef __ASSEMBLY__=0A=
=A0=0A=
-#define get_user_page(vaddr) =A0 =A0 =A0 =A0 =A0 =A0__get_free_page(GFP_KE=
RNEL)=0A=
-#define free_user_page(page=2C addr) =A0 =A0 =A0free_page(addr)=0A=
-=0A=
=A0#define clear_page(page)	memset((page)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2C from)	memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h=0A=
index 37d1fe2..67cfb7d 100644=0A=
--- a/include/asm-generic/page.h=0A=
+++ b/include/asm-generic/page.h=0A=
@@ -24=2C9 +24=2C6 @@=0A=
=A0=0A=
=A0#ifndef __ASSEMBLY__=0A=
=A0=0A=
-#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)=0A=
-#define free_user_page(page=2C addr)	free_page(addr)=0A=
-=0A=
=A0#define clear_page(page)	memset((page)=2C 0=2C PAGE_SIZE)=0A=
=A0#define copy_page(to=2Cfrom)	memcpy((to)=2C (from)=2C PAGE_SIZE)=0A=
=A0=0A=
--=A0=0A=
1.9.3=0A=
=0A=
 		 	   		  =

--_39fd83d6-bde6-4911-8b59-17439349a786_
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-include-asm-generic-page.h-Remove-useless-get_user_p.patch"

RnJvbSBiYTdjMDBjNGNiOTc2MTA5YjZhMzU4MTJjZTk2NDlhYWVkYTgxZTJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGVuIEdhbmcgPGdhbmcuY2hlbi41aTVqQGdtYWlsLmNvbT4K
RGF0ZTogVGh1LCAxOSBOb3YgMjAxNSAwMzoyNDo0MiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGlu
Y2x1ZGU6IGFzbS1nZW5lcmljOiBwYWdlLmg6IFJlbW92ZSB1c2VsZXNzIGdldF91c2VyX3BhZ2Ug
YW5kIGZyZWVfdXNlcl9wYWdlCgpUaGV5IGFyZSBub3Qgc3ltbWV0cmljIHdpdGggZWFjaCBvdGhl
ciwgbmVpdGhlciBhcmUgdXNlZCBpbiByZWFsIHdvcmxkCihjYW4gbm90IGJlIGZvdW5kIGJ5IGdy
ZXAgY29tbWFuZCBpbiBzb3VyY2UgY29kZSByb290IGRpcmVjdG9yeSksIHNvCnJlbW92ZSB0aGVt
LgoKU2lnbmVkLW9mZi1ieTogQ2hlbiBHYW5nIDxnYW5nLmNoZW4uNWk1akBnbWFpbC5jb20+Ci0t
LQogYXJjaC9hcmMvaW5jbHVkZS9hc20vcGFnZS5oICAgICAgIHwgMyAtLS0KIGFyY2gvYXJtL2lu
Y2x1ZGUvYXNtL3BhZ2Utbm9tbXUuaCB8IDMgLS0tCiBhcmNoL2Zydi9pbmNsdWRlL2FzbS9wYWdl
LmggICAgICAgfCAzIC0tLQogYXJjaC9tNjhrL2luY2x1ZGUvYXNtL3BhZ2VfbW0uaCAgIHwgMyAt
LS0KIGFyY2gvbTY4ay9pbmNsdWRlL2FzbS9wYWdlX25vLmggICB8IDMgLS0tCiBhcmNoL29wZW5y
aXNjL2luY2x1ZGUvYXNtL3BhZ2UuaCAgfCAzIC0tLQogaW5jbHVkZS9hc20tZ2VuZXJpYy9wYWdl
LmggICAgICAgIHwgMyAtLS0KIDcgZmlsZXMgY2hhbmdlZCwgMjEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vcGFnZS5oIGIvYXJjaC9hcmMvaW5jbHVkZS9h
c20vcGFnZS5oCmluZGV4IDQyOTk1N2YuLmFkZjVjYmIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJjL2lu
Y2x1ZGUvYXNtL3BhZ2UuaAorKysgYi9hcmNoL2FyYy9pbmNsdWRlL2FzbS9wYWdlLmgKQEAgLTEz
LDkgKzEzLDYgQEAKIAogI2lmbmRlZiBfX0FTU0VNQkxZX18KIAotI2RlZmluZSBnZXRfdXNlcl9w
YWdlKHZhZGRyKQkJX19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpCi0jZGVmaW5lIGZyZWVfdXNl
cl9wYWdlKHBhZ2UsIGFkZHIpCWZyZWVfcGFnZShhZGRyKQotCiAjZGVmaW5lIGNsZWFyX3BhZ2Uo
cGFkZHIpCQltZW1zZXQoKHBhZGRyKSwgMCwgUEFHRV9TSVpFKQogI2RlZmluZSBjb3B5X3BhZ2Uo
dG8sIGZyb20pCQltZW1jcHkoKHRvKSwgKGZyb20pLCBQQUdFX1NJWkUpCiAKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2luY2x1ZGUvYXNtL3BhZ2Utbm9tbXUuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNt
L3BhZ2Utbm9tbXUuaAppbmRleCBkMWIxNjJhLi41MDNmNDg4IDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9pbmNsdWRlL2FzbS9wYWdlLW5vbW11LmgKKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGFn
ZS1ub21tdS5oCkBAIC0xNyw5ICsxNyw2IEBACiAjZGVmaW5lIEtUSFJFQURfU0laRSBQQUdFX1NJ
WkUKICNlbmRpZgogIAotI2RlZmluZSBnZXRfdXNlcl9wYWdlKHZhZGRyKQkJX19nZXRfZnJlZV9w
YWdlKEdGUF9LRVJORUwpCi0jZGVmaW5lIGZyZWVfdXNlcl9wYWdlKHBhZ2UsIGFkZHIpCWZyZWVf
cGFnZShhZGRyKQotCiAjZGVmaW5lIGNsZWFyX3BhZ2UocGFnZSkJbWVtc2V0KChwYWdlKSwgMCwg
UEFHRV9TSVpFKQogI2RlZmluZSBjb3B5X3BhZ2UodG8sZnJvbSkJbWVtY3B5KCh0byksIChmcm9t
KSwgUEFHRV9TSVpFKQogCmRpZmYgLS1naXQgYS9hcmNoL2Zydi9pbmNsdWRlL2FzbS9wYWdlLmgg
Yi9hcmNoL2Zydi9pbmNsdWRlL2FzbS9wYWdlLmgKaW5kZXggOGM5NzA2OC4uNTJhY2U5NiAxMDA2
NDQKLS0tIGEvYXJjaC9mcnYvaW5jbHVkZS9hc20vcGFnZS5oCisrKyBiL2FyY2gvZnJ2L2luY2x1
ZGUvYXNtL3BhZ2UuaApAQCAtOCw5ICs4LDYgQEAKIAogI2lmbmRlZiBfX0FTU0VNQkxZX18KIAot
I2RlZmluZSBnZXRfdXNlcl9wYWdlKHZhZGRyKQkJCV9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVM
KQotI2RlZmluZSBmcmVlX3VzZXJfcGFnZShwYWdlLCBhZGRyKQkJZnJlZV9wYWdlKGFkZHIpCi0K
ICNkZWZpbmUgY2xlYXJfcGFnZShwZ2FkZHIpCQkJbWVtc2V0KChwZ2FkZHIpLCAwLCBQQUdFX1NJ
WkUpCiAjZGVmaW5lIGNvcHlfcGFnZSh0byxmcm9tKQkJCW1lbWNweSgodG8pLCAoZnJvbSksIFBB
R0VfU0laRSkKIApkaWZmIC0tZ2l0IGEvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL3BhZ2VfbW0uaCBi
L2FyY2gvbTY4ay9pbmNsdWRlL2FzbS9wYWdlX21tLmgKaW5kZXggNTAyOWY3My4uZTdhMTk0NiAx
MDA2NDQKLS0tIGEvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL3BhZ2VfbW0uaAorKysgYi9hcmNoL202
OGsvaW5jbHVkZS9hc20vcGFnZV9tbS5oCkBAIC02LDkgKzYsNiBAQAogI2luY2x1ZGUgPGxpbnV4
L2NvbXBpbGVyLmg+CiAjaW5jbHVkZSA8YXNtL21vZHVsZS5oPgogCi0jZGVmaW5lIGdldF91c2Vy
X3BhZ2UodmFkZHIpCQlfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCkKLSNkZWZpbmUgZnJlZV91
c2VyX3BhZ2UocGFnZSwgYWRkcikJZnJlZV9wYWdlKGFkZHIpCi0KIC8qCiAgKiBXZSBkb24ndCBu
ZWVkIHRvIGNoZWNrIGZvciBhbGlnbm1lbnQgZXRjLgogICovCmRpZmYgLS1naXQgYS9hcmNoL202
OGsvaW5jbHVkZS9hc20vcGFnZV9uby5oIGIvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL3BhZ2Vfbm8u
aAppbmRleCBlZjIwOTE2Li5mYTdmMzJkIDEwMDY0NAotLS0gYS9hcmNoL202OGsvaW5jbHVkZS9h
c20vcGFnZV9uby5oCisrKyBiL2FyY2gvbTY4ay9pbmNsdWRlL2FzbS9wYWdlX25vLmgKQEAgLTYs
OSArNiw2IEBACiBleHRlcm4gdW5zaWduZWQgbG9uZyBtZW1vcnlfc3RhcnQ7CiBleHRlcm4gdW5z
aWduZWQgbG9uZyBtZW1vcnlfZW5kOwogCi0jZGVmaW5lIGdldF91c2VyX3BhZ2UodmFkZHIpCQlf
X2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCkKLSNkZWZpbmUgZnJlZV91c2VyX3BhZ2UocGFnZSwg
YWRkcikJZnJlZV9wYWdlKGFkZHIpCi0KICNkZWZpbmUgY2xlYXJfcGFnZShwYWdlKQltZW1zZXQo
KHBhZ2UpLCAwLCBQQUdFX1NJWkUpCiAjZGVmaW5lIGNvcHlfcGFnZSh0byxmcm9tKQltZW1jcHko
KHRvKSwgKGZyb20pLCBQQUdFX1NJWkUpCiAKZGlmZiAtLWdpdCBhL2FyY2gvb3BlbnJpc2MvaW5j
bHVkZS9hc20vcGFnZS5oIGIvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9wYWdlLmgKaW5kZXgg
MTA4OTA2Zi4uZTYxM2QzNiAxMDA2NDQKLS0tIGEvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9w
YWdlLmgKKysrIGIvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9wYWdlLmgKQEAgLTQwLDkgKzQw
LDYgQEAKIAogI2lmbmRlZiBfX0FTU0VNQkxZX18KIAotI2RlZmluZSBnZXRfdXNlcl9wYWdlKHZh
ZGRyKSAgICAgICAgICAgIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMKQotI2RlZmluZSBmcmVl
X3VzZXJfcGFnZShwYWdlLCBhZGRyKSAgICAgIGZyZWVfcGFnZShhZGRyKQotCiAjZGVmaW5lIGNs
ZWFyX3BhZ2UocGFnZSkJbWVtc2V0KChwYWdlKSwgMCwgUEFHRV9TSVpFKQogI2RlZmluZSBjb3B5
X3BhZ2UodG8sIGZyb20pCW1lbWNweSgodG8pLCAoZnJvbSksIFBBR0VfU0laRSkKIApkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9wYWdlLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL3Bh
Z2UuaAppbmRleCAzN2QxZmUyLi42N2NmYjdkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1nZW5l
cmljL3BhZ2UuaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL3BhZ2UuaApAQCAtMjQsOSArMjQs
NiBAQAogCiAjaWZuZGVmIF9fQVNTRU1CTFlfXwogCi0jZGVmaW5lIGdldF91c2VyX3BhZ2UodmFk
ZHIpCQlfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCkKLSNkZWZpbmUgZnJlZV91c2VyX3BhZ2Uo
cGFnZSwgYWRkcikJZnJlZV9wYWdlKGFkZHIpCi0KICNkZWZpbmUgY2xlYXJfcGFnZShwYWdlKQlt
ZW1zZXQoKHBhZ2UpLCAwLCBQQUdFX1NJWkUpCiAjZGVmaW5lIGNvcHlfcGFnZSh0byxmcm9tKQlt
ZW1jcHkoKHRvKSwgKGZyb20pLCBQQUdFX1NJWkUpCiAKLS0gCjEuOS4zCgo=

--_39fd83d6-bde6-4911-8b59-17439349a786_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-snps-arc mailing list
linux-snps-arc@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-snps-arc
--_39fd83d6-bde6-4911-8b59-17439349a786_--
