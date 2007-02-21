Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:45466 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423182AbXBUWPZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 17:15:25 -0500
Received: from localhost.localdomain ([127.0.0.1]:50342 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038555AbXBUWPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 22:15:23 +0000
Date: Wed, 21 Feb 2007 22:14:49 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
Message-ID: <20070221221449.GE8957@linux-mips.org>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net> <20070221102027.52bf703a.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com> <20070221120145.419a03ee.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com> <20070221141040.1807a368.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org> <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 21, 2007 at 01:04:51PM -0800, Davide Libenzi wrote:

> > Oh, we can. "put_user()" and "get_user()" already have to work on totally 
> > unaligned data. If some architecture has problems with that, they have 
> > bigger issues, methinks.
> > 
> > We can't trust user pointers, and that includes not trusting them being 
> > aligned. 
> 
> Don't we get EFAULT in case of exception (access or alignment) in there?
> For "dealing with", here we'd need them to do the correct thing 
> (split-load?) in case of mis-aligned access.

On an architecture which doesn't transparently handle missalignment the
best approach is to have the unalignment exception handler fix things
such that the 99.999% common case of properly aligned get_user/put_user
doesn't have to care.  A few nasty architectures (Afair old ARM and the
b0rked R5900 in the Playstation 2 for 128-bit integer loads) however
don't throw exceptions so __get_user / __put_user have to handle the
problem manually which of course adds considerable overhead to the common
case.

  Ralf
