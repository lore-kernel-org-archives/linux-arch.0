Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34430 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdFIFYp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 01:24:45 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/5] kbuild: thin archives final link close --whole-archives option
Date: Fri,  9 Jun 2017 15:24:13 +1000
Message-ID: <20170609052417.561-2-npiggin@gmail.com>
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20170609052413.CppKxSCy07AHGyViE6yGM-ze0ZB5n81t4GWIyYwxIi4@z>

Close the --whole-archives option with --no-whole-archive. Some
architectures end up including additional .o and files multiple
times after this, and they get duplicate symbols when they are
brought under the --whole-archives option.

This matches more closely with the incremental final link.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/link-vmlinux.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c80291319cb2..2a062ea130b5 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -63,7 +63,7 @@ modpost_link()
 	local objects
 
 	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
-		objects="--whole-archive built-in.o"
+		objects="--whole-archive built-in.o --no-whole-archive"
 	else
 		objects="${KBUILD_VMLINUX_INIT}				\
 			--start-group					\
@@ -83,7 +83,7 @@ vmlinux_link()
 
 	if [ "${SRCARCH}" != "um" ]; then
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
-			objects="--whole-archive built-in.o ${1}"
+			objects="--whole-archive built-in.o ${1} --no-whole-archive"
 		else
 			objects="${KBUILD_VMLINUX_INIT}			\
 				--start-group				\
@@ -96,7 +96,7 @@ vmlinux_link()
 			-T ${lds} ${objects}
 	else
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
-			objects="-Wl,--whole-archive built-in.o ${1}"
+			objects="-Wl,--whole-archive built-in.o ${1} -Wl,--no-whole-archive"
 		else
 			objects="${KBUILD_VMLINUX_INIT}			\
 				-Wl,--start-group			\
-- 
2.11.0
