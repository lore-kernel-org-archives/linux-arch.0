From: Sam Ravnborg <sam@ravnborg.org>
Subject: Support arch/$ARCH/include in kbuild
Date: Sun, 22 Jun 2008 00:13:52 +0200
Message-ID: <20080621221352.GE12279@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:46958 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbYFUWNH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Jun 2008 18:13:07 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id D13F1E30F6A
	for <linux-arch@vger.kernel.org>; Sun, 22 Jun 2008 00:13:06 +0200 (CEST)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux arch <linux-arch@vger.kernel.org>

I just posted this to lkml + kbuild.
But realised this is as relevant for linux-arch as the others.

Patches are here:
http://lkml.org/lkml/2008/6/21/157
http://lkml.org/lkml/2008/6/21/158

[and on lkml if you are subscribed].

	Sam

----- Forwarded message from Sam Ravnborg <sam@ravnborg.org> -----

Subject: Support arch/$ARCH/include in kbuild
Sender: linux-kbuild-owner@vger.kernel.org
From: Sam Ravnborg <sam@ravnborg.org>
Date:	Sun, 22 Jun 2008 00:07:03 +0200
User-Agent: Mutt/1.4.2.1i
To: LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailing-List:	linux-kbuild@vger.kernel.org

Linus hinted that he liked to have all arch specific
header files moved from include/asm-$ARCH to
arch/$ARCH/include/asm.

The following two patches implement the basic support
for this.

I have used sparc for my testing and to some degree
I also used i386.

For sparc I just had to do a simple:

    mkdir -p arch/sparc/include/asm
    mv include/asm-sparc/* arch/sparc/include/asm

to build sparc with the new directory layout.

For i386 I had to do a few trivial path fixes in
arch/x86/Makefile and to fix the include of unistd_32.h
in one place to fix the build.

I expect a few additional bits to show up when people
start to move their header files but this should
be a good starting point.


To support arch/$ARCH/include/ was done in two steps.

First was to teach make headers_* about the new layout.
And second step was to get the build fixed with the new
layout.

Patches are on top of kbuild-next.git and follows.

	Sam
