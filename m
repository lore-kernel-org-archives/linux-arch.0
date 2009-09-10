From: Roland McGrath <roland@redhat.com>
Subject: [PATCH 2/2] x86: BUG(): use UNREACHABLE()
Date: Wed,  9 Sep 2009 19:01:10 -0700 (PDT)
Message-ID: <20090910020110.DA9838BF6E@magilla.sf.frob.com>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754978AbZIJCF6@vger.kernel.org>
In-Reply-To: Roland McGrath's message of  Wednesday, 9 September 2009 18:59:23 -0700 <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

This uses the new UNREACHABLE() macro in x86's BUG() macro.  In my
test builds, this saved 2022 bytes of text in vmlinux on x86_64,
3051 bytes on i686.  (I didn't bother to calculate the additional
savings in .ko text.)

Signed-off-by: Roland McGrath <roland@redhat.com>
CC: Jakub Jelinek <jakub@redhat.com>
---
 arch/x86/include/asm/bug.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index d9cf1cd..a6458a3 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,14 +22,14 @@ do {								\
 		     ".popsection"				\
 		     : : "i" (__FILE__), "i" (__LINE__),	\
 		     "i" (sizeof(struct bug_entry)));		\
-	for (;;) ;						\
+	UNREACHABLE();						\
 } while (0)
 
 #else
 #define BUG()							\
 do {								\
 	asm volatile("ud2");					\
-	for (;;) ;						\
+	UNREACHABLE();						\
 } while (0)
 #endif
 
