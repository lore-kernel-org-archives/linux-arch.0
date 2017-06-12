From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 27/27] kbuild: remove wrapper files handling from Makefile.headersinst
Date: Mon, 12 Jun 2017 12:27:21 +0900
Message-ID: <1497238041-7011-28-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

scripts/Makefike.headersinst creates asm-generic wrappers by itself
because scripts/Makefile.asm-generic created some of exported wrappers
outside uapi directories.

Now this distortion has been fixed.  scripts/Makefile.headersinst can
simply copy wrappers created by scripts/Makefile.asm-generic.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.headersinst | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index d6be5e482636..5a3da7c42c09 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -45,14 +45,8 @@ genhdr-files  := $(filter-out $(header-files), $(genhdr-files))
 install-file  := $(installdir)/.install
 check-file    := $(installdir)/.check
 
-# generic-y list all files an architecture uses from asm-generic
-# Use this to build a list of headers which require a wrapper
-generic-files := $(notdir $(wildcard $(srctree)/include/uapi/asm-generic/*.h))
-wrapper-files := $(filter $(generic-files), $(generic-y))
-wrapper-files := $(filter-out $(header-files), $(wrapper-files))
-
 # all headers files for this dir
-all-files     := $(header-files) $(genhdr-files) $(wrapper-files)
+all-files     := $(header-files) $(genhdr-files)
 output-files  := $(addprefix $(installdir)/, $(all-files))
 
 ifneq ($(mandatory-y),)
@@ -76,9 +70,6 @@ quiet_cmd_install = INSTALL $(printdir) ($(words $(all-files))\
       cmd_install = \
         $(CONFIG_SHELL) $< $(installdir) $(srcdir) $(header-files); \
         $(CONFIG_SHELL) $< $(installdir) $(gendir) $(genhdr-files); \
-        for F in $(wrapper-files); do                                   \
-                echo "\#include <asm-generic/$$F>" > $(installdir)/$$F;    \
-        done;                                                           \
         touch $@
 
 quiet_cmd_remove = REMOVE  $(unwanted)
-- 
2.7.4
