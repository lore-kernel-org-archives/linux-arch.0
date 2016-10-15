From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] kbuild: modpost warn if export version crc is missing
Date: Sat, 15 Oct 2016 23:43:51 +1100
Message-ID: <20161015124352.10795-2-npiggin@gmail.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161015124352.10795-1-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

This catches the failing ceph CRC on with:

    LD      vmlinux.o
    MODPOST vmlinux.o
  WARNING: EXPORT symbol "ceph_monc_do_statfs" [vmlinux] version
  generation failed, symbol will not be versioned.

When the modules referring to exported symbols are built, there is an
existing warning for missing CRC, but it's not always the case such
any such module will be built, and in any case it is useful to get a
warning at the source.

This gets a little verbose with CONFIG_DEBUG_SECTION_MISMATCH,
producing a warning with each object linked, but I didn't think
that warranted extra complexity to avoid.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/mod/modpost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bd83497..08f62a1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -609,6 +609,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 {
 	unsigned int crc;
 	enum export export;
+	bool is_crc = false;
 
 	if ((!is_vmlinux(mod->name) || mod->is_dot_o) &&
 	    strncmp(symname, "__ksymtab", 9) == 0)
@@ -618,6 +619,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 
 	/* CRC'd symbol */
 	if (strncmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
+		is_crc = true;
 		crc = (unsigned int) sym->st_value;
 		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
 				export);
@@ -663,6 +665,10 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		else
 			symname++;
 #endif
+		if (is_crc) {
+			const char *e = is_vmlinux(mod->name) ?"":".ko";
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n", symname + strlen(CRC_PFX), mod->name, e);
+		}
 		mod->unres = alloc_symbol(symname,
 					  ELF_ST_BIND(sym->st_info) == STB_WEAK,
 					  mod->unres);
-- 
2.9.3

