From: ralf@linux-mips.org
Subject: [patch 07/14] i8253: Make pcsp sound driver use the
	shared i8253_lock.
Date: Wed, 01 Jun 2011 19:05:03 +0100
Message-ID: <20110601180610.532642190@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline;
	filename=i8253-move-sound-pcsp-to-shared-lock.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org

 sound/drivers/pcsp/pcsp.h |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-mips/sound/drivers/pcsp/pcsp.h
===================================================================
--- linux-mips.orig/sound/drivers/pcsp/pcsp.h
+++ linux-mips/sound/drivers/pcsp/pcsp.h
@@ -10,14 +10,8 @@
 #define __PCSP_H__
 
 #include <linux/hrtimer.h>
-#include <linux/timex.h>
-#if defined(CONFIG_MIPS) || defined(CONFIG_X86)
-/* Use the global PIT lock ! */
 #include <linux/i8253.h>
-#else
-#include <asm/8253pit.h>
-static DEFINE_RAW_SPINLOCK(i8253_lock);
-#endif
+#include <linux/timex.h>
 
 #define PCSP_SOUND_VERSION 0x400	/* read 4.00 */
 #define PCSP_DEBUG 0
