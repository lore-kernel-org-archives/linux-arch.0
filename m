From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] openrisc: Remove unused declaration of
	__initramfs_start
Date: Tue, 12 Nov 2013 20:56:21 +0100
Message-ID: <1384286181-16137-2-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
	<1384286181-16137-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1384286181-16137-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Andrew Morton <akpm@linux-foundation.org>, Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/openrisc/kernel/vmlinux.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/vmlinux.h b/arch/openrisc/kernel/vmlinux.h
index 6c0b24772f85..bbcdf21b0b35 100644
--- a/arch/openrisc/kernel/vmlinux.h
+++ b/arch/openrisc/kernel/vmlinux.h
@@ -3,7 +3,6 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 extern char __initrd_start, __initrd_end;
-extern char __initramfs_start;
 #endif
 
 #endif
-- 
1.7.9.5
