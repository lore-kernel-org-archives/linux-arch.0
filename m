Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52799 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXJXJAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Oct 2007 05:00:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
Date: Wed, 24 Oct 2007 10:55:41 +0200
References: <E1IkAWI-0006vX-00@gondolin.me.apana.org.au> <471EA9D6.9000004@garzik.org>
In-Reply-To: <471EA9D6.9000004@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200710241055.42567.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, akpm@linux-foundation.org, torvalds@linux-foundation.org, matthew@wil.cx, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 24 October 2007, Jeff Garzik wrote:
> > 
> > Could we add a debug option that warned if spin_lock_irq is
> > executed with IRQs turned off already?
> 
> Seems reasonable but perhaps arch-specific?
> 
> Also, I think someone (akpm?) mentioned an effort had been made before, 
> and run into some problems.  I don't have details...

I already posted a patch in this thread that does exactly that (and
warn about spin_unlock_irq with IRQs enabled), see my earlier reply.
The patch works fine, but my feeling is that it belongs into lockdep
instead.

	Arnd <><
