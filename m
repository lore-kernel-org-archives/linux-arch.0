Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:49203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423133AbXBUVTh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 16:19:37 -0500
Date: Wed, 21 Feb 2007 13:15:58 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH]add epoll compat code to fsl/compat.c
In-Reply-To: <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
Message-ID: <Pine.LNX.4.64.0702211313560.4043@woody.linux-foundation.org>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
 <20070221141040.1807a368.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702211209140.16904@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0702211234410.4043@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702211259440.16904@alien.or.mcafeemobile.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 21 Feb 2007, Davide Libenzi wrote:
> > 
> > We can't trust user pointers, and that includes not trusting them being 
> > aligned. 
> 
> Don't we get EFAULT in case of exception (access or alignment) in there?
> For "dealing with", here we'd need them to do the correct thing 
> (split-load?) in case of mis-aligned access.

I sure hope no architecture does that. EFAULT should be for *unmapped* 
accesses, not from users just using unaligned pointers. 

I would argue that it is a bug if some architecture thinks that 
"get_user()" and "put_user()" don't do unaligned accesses. 

(Not to say that it might not be something some odd architecture *does*, 
but I'd be disappointed if somebody did)

		Linus
