From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 31/39] UAPI: Fix arch/mips/include/asm/Kbuild to have
 separate header-y lines
Date: Fri, 08 Jul 2011 15:27:58 +0100
Message-ID: <20110708142758.31344.86602.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1GHO2k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:28:40 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix arch/mips/include/asm/Kbuild to have a separate header-y line for each
header to make them easier to delete individually.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/mips/include/asm/Kbuild |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 7897f05..f53f9ca 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,3 +1,5 @@
 include include/asm-generic/Kbuild.asm
 
-header-y += cachectl.h sgidefs.h sysmips.h
+header-y += cachectl.h
+header-y += sgidefs.h
+header-y += sysmips.h
