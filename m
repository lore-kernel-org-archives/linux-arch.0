From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/3] lkdtm: Include WARN format string
Date: Tue,  7 Nov 2017 16:27:47 -0800
Message-ID: <1510100869-73751-2-git-send-email-keescook@chromium.org>
References: <1510100869-73751-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510100869-73751-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Joe Perches <joe@perches.com>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In order to test the ordering of WARN format strings, actually include one
in LKDTM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm_bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm_bugs.c b/drivers/misc/lkdtm_bugs.c
index 9e0b4f959987..8523f7dbac99 100644
--- a/drivers/misc/lkdtm_bugs.c
+++ b/drivers/misc/lkdtm_bugs.c
@@ -62,9 +62,11 @@ void lkdtm_BUG(void)
 	BUG();
 }
 
+static int warn_counter;
+
 void lkdtm_WARNING(void)
 {
-	WARN_ON(1);
+	WARN(1, "Warning message trigger count: %d\n", warn_counter++);
 }
 
 void lkdtm_EXCEPTION(void)
-- 
2.7.4
