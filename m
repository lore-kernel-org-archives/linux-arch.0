From: Jean Sacren <sakiwit@gmail.com>
Subject: [PATCH 1/1] x86: Fix warning: ignoring return value of 'fread'
Date: Wed, 25 Aug 2010 18:09:59 -0600
Message-ID: <20100826000959.GA7220@mail.gmail.com>
References: <20100826000739.GA7216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47835 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab0HZAKQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Aug 2010 20:10:16 -0400
Received: by pzk9 with SMTP id 9so403378pzk.19
        for <linux-arch@vger.kernel.org>; Wed, 25 Aug 2010 17:10:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826000739.GA7216@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Linux Arch Mailing List <linux-arch@vger.kernel.org>

warning: ignoring return value of 'fread', declared with attribute
warn_unused_result

This fix facilitates fread() either it succeeds, or an error occurs or
the end of file is reached.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 arch/x86/boot/compressed/mkpiggy.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
index 5c22812..fac37c3 100644
--- a/arch/x86/boot/compressed/mkpiggy.c
+++ b/arch/x86/boot/compressed/mkpiggy.c
@@ -62,7 +62,10 @@ int main(int argc, char *argv[])
 	if (fseek(f, -4L, SEEK_END)) {
 		perror(argv[1]);
 	}
-	fread(&olen, sizeof olen, 1, f);
+
+	if (fread(&olen, sizeof olen, 1, f) < 1)
+		fprintf(stderr, "\nError in reading or end of file.\n");
+
 	ilen = ftell(f);
 	olen = getle32(&olen);
 	fclose(f);
-- 
1.7.1
