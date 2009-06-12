From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] new files form asm-generic
Date: Fri, 12 Jun 2009 10:39:55 +0200
Message-ID: <200906121039.57970.arnd@arndb.de>
References: <200906112146.32441.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835AbZFLIkL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jun 2009 04:40:11 -0400
In-Reply-To: <200906112146.32441.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Chen Liqin <liqin.chen@sunplusct.com>

On Thursday 11 June 2009, Arnd Bergmann wrote:
> This is a series of patches that adds a mostly-complete set of generic
> header files in the include/asm-generic hierarchy.
> 
> Please pull
> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/asm-generic.git for-linus
> 

The tree did not merge cleanly as of yesterday because of a conflict with
the perfcounters changes. I pulled the latest linux-2.6.git master
to resolve the conflict.

	Arnd <><
