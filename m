From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add EMAXERRNO
Date: Mon, 15 Jun 2009 16:02:42 +0200
Message-ID: <200906151602.42873.arnd@arndb.de>
References: <OF48364F7F.ED6F93C7-ON482575D6.0042A7E0-482575D6.0043654D@sunplusct.com> <200906151530.10299.arnd@arndb.de> <20090615133151.GI19977@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49527 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZFOODt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 10:03:49 -0400
In-Reply-To: <20090615133151.GI19977@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: liqin.chen@sunplusct.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Monday 15 June 2009, Matthew Wilcox wrote:
> On Mon, Jun 15, 2009 at 03:30:09PM +0200, Arnd Bergmann wrote:
> > Some architectures want to flag error returns from a syscall based on
> > the return value. The range from zero to -511 is for errors that
> > we can return to user space, so add a #define for this to
> > include/asm-generic/errno.h.
> 
> I thought we could return anything up to -4095.

Sort of, yes. Internally to the kernel, we use anything up to 4095,
that's e.g. IS_ERR_VALUE checks for.

Error numbers from 512 to 4095 are internal and should never be seen
by the user.

In reality, it probably does not matter at all because we know what
error numbers we use. Now that you pointed me to include/linux/err.h,
that already defines MAX_ERRNO.

Liqin, I think I'd prefer to just drop my patch again, and you can
use MAX_ERRNO, which is defined in err.h.

	Arnd <><
