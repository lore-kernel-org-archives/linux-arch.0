Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:3126 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173AbXJWDft (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 23:35:49 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
In-Reply-To: <471D0C54.7060207@garzik.org>
Message-Id: <E1IkAWI-0006vX-00@gondolin.me.apana.org.au>
Date: Tue, 23 Oct 2007 11:33:30 +0800
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, matthew@wil.cx, arnd@arndb.de, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Jeff Garzik <jeff@garzik.org> wrote:
> 
> Let me add to the chorus of voices:  I continually see two cases where 
> real bugs crop up:
> 
> 1) hacker uses spin_lock_irq() in incorrect context (where it is not 
> safe to do a blind enable/disable)
> 
> 2) hacker uses spin_lock_irq() correctly, but the surrounding code 
> changes, thus invalidating prior assumptions.
> 
> I would even go so far as to support the drastic measure of deleting 
> spin_lock_irq().
> 
> spin_lock_irqsave() generates fewer bugs, is more future-proof, and by 
> virtue of 'flags' permits architectures a bit more flexibility.

Could we add a debug option that warned if spin_lock_irq is
executed with IRQs turned off already?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
