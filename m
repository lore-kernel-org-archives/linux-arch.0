From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v2 3/5] bug: When !CONFIG_BUG, make WARN call no_printk to
 check format and args
Date: Tue, 25 Feb 2014 19:49:05 -0800
Message-ID: <770b3955bdcec63564ae09741ae154f8908c22c6.1393385236.git.josh@joshtriplett.org>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The stub version of WARN for !CONFIG_BUG completely ignored its format
string and subsequent arguments; make it check them instead, using
no_printk.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
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
