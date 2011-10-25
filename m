From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: fix build error in include/asm-generic/gpio.h
Date: Tue, 25 Oct 2011 13:23:44 +0200
Message-ID: <201110251323.44313.arnd@arndb.de>
References: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com> <201110211339.59280.arnd@arndb.de> <CACxGe6sFrJh+Y5CJVMTPiWH3m=j+J_YUzLP=MiaBbsvDkeA_Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62569 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab1JYLXt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2011 07:23:49 -0400
In-Reply-To: <CACxGe6sFrJh+Y5CJVMTPiWH3m=j+J_YUzLP=MiaBbsvDkeA_Jg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Hamo <hamo.by@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 25 October 2011, Grant Likely wrote:
> by: Arnd Bergmann <arnd@arndb.de>
> >
> > Grant, can you put that into the gpio tree?
> 
> I can.
> 
> Hamo, next time make sure you cc: the relevant subsystem maintainer
> (in this case, me) when submitting patches.  You can find the
> maintainer by using ./scripts/get_maintainer.pl, or by looking at the
> MAINTAINERS file.  It is more work for me when I don't receive the
> patch directly in my inbox.

I would assume that this is what Hamo did:

$ ./scripts/get_maintainer.pl -f include/asm-generic/gpio.h 
Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/A...)
linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/A...)
linux-kernel@vger.kernel.org (open list)

	Arnd
