From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v2 5/5] bug: Make BUG() call unreachable()
Date: Tue, 25 Feb 2014 19:49:36 -0800
Message-ID: <d97712e037ea4c90e9cb30c56229383d257831de.1393385236.git.josh@joshtriplett.org>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This effectively causes BUG() to act like a function with the noreturn
attribute, which prevents GCC from warning about the code that follows
BUG() (for instance, warning about not returning a value in a non-void
function after calling BUG()).

This actually makes the kernel smaller; bloat-o-meter summary:
add/remove: 2/7 grow/shrink: 34/57 up/down: 475/-1233 (-758)

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 653c44a..5f69248 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -134,7 +134,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (0)
+#define BUG() do { unreachable(); } while (0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
1.9.0
