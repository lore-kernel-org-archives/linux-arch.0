From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: S+core architecture (arch/score/) support files
Date: Tue, 23 Jun 2009 11:43:22 +0200
Message-ID: <200906231143.22985.arnd@arndb.de>
References: <OF318304AE.9C3DA8BC-ON482575DE.002B7553-482575DE.002FC96B@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64275 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbZFWJnn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2009 05:43:43 -0400
In-Reply-To: <OF318304AE.9C3DA8BC-ON482575DE.002B7553-482575DE.002FC96B@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 23 June 2009, liqin.chen@sunplusct.com wrote:
> Hi Linus,
> 
> This repository contains Linux support for S+core CPU.
> 
> Please pull
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git score

I've helped Liquin getting this into a state for inclusion,
so I'll share my observations about the submission.

The code looks very clean for a new architecture support, with the
exception of a few misformatted comments and similar minor issues.
By using the asm-generic headers that are now in 2.6.31, the amount
of copy-paste programming was reduced to a minimum, the total amount
of code added is much less than any other architecture (200kb score,
290kb h8300, 570kb microblaze are the smallest ones).
Fixes for any issues noted during review usually came in quickly.

S+core is now the first architecture to use the ABI defined in
asm-generic, which means it can serve as an example for other
architectures that want to merge their code in the future.

Unfortunately, I don't think that the score glibc has been fully
ported to support this, so it also means that the version that is
being submitted has undergone any run-time testing. I did check
that it compiles fine but could not do more in lack of hardware
or even just a user space distro.

Another small negative is that Liquin is still unexperienced with
the procedures we use in Linux. I've helped out by providing
my git tree, but am not planning to do that beyond 2.6.31.
Given that he has also been upstream gcc maintainer for S+core
for well over 2 years, I believe merging it now will work out well.

	Arnd <><
