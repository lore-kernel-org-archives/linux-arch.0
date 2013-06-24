From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/3] drivers/block/xsysace - use "_rep" accessors with CPU endianess for data
Date: Mon, 24 Jun 2013 10:37:25 +0200
Message-ID: <2461224.6SazgEOqiA@wuerfel>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com> <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60617 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3FXIgT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 04:36:19 -0400
In-Reply-To: <1372062364-25861-3-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Monday 24 June 2013 12:26:03 Alexey Brodkin wrote:
> Initially different data accessors were used for LE abd BE CPUs:
> "ioread16" in "ace_datain_be16" and "ioread16be" in "ace_datain_le16".
> The same with writes.
> 
> While it worked in some cases (for example on BE PPC) it didn't work in
> others (LE ARC).
> 
> Mentioned functions access data (by 16-bit chunks) from storage (i.e.
> CompactFlash card) via DATABUFREG of Xilinx SystemACE CF controller.
> And to interpret data properly CPU needs to access data in DATABUFREG
> with native endianess.
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> 
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Mischa Jonker <mjonker@synopsys.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
