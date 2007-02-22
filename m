Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:4388 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbXBVDIN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2007 22:08:13 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S2171B1> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 21 Feb 2007 22:08:10 -0500
Date: Wed, 21 Feb 2007 19:08:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <20070221.190208.31642609.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0702211905120.16904@alien.or.mcafeemobile.com>
References: <20070221141040.1807a368.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
 <20070221.190208.31642609.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sfr@canb.auug.org.au, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, David Miller wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 21 Feb 2007 12:36:11 -0800 (PST)
> 
> > On Wed, 21 Feb 2007, Davide Libenzi wrote:
> > > 
> > > I don't think we can safely assume that we can access a potentially 
> > > 4-bytes aligned u64 on 64 bit architectures that require compat:
> > > 
> > > 	put_user(ev.data, &events->data);
> > 
> > Oh, we can. "put_user()" and "get_user()" already have to work on totally 
> > unaligned data. If some architecture has problems with that, they have 
> > bigger issues, methinks.
> > 
> > We can't trust user pointers, and that includes not trusting them being 
> > aligned. 
> 
> Right, and on Sparc for userland they are illegal so we'll just
> SIGBUS the process if that happens.

Ahha! That's where I got fooled :) I looked at IA64 and I saw it had the 
proper unaligned case, but then I saw that SPARC was not handling the 
unaligned case.



- Davide


