Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261753AbUJ1Q7C@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:12397 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261751AbUJ1Q7C
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Oct 2004 12:59:02 -0400
Date: Thu, 28 Oct 2004 20:59:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild/all archs: Sanitize creating offsets.h 
Message-ID: <20041028185917.GA9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
List-ID: <linux-arch.vger.kernel.org>

When creating offsets.h from arch/$(ARCH)/Makefile we failed to check
all dependencies. A few key dependencies were listed - but a manually
edited list of include files are bound to be incomplete.
A few times I have tried building a kernel - which failed because
offsets.h needed to be updated but kbuild failed to do so.
I wonder what could happen with a kernel with an out-dated offsets.h
file with wrong assembler constants.

This serie of patches fixes this.
Generating offsets.h is moved to include/asm-$(ARCH)/Kbuild and
the usual dependency tracking is used to detect when an update is needed.

With this mail four patches are posted:
o Accept kbuild file named Kbuild
o generic support for offsets.h
o changes for i386
o changes for arm

The second patch breaks all architectures...

My bk tree at bk://linux-sam.bkbits.net/kbuild contains support for most
architectures (sh and cris missing for now).

	Sam
