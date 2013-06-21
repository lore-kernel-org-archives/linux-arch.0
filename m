From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers/block/xsysace - replace in(out)_8/in(out)_be16/in(out)_le16 with generic iowrite(read)8/16(be)
Date: Fri, 21 Jun 2013 20:40:39 +0200
Message-ID: <201306212040.39938.arnd@arndb.de>
References: <1371823336-19678-1-git-send-email-abrodkin@synopsys.com> <201306211623.06016.arnd@arndb.de> <4881796E12491D4BB15146FE0209CE643F5F683F@DE02WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59751 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423388Ab3FUSk7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2013 14:40:59 -0400
In-Reply-To: <4881796E12491D4BB15146FE0209CE643F5F683F@DE02WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Friday 21 June 2013, Alexey Brodkin wrote:
> My intention with this first patch was to do a simple iteration that is 
> supposed to not break anything. As it it said in patch title - just 
> replace accessors. And for now (for this patch) leave improper 
> implemented functionality as it is.
> 
> And in the next patch I will introduce changes that you've suggested 
> with "_rep" accessors.

Ok, makes sense.

> Maybe I should have sent both patches at once so my intention would be 
> clear.

Yes.

	Arnd
