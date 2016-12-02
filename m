From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Fri, 02 Dec 2016 11:55:58 +0100
Message-ID: <14455987.OWjnZpEEup@wuerfel>
References: <20161129131922.GA31466@angband.pl> <2899250.iZaPagXLk8@wuerfel> <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59256 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbcLBK5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2016 05:57:33 -0500
In-Reply-To: <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>

On Thursday, December 1, 2016 10:26:07 AM CET Linus Torvalds wrote:
> On Thu, Dec 1, 2016 at 5:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > WARNING: EXPORT symbol "mcount" [arch/x86/entry/built-in.ko] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "mcount" [arch/x86/built-in.ko] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
> > WARNING: EXPORT symbol "mcount" [vmlinux] version generation failed, symbol will not be versioned.
> >
> > Out of 12 randconfig builds that had CONFIG_MODVERSIONS enabled, all 12
> > had this problem, though not always with all the symbols.
> 
> Well, the good news is that pretty fundamentally, if it's just the asm
> symbls, those really don't have ABI's that change (or if they change,
> it's such a fundamental change that everything else will likely have
> changed too and we don't need to worry about one asm symbol crc - the
> change will be caught by other symbols).

Yes, it's always been just the assembly symbols that broke, these were
the ones that Al's original patch changed and that ended up with
no version information.

> So I think the whole "we don't really care" approach should work fine.
> The "let's make every symbol always be versioned" may just be too much
> pain for no real gain.

I have managed to bisect the link failure to a specific binutils
commit by Alan Modra now:

d983c8c ("Strip undefined symbols from .symtab")

went into binutils-2_26 and was reverted in 

a82e3ef ("Revert "Strip undefined symbols from .symtab"")

after the release branch for 2.26 was started, so that version
ended up being fine. However, the 2.27 version never saw the revert
and causes loadable kernel modules to become unusable when they refer
to a weak symbol in vmlinux. This works with 2.26 and lower:

$ nm obj-arm/vmlinux | grep __gnu_mcount_nc
         w __crc___gnu_mcount_nc
c031ed58 T __gnu_mcount_nc
c0ef4590 r __kcrctab___gnu_mcount_nc
c0efb4f5 r __kstrtab___gnu_mcount_nc
c0ee68bc R __ksymtab___gnu_mcount_nc

and this is breaks with 2.27 and higher:
$ make modules 2>&1 | tail -n 1
WARNING: "__gnu_mcount_nc" [drivers/ata/ahci_platform.ko] has no CRC!

$ nm obj-arm/vmlinux | grep __gnu_mcount_nc
c031ed58 T __gnu_mcount_nc
c0ef4590 r __kcrctab___gnu_mcount_nc
c0efb4f5 r __kstrtab___gnu_mcount_nc
c0ee68bc R __ksymtab___gnu_mcount_nc

Applying the patch below on top of today's binutils master branch
makes it work again. The real patch will also have to fix the testsuite.

	Arnd

---
commit 9a48071533f311ff1f567361874fab141bd77230
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Dec 2 11:31:34 2016 +0100

    Revert "Strip undefined symbols from .symtab"
    
    This reverts commit d983c8c5503d680c6d4955ceb610a9beebc64460.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/bfd/elflink.c b/bfd/elflink.c
index 5f87f87..57c4d42 100644
--- a/bfd/elflink.c
+++ b/bfd/elflink.c
@@ -9354,9 +9354,8 @@ elf_link_output_extsym (struct bfd_hash_entry *bh, void *data)
      a regular file, or that we have been told to strip.  However, if
      h->indx is set to -2, the symbol is used by a reloc and we must
      output it.  */
-  strip = FALSE;
   if (h->indx == -2)
-    ;
+    strip = FALSE;
   else if ((h->def_dynamic
 	    || h->ref_dynamic
 	    || h->root.type == bfd_link_hash_new)
@@ -9382,13 +9381,14 @@ elf_link_output_extsym (struct bfd_hash_entry *bh, void *data)
 	   && h->root.u.undef.abfd != NULL
 	   && (h->root.u.undef.abfd->flags & BFD_PLUGIN) != 0)
     strip = TRUE;
+  else
+    strip = FALSE;
 
   type = h->type;
 
   /* If we're stripping it, and it's not a dynamic symbol, there's
-     nothing else to do.   However, if it is a forced local symbol or
-     an ifunc symbol we need to give the backend finish_dynamic_symbol
-     function a chance to make it dynamic.  */
+     nothing else to do unless it is a forced local symbol or a
+     STT_GNU_IFUNC symbol.  */
   if (strip
       && h->dynindx == -1
       && type != STT_GNU_IFUNC
@@ -9691,18 +9691,9 @@ elf_link_output_extsym (struct bfd_hash_entry *bh, void *data)
 	}
     }
 
-  /* If the symbol is undefined, and we didn't output it to .dynsym,
-     strip it from .symtab too.  Obviously we can't do this for
-     relocatable output or when needed for --emit-relocs.  */
-  else if (input_sec == bfd_und_section_ptr
-	   && h->indx != -2
-	   && !bfd_link_relocatable (flinfo->info))
-    return TRUE;
-  /* Also strip others that we couldn't earlier due to dynamic symbol
-     processing.  */
-  if (strip)
-    return TRUE;
-  if ((input_sec->flags & SEC_EXCLUDE) != 0)
+  /* If we're stripping it, then it was just a dynamic symbol, and
+     there's nothing else to do.  */
+  if (strip || (input_sec->flags & SEC_EXCLUDE) != 0)
     return TRUE;
 
   /* Output a FILE symbol so that following locals are not associated
@@ -9952,9 +9943,8 @@ elf_link_input_bfd (struct elf_final_link_info *flinfo, bfd *input_bfd)
 
       *ppsection = isec;
 
-      /* Don't output the first, undefined, symbol.  In fact, don't
-	 output any undefined local symbol.  */
-      if (isec == bfd_und_section_ptr)
+      /* Don't output the first, undefined, symbol.  */
+      if (ppsection == flinfo->sections)
 	continue;
 
       if (ELF_ST_TYPE (isym->st_info) == STT_SECTION)
