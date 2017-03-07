Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33214 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdCGVYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2017 16:24:07 -0500
Received: by mail-qk0-f171.google.com with SMTP id y76so26945750qkb.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2017 13:22:52 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 13/16] ALSA: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:30 -0800
Message-ID: <1488920133-27229-14-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170307205530.b7HgI_GiDiJK2E55mwuw8ECP298L0bwMrGhy8fN9SUg@z>

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add a few other files caught by 0day bot
---
 sound/pci/hda/hda_intel.c    | 2 +-
 sound/pci/intel8x0.c         | 4 +++-
 sound/x86/intel_hdmi_audio.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c8256a8..64d6a34 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -53,7 +53,7 @@
 #ifdef CONFIG_X86
 /* for snoop control */
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
 #include <sound/core.h>
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 9720a30..6d17b17 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -40,7 +40,9 @@
 #include <sound/initval.h>
 /* for 440MX workaround */
 #include <asm/pgtable.h>
-#include <asm/cacheflush.h>
+#ifdef CONFIG_X86
+#include <asm/set_memory.h>
+#endif
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; SiS 7012; Ali 5455");
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c505b01..664b7fe 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -30,7 +30,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
 #include <sound/pcm.h>
-- 
2.7.4
