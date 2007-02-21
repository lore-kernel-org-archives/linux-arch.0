Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:2623 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423200AbXBUWZM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 17:25:12 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S21702B> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 21 Feb 2007 17:25:09 -0500
Date: Wed, 21 Feb 2007 14:25:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <20070221221449.GE8957@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0702211423140.16904@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
 <20070221141040.1807a368.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
 <20070221221449.GE8957@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, Ralf Baechle wrote:

> On Wed, Feb 21, 2007 at 01:04:51PM -0800, Davide Libenzi wrote:
> 
> > > Oh, we can. "put_user()" and "get_user()" already have to work on totally 
> > > unaligned data. If some architecture has problems with that, they have 
> > > bigger issues, methinks.
> > > 
> > > We can't trust user pointers, and that includes not trusting them being 
> > > aligned. 
> > 
> > Don't we get EFAULT in case of exception (access or alignment) in there?
> > For "dealing with", here we'd need them to do the correct thing 
> > (split-load?) in case of mis-aligned access.
> 
> On an architecture which doesn't transparently handle missalignment the
> best approach is to have the unalignment exception handler fix things
> such that the 99.999% common case of properly aligned get_user/put_user
> doesn't have to care.  A few nasty architectures (Afair old ARM and the
> b0rked R5900 in the Playstation 2 for 128-bit integer loads) however
> don't throw exceptions so __get_user / __put_user have to handle the
> problem manually which of course adds considerable overhead to the common
> case.

Exactly. But at that point it'd better that the code handle the potential 
split operation by itself, w/out getting a fault for each mis-aligned 
access.



- Davide


