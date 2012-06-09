From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=201/6=5D=20sh=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
Date: Sat,  9 Jun 2012 05:13:26 -0300
Message-ID: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ezequiel Garcia <elezegarcia@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable =E2=80=98persistent=E2=80=
=99
There is neither change in functionality, nor extra code generated.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: <linux-sh@vger.kernel.org>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/sh/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 5d84df5..51dd7af 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -18,7 +18,12 @@
 #define	flat_get_addr_from_rp(rp, relval, flags, p)	get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)
-#define	flat_set_persistent(relval, p)		({ (void)p; 0; })
+
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
=20
 #define FLAT_PLAT_INIT(_r) \
   do { _r->regs[0]=3D0; _r->regs[1]=3D0; _r->regs[2]=3D0; _r->regs[3]=3D=
0; \
--=20
1.7.3.4

