Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:2314 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423119AbXBUVEy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 16:04:54 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S216FAE> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 21 Feb 2007 16:04:51 -0500
Date: Wed, 21 Feb 2007 13:04:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
 <20070221141040.1807a368.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, Linus Torvalds wrote:

> 
> 
> On Wed, 21 Feb 2007, Davide Libenzi wrote:
> > 
> > I don't think we can safely assume that we can access a potentially 
> > 4-bytes aligned u64 on 64 bit architectures that require compat:
> > 
> > 	put_user(ev.data, &events->data);
> 
> Oh, we can. "put_user()" and "get_user()" already have to work on totally 
> unaligned data. If some architecture has problems with that, they have 
> bigger issues, methinks.
> 
> We can't trust user pointers, and that includes not trusting them being 
> aligned. 

Don't we get EFAULT in case of exception (access or alignment) in there?
For "dealing with", here we'd need them to do the correct thing 
(split-load?) in case of mis-aligned access.



- Davide


