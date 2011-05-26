From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] unicore32: move rtc-puv3.c to drivers/rtc directory
Date: Thu, 26 May 2011 14:40:14 +0200
Message-ID: <201105261440.14960.arnd@arndb.de>
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn> <b30d22dd12bdba6360749aab88157bb0f2a0303d.1306408804.git.gxt@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53218 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075Ab1EZMkd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 May 2011 08:40:33 -0400
In-Reply-To: <b30d22dd12bdba6360749aab88157bb0f2a0303d.1306408804.git.gxt@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: GuanXuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

On Thursday 26 May 2011, GuanXuetao wrote:
> From: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>

But next time you move files, please use the '-M' flag to git diff or
git format-patch, to make it easier to review the changes.
