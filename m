Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f175.google.com ([209.85.214.175]:46039 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfKHFEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:05 -0500
Received: by mail-pl1-f175.google.com with SMTP id y24so3224447plr.12
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:05 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 25/37] checkpatch: avoid showing BIT_ULL warnings for tools/ files
Date: Fri,  8 Nov 2019 14:02:40 +0900
Message-Id: <7150a514b3ebc50f65fc8ed328c31df0e999cdc2.1573179553.git.thehajime@gmail.com>
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Directly using shift operations in userspace compiled code should not
trigger warnings as BIT_ULL macros are not available outside the
kernel.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..e739f565497e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6313,7 +6313,8 @@ sub process {
 		    $line =~ /#\s*define\s+\w+\s+\(?\s*1\s*([ulUL]*)\s*\<\<\s*(?:\d+|$Ident)\s*\)?/) {
 			my $ull = "";
 			$ull = "_ULL" if (defined($1) && $1 =~ /ll/i);
-			if (CHK("BIT_MACRO",
+			if ($realfile !~ m@\btools/@ &&
+			    CHK("BIT_MACRO",
 				"Prefer using the BIT$ull macro\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] =~ s/\(?\s*1\s*[ulUL]*\s*<<\s*(\d+|$Ident)\s*\)?/BIT${ull}($1)/;
-- 
2.20.1 (Apple Git-117)
