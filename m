From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sat, 28 May 2011 23:24:31 +0200
Message-ID: <201105282324.31818.arnd@arndb.de>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65360 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1E1VYg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 May 2011 17:24:36 -0400
In-Reply-To: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: linux-arch@vger.kernel.org, Jonas Bonn <jonas@southpole.se>

On Saturday 28 May 2011 22:19:29 Jonas Bonn wrote:
> 
> From: Jonas Bonn <jonas@southpole.se>
> 
> This enables the syscall for architectures, like OpenRISC, that use the
> generic asm headers.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>

Thanks, looks good.

I just saw your git tree for the OpenRISC architecture port and it
looks really really nice, mostly by virtue of being very small, but
also by not copying all the things that new architecture ports normally
get wrong at the time when they show up on my radar.

Do you plan to submit it upstream any time soon?

There are four other new architectures that I expect to see soon (c6x,
nios2, lm32, plus one more), and I'd really like to have one architecture
serve as a good example that I can point the others to. unicore32 and
tile are the best ones we have, but neither is a really good example:
unicore32 has a few remaining bits unnecessarily copied from ARM, and
Tile is for a much more complex hardware than I want. Also, they
both don't use a flattened device tree to describe SoC parts.

Your OpenRISC port is much better in each of these regards, so that
it would be great to have that ready for inclusion in the next merge
window. There are obviously a few details to fix, but I can see nothing
in there that would require a significant amount of work.

	Arnd
