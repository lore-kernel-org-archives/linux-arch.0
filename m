From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 13:37:50 +0000
Message-ID: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

When a header file is removed from generic-y (often accompanied by the
addition of an arch specific header), the generated wrapper file will
persist, and in some cases may still take precedence over the new arch
header.

=46or example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
context") removed ucontext.h from generic-y in arch/mips/include/asm/,
and added an arch/mips/include/uapi/asm/ucontext.h. The continued use o=
f
the wrapper when reusing a dirty build tree resulted in build failures
in arch/mips/kernel/signal.c:

arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=99=
:
arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=80=
=99 has no member named =E2=80=98uc_extcontext=E2=80=99
  return &uc->uc_extcontext;
            ^

=46ix by detecting and removing wrapper headers in generated header
directories that do not correspond to a filename in generic-y, genhdr-y=
,
or the newly introduced generated-y.

Reported-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
Changes in v2:
- Rewrite a bit, drawing inspiration from Makefile.headersinst.
- Exclude genhdr-y and generated-y (thanks to kbuild test robot).
---
 scripts/Makefile.asm-generic | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generi=
c
index 045e0098e962..24c29f16f029 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -13,11 +13,26 @@ include scripts/Kbuild.include
 # Create output directory if not already present
 _dummy :=3D $(shell [ -d $(obj) ] || mkdir -p $(obj))
=20
+# Stale wrappers when the corresponding files are removed from generic=
-y
+# need removing.
+generated-y   :=3D $(generic-y) $(genhdr-y) $(generated-y)
+all-files     :=3D $(patsubst %, $(obj)/%, $(generated-y))
+old-headers   :=3D $(wildcard $(obj)/*.h)
+unwanted      :=3D $(filter-out $(all-files),$(old-headers))
+
 quiet_cmd_wrap =3D WRAP    $@
 cmd_wrap =3D echo "\#include <asm-generic/$*.h>" >$@
=20
-all: $(patsubst %, $(obj)/%, $(generic-y))
+quiet_cmd_remove =3D REMOVE  $(unwanted)
+cmd_remove =3D rm -f $(unwanted)
+
+all: $(patsubst %, $(obj)/%, $(generic-y)) FORCE
+	$(if $(unwanted),$(call cmd,remove),)
 	@:
=20
 $(obj)/%.h:
 	$(call cmd,wrap)
+
+.PHONY: $(PHONY)
+PHONY +=3D FORCE
+FORCE: ;
--=20
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
