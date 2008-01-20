Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:39024 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807AbYATUJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Jan 2008 15:09:09 -0500
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: fix so modpost can now check any .o file
Date: Sun, 20 Jan 2008 21:08:56 +0100
Message-Id: <1200859743-24037-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <20080120200527.GA23852@uranus.ravnborg.org>
References: <20080120200527.GA23852@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>

It is very convinient to say:
scripts/mod/modpost mm/built-in.o

to check if any section mismatch errors occured
in mm/ (as an example).
Fix it so this is possible again.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/mod/modpost.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 696d2a5..46660a4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1299,7 +1299,8 @@ static void read_symbols(char *modname)
 		handle_modversions(mod, &info, sym, symname);
 		handle_moddevtable(mod, &info, sym, symname);
 	}
-	if (is_vmlinux(modname) && vmlinux_section_warnings) {
+	if (!is_vmlinux(modname) ||
+	     (is_vmlinux(modname) && vmlinux_section_warnings)) {
 		check_sec_ref(mod, modname, &info, init_section, init_section_ref_ok);
 		check_sec_ref(mod, modname, &info, exit_section, exit_section_ref_ok);
 	}
-- 
1.5.4.rc3.14.g44397

