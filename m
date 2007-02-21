Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:43310 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932490AbXBUUjz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 15:39:55 -0500
Date: Wed, 21 Feb 2007 12:36:11 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
Message-ID: <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
 <20070221141040.1807a368.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 21 Feb 2007, Davide Libenzi wrote:
> 
> I don't think we can safely assume that we can access a potentially 
> 4-bytes aligned u64 on 64 bit architectures that require compat:
> 
> 	put_user(ev.data, &events->data);

Oh, we can. "put_user()" and "get_user()" already have to work on totally 
unaligned data. If some architecture has problems with that, they have 
bigger issues, methinks.

We can't trust user pointers, and that includes not trusting them being 
aligned. 

		Linus
