From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=204/6=5D=20microblaze=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
Date: Sat,  9 Jun 2012 05:13:29 -0300
Message-ID: <1339229611-2326-4-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ezequiel Garcia <elezegarcia@gmail.com>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
List-Id: linux-arch.vger.kernel.org

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable =E2=80=98persistent=E2=80=
=99
There is neither change in functionality, nor extra code generated.

Cc: Michal Simek <monstr@monstr.eu>
Cc: <microblaze-uclinux@itee.uq.edu.au>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/microblaze/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/inclu=
de/asm/flat.h
index 6847c15..40602c8 100644
--- a/arch/microblaze/include/asm/flat.h
+++ b/arch/microblaze/include/asm/flat.h
@@ -16,7 +16,12 @@
 #define	flat_argvp_envp_on_stack()	0
 #define	flat_old_ram_flag(flags)	(flags)
 #define	flat_reloc_valid(reloc, size)	((reloc) <=3D (size))
-#define	flat_set_persistent(relval, p)		0
+
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
=20
 /*
  * Microblaze works a little differently from other arches, because
--=20
1.7.3.4
