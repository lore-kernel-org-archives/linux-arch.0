From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Thu, 1 May 2008 21:17:10 +0200
Message-ID: <200805012117.12991.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <48151726.9000204@itee.uq.edu.au> <200804281431.26570.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64784 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077AbYEATRf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2008 15:17:35 -0400
In-Reply-To: <200804281431.26570.arnd@arndb.de>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Williams <jwilliams@itee.uq.edu.au>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>

On Monday 28 April 2008, Arnd Bergmann wrote:
> How about this strategy then:
> * Change all the data types and syscall numbers in the -for-2.6.27
> branch to only include the minimal set, and a modern ABI
> * Add the old interfaces as an out-of-tree patch that adds source
> level compatibility with the old libc, but does not modify any
> of the new interfaces, so that a patched kernel can run all binaries
> built for the upstream version.
> * phase out the old source interface gradually, as all users update
> their libc source code.

Any news on this from the microblaze people? Have you made up your mind
on what route you want to go?

	Arnd <><
