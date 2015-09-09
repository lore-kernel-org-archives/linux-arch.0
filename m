Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33184 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbbIIVJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2015 17:09:00 -0400
Received: by pacex6 with SMTP id ex6so20879043pac.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2015 14:08:59 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 13/13] Re-enable and clean up "check_config()" in headers_check.pl
Date: Wed,  9 Sep 2015 14:08:22 -0700
Message-ID: <1441832902-28993-14-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <2644177.lVCYzIBfPW@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20150909210822.uU5p12fQrBXBg0rKWXG4ydalcz4yEY_mpg95QLvJTHU@z>

I recently got bit by a CONFIG_ in userspace bug.  This has apparently
happened before, but the check got disabled for triggering too much.
In order to reduce false positives, I added some hueristics to avoid
detecting comments.

Since these tests all pass, I've now re-enabled them.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 scripts/headers_check.pl | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index 62320f93e903..dd413ad9c850 100755
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -40,7 +40,7 @@ foreach my $file (@files) {
 		&check_asm_types();
 		&check_sizetypes();
 		&check_declarations();
-		# Dropped for now. Too much noise &check_config();
+		&check_config();
 	}
 	close $fh;
 }
@@ -76,9 +76,24 @@ sub check_declarations
 	}
 }
 
+my $check_config_in_multiline_comment = 0;
 sub check_config
 {
-	if ($line =~ m/[^a-zA-Z0-9_]+CONFIG_([a-zA-Z0-9_]+)[^a-zA-Z0-9_]/) {
+	my $nocomments = $line;
+	$nocomments =~ s/\/\*.*\*\///; # Remove ANSI-style comments (/* to */)
+	$nocomments =~ s/\/\/.*//;     # Remove C99-style comments (// to EOL)
+
+	# Check to see if we're within a multiline comment, and if so
+	# just remove the whole line.  I tried matching on '^ * ', but
+	# there's one header that doesn't prepend multi-line comments
+	# with * so that won't work.
+	if ($nocomments =~ m/\/\*/) { $check_config_in_multiline_comment = 1; }
+	if ($nocomments =~ m/\*\//) { $check_config_in_multiline_comment = 0; }
+	if ($check_config_in_multiline_comment == 1) { $nocomments = "" }
+
+	# Check to see if there is something that looks like CONFIG_
+	# inside a userspace-accessible header file and if so, print that out.
+	if ($nocomments =~ m/[^a-zA-Z0-9_]+CONFIG_([a-zA-Z0-9_]+)[^a-zA-Z0-9_]/) {
 		printf STDERR "$filename:$lineno: leaks CONFIG_$1 to userspace where it is not valid\n";
 	}
 }
-- 
2.4.6

