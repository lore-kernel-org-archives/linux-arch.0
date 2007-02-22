Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54677
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751481AbXBVDCK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 22:02:10 -0500
Date: Wed, 21 Feb 2007 19:02:08 -0800 (PST)
Message-Id: <20070221.190208.31642609.davem@davemloft.net>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
References: <20070221141040.1807a368.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
	<Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: davidel@xmailserver.org, sfr@canb.auug.org.au, akpm@linux-foundation.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2007 12:36:11 -0800 (PST)

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

Right, and on Sparc for userland they are illegal so we'll just
SIGBUS the process if that happens.
