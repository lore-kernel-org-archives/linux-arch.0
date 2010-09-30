From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: dma-mapping commit breaks UML
Date: Thu, 30 Sep 2010 14:45:19 +0900
Message-ID: <20100930144059N.fujita.tomonori@lab.ntt.co.jp>
References: <201009291155.30873.toralf.foerster@gmx.de>
	<20100929221620K.fujita.tomonori@lab.ntt.co.jp>
	<201009291629.39077.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:56885 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab0I3Fp1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Sep 2010 01:45:27 -0400
In-Reply-To: <201009291629.39077.toralf.foerster@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: toralf.foerster@gmx.de
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 29 Sep 2010 16:29:38 +0200
Toralf **UNKNOWN CHARSET** <toralf.foerster@gmx.de> wrote:

> but catched another compile error - how can I now automatically
> git-bisect for that wrong commit w/o heavy scripting ? - Or simply
> asking who to blame wrt this compile error ?

Fortunately, looks like we can easily figure out the root cause of
this (commit d6d1b650ae6acce73d55dd0246de22180303ae73), the last
commit to arch/um/drivers/hostaudio_kern.c

The following patch works?

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 0c46e39..63c740a 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -40,6 +40,11 @@ static char *mixer = HOSTAUDIO_DEV_MIXER;
 "    This is used to specify the host mixer device to the hostaudio driver.\n"\
 "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
 
+module_param(dsp, charp, 0644);
+MODULE_PARM_DESC(dsp, DSP_HELP);
+module_param(mixer, charp, 0644);
+MODULE_PARM_DESC(mixer, MIXER_HELP);
+
 #ifndef MODULE
 static int set_dsp(char *name, int *add)
 {
@@ -56,15 +61,6 @@ static int set_mixer(char *name, int *add)
 }
 
 __uml_setup("mixer=", set_mixer, "mixer=<mixer device>\n" MIXER_HELP);
-
-#else /*MODULE*/
-
-module_param(dsp, charp, 0644);
-MODULE_PARM_DESC(dsp, DSP_HELP);
-
-module_param(mixer, charp, 0644);
-MODULE_PARM_DESC(mixer, MIXER_HELP);
-
 #endif
 
 /* /dev/dsp file operations */
