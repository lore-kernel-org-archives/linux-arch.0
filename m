From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=203/6=5D=20xtensa=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
Date: Sat,  9 Jun 2012 05:13:28 -0300
Message-ID: <1339229611-2326-3-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ezequiel Garcia <elezegarcia@gmail.com>, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable =E2=80=98persistent=E2=80=
=99
There is neither change in functionality, nor extra code generated.

Cc: Chris Zankel <chris@zankel.net>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/xtensa/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/f=
lat.h
index 94c44ab..2f5c384 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -7,6 +7,11 @@
 #define flat_get_addr_from_rp(rp, relval, flags, p)	get_unaligned(rp)
 #define flat_put_addr_at_rp(rp, val, relval	)	put_unaligned(val, rp)
 #define flat_get_relocate_addr(rel)			(rel)
-#define flat_set_persistent(relval, p)			0
+
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
=20
 #endif /* __ASM_XTENSA_FLAT_H */
--=20
1.7.3.4
