From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] iomap: make IOPORT/PCI mapping functions conditional
Date: Sat, 2 Jul 2011 22:15:47 +0200
Message-ID: <201107022215.47324.arnd@arndb.de>
References: <1309622006-28343-1-git-send-email-jonas@southpole.se> <201107022146.15854.arnd@arndb.de> <1309636466.24186.1439.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60140 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab1GBUQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2011 16:16:20 -0400
In-Reply-To: <1309636466.24186.1439.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Saturday 02 July 2011 21:54:26 Jonas Bonn wrote:
> On Sat, 2011-07-02 at 21:46 +0200, Arnd Bergmann wrote:
> > On Saturday 02 July 2011 17:53:26 Jonas Bonn wrote:
> > > Use the CONFIG_HAS_IOPORT and CONFIG_PCI options to decide whether or
> > > not functions for mapping these areas are provided.
> > > 
> > > Signed-off-by: Jonas Bonn <jonas@southpole.se>
> > 
> > Good catch!
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Did you get a build error without the two options, or did you just have an
> > idea to save a bit of code size?
> > 
> 
> There was no build error; I just figured it would aid in debugging if
> you got a compile-time error when trying to build drivers that use these
> functions for a platform that lacked them.  Smaller code is always nice,
> too.

Right. Did you also see the related discussion at
http://lkml.org/lkml/2011/7/1/422 ?

	Arnd
