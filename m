From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/8] hexagon: Make THREAD_SIZE available to vmlinux.lds
Date: Wed, 17 Jan 2018 15:25:13 +0000
Message-ID: <151620271356.22429.8919995001708942435.stgit@warthog.procyon.org.uk>
References: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make THREAD_SIZE available to vmlinux.lds on hexagon by including
asm/thread_info.h the linker script.

This allows init_stack to be allocated in the linker script in a subsequent
patch.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
cc: linux-hexagon@vger.kernel.org
---

 arch/hexagon/kernel/vmlinux.lds.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index ec87e67feb19..ad69d181c939 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -22,6 +22,8 @@
 #include <asm/asm-offsets.h>	/*  Most of the kernel defines are here  */
 #include <asm/mem-layout.h>	/*  except for page_offset  */
 #include <asm/cache.h>		/*  and now we're pulling cache line size  */
+#include <asm/thread_info.h>	/*  and we need THREAD_SIZE too */
+
 OUTPUT_ARCH(hexagon)
 ENTRY(stext)
 
