Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:54522 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763270AbXERHAF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 03:00:05 -0400
Date: Fri, 18 May 2007 09:01:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 13/14] kbuild: include limits.h in sumversion.c for PATH_MAX
Message-ID: <20070518070101.GM12284@uranus.ravnborg.org>
References: <20070518064126.GA12193@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070518064126.GA12193@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Mike Frysinger <vapier@gentoo.org>
List-ID: <linux-arch.vger.kernel.org>

From 72c04ee8e763e6acb3494be17c68b40ac3f699f4 Mon Sep 17 00:00:00 2001
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 17 May 2007 14:57:20 -0400
Subject: [PATCH 13/14] kbuild: include limits.h in sumversion.c for PATH_MAX

POSIX says limits.h defines PATH_MAX so we should include it (which fixes
compiling on some systems like OS X).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/mod/sumversion.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 6873d5a..d9cc690 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -7,6 +7,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>
+#include <limits.h>
 #include "modpost.h"
 
 /*
-- 
1.5.1.rc3.20.gaa453

