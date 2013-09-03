From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] m68k/m68knommu: Implement __get_user_unaligned/__put_user_unaligned()
Date: Tue,  3 Sep 2013 11:30:34 +0200
Message-ID: <1378200634-24716-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

fs/btrfs/ioctl.c: In function =E2=80=98btrfs_ioctl_file_extent_same=E2=80=
=99:
fs/btrfs/ioctl.c:2802: error: implicit declaration of function =E2=80=98=
__put_user_unaligned=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/9455452/

Btrfs is the first user of __put_user_unaligned() outside the compat co=
de,
hence now all 32-bit architectures should make sure to implement this, =
too.

 arch/m68k/include/asm/uaccess.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/ua=
ccess.h
index 639c731..3fadc4a 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -3,3 +3,10 @@
 #else
 #include <asm/uaccess_mm.h>
 #endif
+
+#ifdef CONFIG_CPU_HAS_NO_UNALIGNED
+#include <asm-generic/uaccess-unaligned.h>
+#else
+#define __get_user_unaligned(x, ptr)	__get_user((x), (ptr))
+#define __put_user_unaligned(x, ptr)	__put_user((x), (ptr))
+#endif
--=20
1.7.9.5
