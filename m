From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] drivers/block/xsysace - replace in(out)_8/in(out)_be16/in(out)_le16 with generic iowrite(read)8/16(be)
Date: Mon, 24 Jun 2013 10:36:33 +0200
Message-ID: <3355073.lBoEZpEe2k@wuerfel>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com> <1372062364-25861-2-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57218 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3FXIf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 04:35:26 -0400
In-Reply-To: <1372062364-25861-2-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Monday 24 June 2013 12:26:02 Alexey Brodkin wrote:
> in(out)_8/in(out)_be16/in(out)_le16 are very powerpc/microblaze
> specific. To enable use of Xilinx System ACE driver build for other
> architectures (for example it's possible to use it on Xilinx ml-509
> board with ARC700 CPU in FPGA) we need to use generic implementation of
> accessors.
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
