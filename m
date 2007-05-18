Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:33331 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbXERHLi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 03:11:38 -0400
Date: Fri, 18 May 2007 09:12:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/14] kbuild: make modpost section warnings clearer
Message-ID: <20070518071234.GA12551@uranus.ravnborg.org>
References: <20070518064126.GA12193@uranus.ravnborg.org> <20070518064918.GA12284@uranus.ravnborg.org> <Pine.LNX.4.61.0705180851200.3231@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0705180851200.3231@yvahk01.tjqt.qr>
Sender: linux-arch-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-ID: <linux-arch.vger.kernel.org>

On Fri, May 18, 2007 at 08:52:31AM +0200, Jan Engelhardt wrote:
> 
> On May 18 2007 08:49, Sam Ravnborg wrote:
> >index 113dc77..acd28ab 100644
> >--- a/scripts/mod/modpost.c
> >+++ b/scripts/mod/modpost.c
> >@@ -885,29 +885,28 @@ static void warn_sec_mismatch(const char *modname, const char *fromsec,
> > 		return;
> > 
> > 	if (before && after) {
> >-		warn("%s - Section mismatch: reference to %s:%s from %s "
> >-		     "between '%s' (at offset 0x%llx) and '%s'\n",
> >-		     modname, secname, refsymname, fromsec,
> >+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
> >+		     "(between '%s' and '%s')\n",
> >+		     modname, fromsec, (long long)r.r_offset,
> >+		     secname, refsymname,
> 
> %x always takes unsigned. %llx => (unsigned long long)r.r_offset.
> Ditto below.
> 
> > 		     elf->strtab + before->st_name,
> >-		     (long long)r.r_offset,
> > 		     elf->strtab + after->st_name);
> > 	} else if (before) {
> >-		warn("%s - Section mismatch: reference to %s:%s from %s "
> >-		     "after '%s' (at offset 0x%llx)\n",
> >-		     modname, secname, refsymname, fromsec,
> >-		     elf->strtab + before->st_name,
> >-		     (long long)r.r_offset);
> >+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
> >+		     "(after '%s')\n",
> >+		     modname, fromsec, (long long)r.r_offset,
> >+		     secname, refsymname,
> >+		     elf->strtab + before->st_name);
> [more occurences]

Thanks, updated patch below.

	Sam

From 4dba30ccfdb911b0810f6527de66b1515349d8c4 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 10 May 2007 23:03:25 +0100
Subject: [PATCH 01/14] kbuild: make modpost section warnings clearer

Change modpost section mismatch warnings to be less confusing;
model them on the binutils linker warnings which we all know how
to interpret.

Also, fix the wrong ordering of arguments for the final case -
fromsec and refsymname were reversed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/mod/modpost.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 113dc77..acd28ab 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -885,29 +885,28 @@ static void warn_sec_mismatch(const char *modname, const char *fromsec,
 		return;
 
 	if (before && after) {
-		warn("%s - Section mismatch: reference to %s:%s from %s "
-		     "between '%s' (at offset 0x%llx) and '%s'\n",
-		     modname, secname, refsymname, fromsec,
+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
+		     "(between '%s' and '%s')\n",
+		     modname, fromsec, (unsigned long long)r.r_offset,
+		     secname, refsymname,
 		     elf->strtab + before->st_name,
-		     (long long)r.r_offset,
 		     elf->strtab + after->st_name);
 	} else if (before) {
-		warn("%s - Section mismatch: reference to %s:%s from %s "
-		     "after '%s' (at offset 0x%llx)\n",
-		     modname, secname, refsymname, fromsec,
-		     elf->strtab + before->st_name,
-		     (long long)r.r_offset);
+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
+		     "(after '%s')\n",
+		     modname, fromsec, (unsigned long long)r.r_offset,
+		     secname, refsymname,
+		     elf->strtab + before->st_name);
 	} else if (after) {
-		warn("%s - Section mismatch: reference to %s:%s from %s "
+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
 		     "before '%s' (at offset -0x%llx)\n",
-		     modname, secname, refsymname, fromsec,
-		     elf->strtab + after->st_name,
-		     (long long)r.r_offset);
+		     modname, fromsec, (unsigned long long)r.r_offset,
+		     secname, refsymname,
+		     elf->strtab + after->st_name);
 	} else {
-		warn("%s - Section mismatch: reference to %s:%s from %s "
-		     "(offset 0x%llx)\n",
-		     modname, secname, fromsec, refsymname,
-		     (long long)r.r_offset);
+		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s\n",
+		     modname, fromsec, (unsigned long long)r.r_offset,
+		     secname, refsymname);
 	}
 }
 
-- 
1.5.1.rc3.20.gaa453

