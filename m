From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: kernel: use 'COPY_UNALIGNED_HWORD' instead of
 'COPY_UNALIGNED_WORD'
Date: Wed, 26 Jun 2013 11:58:53 +0800
Message-ID: <51CA66FD.1010708@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "dhowells@redhat.com" <dhowells@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

=46or 'hvalue' and 'hlocation', need use 'COPY_UNALIGNED_HWORD' instead

The related warnings (with allmodconfig)
    CC      arch/m32r/kernel/module.o
  arch/m32r/kernel/module.c: In function =91apply_relocate_add=92:
  arch/m32r/kernel/module.c:127:8: warning: =91*((void *)&hvalue+2)=92 =
is used uninitialized in this function [-Wuninitialized]
  arch/m32r/kernel/module.c:127:8: warning: =91*((void *)&hvalue+2)=92 =
is used uninitialized in this function [-Wuninitialized]
  arch/m32r/kernel/module.c:127:8: warning: =91*((void *)&hvalue+3)=92 =
is used uninitialized in this function [-Wuninitialized]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/kernel/module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/m32r/kernel/module.c b/arch/m32r/kernel/module.c
index 38233b6..bcad14c 100644
--- a/arch/m32r/kernel/module.c
+++ b/arch/m32r/kernel/module.c
@@ -124,7 +124,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
                         relocation =3D relocation & 0xffff;
 			/* RELA must has 0 at relocation field. */
 			hvalue =3D relocation;
-	    		COPY_UNALIGNED_WORD (hvalue, *hlocation, align);
+			COPY_UNALIGNED_HWORD(hvalue, *hlocation, align);
 			break;
 		case R_M32R_SDA16_RELA:
 		case R_M32R_LO16_RELA:
--=20
1.7.7.6
