Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:42608 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945910AbXBUXXn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 18:23:43 -0500
Received: from localhost.localdomain ([127.0.0.1]:6340 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038588AbXBUXXm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 23:23:42 +0000
Date: Wed, 21 Feb 2007 23:23:08 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
Message-ID: <20070221232308.GA12989@linux-mips.org>
References: <20070221102027.52bf703a.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com> <20070221120145.419a03ee.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com> <20070221141040.1807a368.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org> <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com> <20070221221449.GE8957@linux-mips.org> <Pine.LNX.4.64.0702211423140.16904@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702211423140.16904@alien.or.mcafeemobile.com>
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 21, 2007 at 02:25:09PM -0800, Davide Libenzi wrote:

> > doesn't have to care.  A few nasty architectures (Afair old ARM and the
> > b0rked R5900 in the Playstation 2 for 128-bit integer loads) however
> > don't throw exceptions so __get_user / __put_user have to handle the
> > problem manually which of course adds considerable overhead to the common
> > case.
> 
> Exactly. But at that point it'd better that the code handle the potential 
> split operation by itself, w/out getting a fault for each mis-aligned 
> access.

For these architectures it's a matter of correctness because ther won't
be an exception, so no chance to handle the rare case of missalignment
in the slow path.

  Ralf
