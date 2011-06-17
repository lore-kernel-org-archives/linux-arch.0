Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53724 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1FQVUp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2011 17:20:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3-resend] atomic: add *_dec_not_zero
Date: Fri, 17 Jun 2011 23:20:26 +0200
References: <1306653200-19176-1-git-send-email-sven@narfation.org> <201106171713.12983.arnd@arndb.de> <2834959.yriPZz3AFK@sven-desktop.home.narfation.org>
In-Reply-To: <2834959.yriPZz3AFK@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201106172320.26476.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Message-ID: <20110617212026.J_wyqaQYtAO4IW6gFo3BtExXFTCqlLTeIRmO6Hk8R9c@z>

On Friday 17 June 2011 19:32:57 Sven Eckelmann wrote:
> On Friday 17 June 2011 17:13:12 Arnd Bergmann wrote:
> > On Friday 17 June 2011, Sven Eckelmann wrote:
> > 
> > Hmm, I didn't look at the first versions unfortunately. Remind me why we
> > don't just open-code the atomic_add_unless in batman-adv.
> 
> Because some developers behind batman-adv and fault_inject thought that it is 
> easier readable and David S. Miller said that it is a good idea to have 
> something like it in atomic*.h
> 
> Other places were it can be used:
>  * drivers/media/video/omap3isp/ispstat.c
>  * drivers/s390/net/qeth_core_main.c
>  * fs/ext4/ext4.h
>  * fs/xfs/linux-2.6/xfs_buf.c
>  * mm/memcontrol.c
>  * net/core/drop_monitor.c
>  * net/phonet/pep.c

Ok, sounds good then.

> > Since people apparently think that this patch is a good idea, I'll merge it
> > in the asm-generic tree once I understand why this is done.
> 
> Don't feel pushed --- you can just say that you absolutely doesn't want it. I 
> only tried to keep David happy, but don't want to start a fight over it.

No, it's good, thanks for putting the work into sorting this out! I'll go through
my inbox anyway to see if anything should go into the asm-generic tree for the
next merge window. I think there are a couple of other patches.

	Arnd
