From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v3 3/5] bug: When !CONFIG_BUG, make WARN call no_printk to
 check format and args
Date: Sun, 9 Mar 2014 18:02:10 -0700
Message-ID: <04b030fe345cba242bc672cecc79ee0cac1b79bd.1394412745.git.josh@joshtriplett.org>
References: <17c859aa7dcccec43df0a0c8908911b982764c76.1394412745.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17c859aa7dcccec43df0a0c8908911b982764c76.1394412745.git.josh@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The stub version of WARN for !CONFIG_BUG completely ignored its format
string and subsequent arguments; make it check them instead, using
no_printk.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
v3: Patch unchanged from v2.
 include/asm-generic/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 2d54d8d..a97fa11 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -155,6 +155,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 #ifndef WARN
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
+	no_printk(format);						\
 	unlikely(__ret_warn_on);					\
 })
 #endif
-- 
1.9.0
