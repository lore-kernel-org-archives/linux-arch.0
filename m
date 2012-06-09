From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=205/6=5D=20m32r=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
Date: Sat,  9 Jun 2012 05:13:30 -0300
Message-ID: <1339229611-2326-5-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ezequiel Garcia <elezegarcia@gmail.com>, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable =E2=80=98persistent=E2=80=
=99
There is neither change in functionality, nor extra code generated.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: <linux-m32r@ml.linux-m32r.org>
Cc: <linux-m32r-ja@ml.linux-m32r.org>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/m32r/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/m32r/include/asm/flat.h b/arch/m32r/include/asm/flat.=
h
index 5d711c4..2caf5b8 100644
--- a/arch/m32r/include/asm/flat.h
+++ b/arch/m32r/include/asm/flat.h
@@ -14,7 +14,6 @@
=20
 #define	flat_argvp_envp_on_stack()		0
 #define	flat_old_ram_flag(flags)		(flags)
-#define	flat_set_persistent(relval, p)		0
 #define	flat_reloc_valid(reloc, size)		\
 	(((reloc) - textlen_for_m32r_lo16_data) <=3D (size))
 #define flat_get_addr_from_rp(rp, relval, flags, persistent) \
@@ -23,6 +22,12 @@
 #define flat_put_addr_at_rp(rp, addr, relval) \
 	m32r_flat_put_addr_at_rp(rp, addr, relval)
=20
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
+
 /* Convert a relocation entry into an address.  */
 static inline unsigned long
 flat_get_relocate_addr (unsigned long relval)
--=20
1.7.3.4
