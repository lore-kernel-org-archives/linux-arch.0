From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC PATCH 1/5] elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
Date: Mon, 27 Jul 2020 10:11:23 -0700
Message-ID: <1595869887-23307-2-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-Id: linux-arch.vger.kernel.org

Commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf
executable mappings") reverted back to using MAP_FIXED to map elf load
segments because it was found that the load segments in some binaries
overlap and can cause MAP_FIXED_NOREPLACE to fail.  The original intent
of MAP_FIXED_NOREPLACE was to prevent the silent clobbering of an
existing mapping (e.g. the stack) by the elf image.  To achieve this,
expand on the logic used when loading ET_DYN binaries which calculates a
total size for the image when the first segment is mapped, maps the
entire image, and then unmaps the remainder before remaining segments
are mapped.  Apply this to ET_EXEC binaries as well as ET_DYN binaries
as is done now, and for both ET_EXEC and ET_DYN+INTERP use
MAP_FIXED_NOREPLACE for the initial total size mapping and MAP_FIXED for
remaining mappings.  For ET_DYN w/out INTERP, continue to map at a
system-selected address in the mmap region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/binfmt_elf.c | 112 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a..6445a6dbdb1d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1046,58 +1046,25 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * If we are loading ET_EXEC or we have already performed
-		 * the ET_DYN load_addr calculations, proceed normally.
+		 * Map remaining segments with MAP_FIXED once the first
+		 * total size mapping has been done.
 		 */
-		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
+		if (load_addr_set) {
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex->e_type == ET_DYN) {
-			/*
-			 * This logic is run once for the first LOAD Program
-			 * Header for ET_DYN binaries to calculate the
-			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
-			 *
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
-			 * and loaders (ET_DYN without INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
-			 * "./ld.so someprog" to test out a new version of
-			 * the loader, the subsequent program that the
-			 * loader loads must avoid the loader itself, so
-			 * they cannot share the same load range. Sufficient
-			 * room for the brk must be allocated with the
-			 * loader as well, since brk must be available with
-			 * the loader.
-			 *
-			 * Therefore, programs are loaded offset from
-			 * ELF_ET_DYN_BASE and loaders are loaded into the
-			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
-			 */
-			if (interpreter) {
-				load_bias = ELF_ET_DYN_BASE;
-				if (current->flags & PF_RANDOMIZE)
-					load_bias += arch_mmap_rnd();
-				elf_flags |= MAP_FIXED;
-			} else
-				load_bias = 0;
-
+		} else {
 			/*
-			 * Since load_bias is used for all subsequent loading
-			 * calculations, we must lower it by the first vaddr
-			 * so that the remaining calculations based on the
-			 * ELF vaddrs will be correctly offset. The result
-			 * is then page aligned.
+			 * To ensure loading does not continue if an ELF
+			 * LOAD segment overlaps an existing mapping (e.g.
+			 * the stack), for the first LOAD Program Header
+			 * calculate the the entire size of the ELF mapping
+			 * and map it with MAP_FIXED_NOREPLACE. On success,
+			 * the remainder will be unmapped and subsequent
+			 * LOAD segments mapped with MAP_FIXED rather than
+			 * MAP_FIXED_NOREPLACE because some binaries may
+			 * have overlapping segments that would cause the
+			 * mmap to fail.
 			 */
-			load_bias = ELF_PAGESTART(load_bias - vaddr);
+			elf_flags |= MAP_FIXED_NOREPLACE;
 
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
@@ -1105,6 +1072,55 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				retval = -EINVAL;
 				goto out_free_dentry;
 			}
+
+			if (elf_ex->e_type == ET_DYN) {
+				/*
+				 * This logic is run once for the first LOAD
+				 * Program Header for ET_DYN binaries to
+				 * calculate the randomization (load_bias) for
+				 * all the LOAD Program Headers.
+				 *
+				 * There are effectively two types of ET_DYN
+				 * binaries: programs (i.e. PIE: ET_DYN with
+				 * INTERP) and loaders (ET_DYN without INTERP,
+				 * since they _are_ the ELF interpreter). The
+				 * loaders must be loaded away from programs
+				 * since the program may otherwise collide with
+				 * the loader (especially for ET_EXEC which does
+				 * not have a randomized position). For example
+				 * to handle invocations of "./ld.so someprog"
+				 * to test out a new version of the loader, the
+				 * subsequent program that the loader loads must
+				 * avoid the loader itself, so they cannot share
+				 * the same load range. Sufficient room for the
+				 * brk must be allocated with the loader as
+				 * well, since brk must be available with the
+				 * loader.
+				 *
+				 * Therefore, programs are loaded offset from
+				 * ELF_ET_DYN_BASE and loaders are loaded into
+				 * the independently randomized mmap region
+				 * (0 load_bias without MAP_FIXED*).
+				 */
+				if (interpreter) {
+					load_bias = ELF_ET_DYN_BASE;
+					if (current->flags & PF_RANDOMIZE)
+						load_bias += arch_mmap_rnd();
+				} else {
+					load_bias = 0;
+					elf_flags &= ~MAP_FIXED_NOREPLACE;
+				}
+
+				/*
+				 * Since load_bias is used for all subsequent
+				 * loading calculations, we must lower it by
+				 * the first vaddr so that the remaining
+				 * calculations based on the ELF vaddrs will
+				 * be correctly offset. The result is then
+				 * page aligned.
+				 */
+				load_bias = ELF_PAGESTART(load_bias - vaddr);
+			}
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
1.8.3.1
