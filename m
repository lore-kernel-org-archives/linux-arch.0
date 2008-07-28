Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpout3.tre.se ([80.251.192.228]:42351 "EHLO smtpout3.tre.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYG1UhP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jul 2008 16:37:15 -0400
Date: Mon, 28 Jul 2008 22:05:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Message-ID: <20080728200500.GA14284@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux arch <linux-arch@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <20080728200500.xPw3uxFlnsUyuxJylAsRZuILPuQxOXn9wxBZ7fjhEYo@z>

The traditional location of the arch specific Makefiles
has been at:

	include/asm-$ARCH

But as suggested by several people over time and lately
by Linus in the following post:
http://kerneltrap.org/mailarchive/linux-kernel/2008/5/21/1903924

is is suggested to move the arch specific files under arch/
and for the header files this is arch/$ARCH/include.

So I have hacked up support for this in kbuild so
for the simpler cases a simple move of header files as
in:
	git mv include/asm-$ARCH arch/$ARCH/include/asm

is enough.

If Linus will accept it then I think -rc1 is a perfect
time to do it as people has less stuff pending touching
the header files that are moved.
Validation is easy - does the usual configs build?

For the archs that plays games with symlinks this is a
splendid opportunity to get rid af these.
The receipe is simple:
Use 
	KBUILD_CFLAGS += -Iarch/$ARCH/include/$CPU

to select the CPU and then do a copy of the header files
like this:

	git mv include/asm-$ARCH/$CPU arch/$ARCH/include/$CPU/cpu

Then the code can continue to use:

	#include <cpu/foo.h>

I already converted sparc to use arch/sparc/include -
while I merged the header files for sparc and sparc64.
This change is already upstream.

And for SH I posted a receipe which you can read here:
http://lkml.org/lkml/2008/7/28/83

It is SH specific but anyway pretty generic.

I am limited in time and resources at the moment but I
would be glad to help out as time permits should there
be any questions.

	Sam
