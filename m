From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/4] uapi: Allow automatic generation of uapi/asm/ header files
Date: Thu, 11 Oct 2012 17:18:02 +0100
Message-ID: <1349972285-22830-2-git-send-email-catalin.marinas@arm.com>
References: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349972285-22830-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Michal Marek <mmarek@suse.cz>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Several arch/*/include/uapi/asm/* header simply include the
corresponding <asm-generic/*> file. This patch allows such files to be
specified in uapi/asm/Kbuild via "generic-y +=3D ..." to be automatically
generated (similar to asm/Kbuild).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 Makefile                     | 4 +++-
 scripts/Makefile.asm-generic | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 86eb6ac..5d0da36 100644
--- a/Makefile
+++ b/Makefile
@@ -437,7 +437,9 @@ endif
 PHONY +=3D asm-generic
 asm-generic:
 =09$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
-=09            obj=3Darch/$(SRCARCH)/include/generated/asm
+=09            src=3Dasm obj=3Darch/$(SRCARCH)/include/generated/asm
+=09$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
+=09            src=3Duapi/asm obj=3Darch/$(SRCARCH)/include/generated/uapi=
/asm
=20
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 40caf3c..d17e0ea 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -5,7 +5,7 @@
 # and for each file listed in this file with generic-y creates
 # a small wrapper file in $(obj) (arch/$(SRCARCH)/include/generated/asm)
=20
-kbuild-file :=3D $(srctree)/arch/$(SRCARCH)/include/asm/Kbuild
+kbuild-file :=3D $(srctree)/arch/$(SRCARCH)/include/$(src)/Kbuild
 -include $(kbuild-file)
=20
 include scripts/Kbuild.include
