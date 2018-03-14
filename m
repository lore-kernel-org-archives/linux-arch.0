From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/16] recordmcount.pl: drop blackin and tile support
Date: Wed, 14 Mar 2018 15:52:00 +0100
Message-ID: <20180314145219.2055160-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kamil Rytarowski <n54@gmx.com>
List-Id: linux-arch.vger.kernel.org

These two architectures are getting removed, so we no longer
need the special cases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/recordmcount.pl | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 2033af758173..c74ecc6504e8 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -368,14 +368,6 @@ if ($arch eq "x86_64") {
 } elsif ($arch eq "microblaze") {
     # Microblaze calls '_mcount' instead of plain 'mcount'.
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-} elsif ($arch eq "blackfin") {
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
-    $mcount_adjust = -4;
-} elsif ($arch eq "tilegx" || $arch eq "tile") {
-    # Default to the newer TILE-Gx architecture if only "tile" is given.
-    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s__mcount\$";
-    $type = ".quad";
-    $alignment = 8;
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
2.9.0
