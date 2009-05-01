From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 16:07:48 +0200
Message-ID: <200905011607.49522.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905011556.39437.arnd@arndb.de> <20090501150319.192f6dce@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZEAOHu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 10:07:50 -0400
In-Reply-To: <20090501150319.192f6dce@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Alan Cox wrote:
> So we now have at least two conflicting meanings for CLOCK_TICK_RATE
> which again says it needs fixing not wallpapering over.

Right, I agree. I'll look into it next week.

	Arnd <><
