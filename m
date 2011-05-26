From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/6] unicore32 subsystem: 6 patches for 2.6.39
Date: Thu, 26 May 2011 14:50:01 +0200
Message-ID: <201105261450.01277.arnd@arndb.de>
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50751 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1EZMuG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2011 08:50:06 -0400
In-Reply-To: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: GuanXuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Thursday 26 May 2011, GuanXuetao wrote:
> Two patches for PKUnity v3 SoC drivers:
>         add mac driver, and move rtc driver to appropriate place
> Two patches for new 2.6.39 updates:
>         using generic-y and modify PERCPU macro
> Other two patches are small fixes.
> 
> ---
> Guan Xuetao (6):
>   unicore32: move rtc-puv3.c to drivers/rtc directory
>   unicore32: add pkunity-v3 mac/net driver (umal)
>   unicore32: change zImage physical address, though it's PIC codes
>   unicore32: add KBUILD_DEFCONFIG with unicore32_defconfig (old
>     debug_defconfig)
>   unicore32: change PERCPU to PERCPU_SECTION
>   unicore32: using generic-y format for one line asm-generic files
> 

The patches look basically ok, but two points to remember:

* The merge window is not the time to post patches for review, if you
  want to collect Acked-by's from other people, do that in the
  time between the merge windows, then put the patches in your git
  tree with the Acked-by for linux-next. During the merge window, just
  send stuff that was already in your tree to Linus.

  Bug fixes should get sent to Linus at any time, but I think you already
  did that, all of these were either new features or cleanups.

* Add a small text explaining why you do something to each patch. The
  one-line summary that you always have is too short for this and only
  serves to list what you change, not why.

	Arnd
