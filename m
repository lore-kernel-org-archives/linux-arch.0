From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 10:31:43 +0000
Message-ID: <1453199503-30900-1-git-send-email-james.hogan@imgtec.com>
References: <20160119100154.GJ30608@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20160119100154.GJ30608@jhogan-linux.le.imgtec.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
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

=46ix by detecting wrapper headers in generated header directories that=
 do
not correspond to a filename in generic-y, and removing them.

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
 scripts/Makefile.asm-generic | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generi=
c
index 045e0098e962..7422f6476a8a 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -21,3 +21,19 @@ all: $(patsubst %, $(obj)/%, $(generic-y))
=20
 $(obj)/%.h:
 	$(call cmd,wrap)
+
+# Remove stale wrappers when the corresponding files are removed from
+# generic-y
+
+quiet_cmd_rmwrap =3D REMOVE  $(patsubst %.rm,%,$@)
+cmd_rmwrap =3D rm -f $(patsubst %.rm, %, $@)
+
+all: $(filter-out $(patsubst %, $(obj)/%.rm, $(generic-y)), \
+                  $(patsubst %, %.rm, $(wildcard $(obj)/*.h)))
+
+$(obj)/%.h.rm: FORCE
+	$(call cmd,rmwrap)
+
+.PHONY: $(PHONY)
+PHONY +=3D FORCE
+FORCE: ;
--=20
2.4.10
