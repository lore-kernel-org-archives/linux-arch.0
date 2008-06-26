From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or redirect to asm-generic
Date: Fri, 27 Jun 2008 00:09:11 +0200
Message-ID: <200806270009.12378.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <200806261838.33787.arnd@arndb.de> <4863D87F.5060103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYFZWJj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 18:09:39 -0400
In-Reply-To: <4863D87F.5060103@zytor.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Adrian Bunk <bunk@kernel.org>, monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, H. Peter Anvin wrote:
> 
> The sanest way to do that would probably be something along the lines of:
> 
> -> Change include/asm-xxx to arch/xxx/include/asm

Sam Ravnborg is already working on this part.

> -> Create arch/generic
> -> Make sure arch/xxx/include/asm and arch/generic/include/asm are both 
> in the include path, in that order.
> 
> That would also get rid of the symlink.

It requires two more steps:

- change all remaining users of #include <asm-generic/*.h> to include
that file with the new name, e.g. #include <generic/asm/foo.h> if we
have it in the right path.
- change the way 'make headers_install' works so that the files get
installed to the right location in $PREFIX/include/asm/ instead of
$PREFIX/include/asm-generic/ for each header that does not exist
in arch/foo/include/asm.

These changes are probably somewhat controversial, and the first
one is much more invasive than the patches that Sam has, so I'd
not want to do them at the same time.

> On the other hand, the redirection isn't all that bad.

Agreed. I just have the hope that someone comes up with the magical
solution for this problem that makes it a lot nicer than the suggestions
so far or the current way of doing it ;-)

	Arnd <><
