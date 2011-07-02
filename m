From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 2/2] iomap: make IOPORT/PCI mapping functions
 conditional
Date: Sat, 02 Jul 2011 21:54:26 +0200
Message-ID: <1309636466.24186.1439.camel@localhost>
References: <1309622006-28343-1-git-send-email-jonas@southpole.se>
	 <1309622006-28343-2-git-send-email-jonas@southpole.se>
	 <201107022146.15854.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:36398 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab1GBTye (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2011 15:54:34 -0400
In-Reply-To: <201107022146.15854.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


On Sat, 2011-07-02 at 21:46 +0200, Arnd Bergmann wrote:
> On Saturday 02 July 2011 17:53:26 Jonas Bonn wrote:
> > Use the CONFIG_HAS_IOPORT and CONFIG_PCI options to decide whether or
> > not functions for mapping these areas are provided.
> > 
> > Signed-off-by: Jonas Bonn <jonas@southpole.se>
> 
> Good catch!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Did you get a build error without the two options, or did you just have an
> idea to save a bit of code size?
> 

There was no build error; I just figured it would aid in debugging if
you got a compile-time error when trying to build drivers that use these
functions for a platform that lacked them.  Smaller code is always nice,
too.

/Jonas
