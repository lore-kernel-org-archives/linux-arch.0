Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45927 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbXJXCMG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Oct 2007 22:12:06 -0400
Message-ID: <471EA9D6.9000004@garzik.org>
Date: Tue, 23 Oct 2007 22:11:34 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
References: <E1IkAWI-0006vX-00@gondolin.me.apana.org.au>
In-Reply-To: <E1IkAWI-0006vX-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, matthew@wil.cx, arnd@arndb.de, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Herbert Xu wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
>> Let me add to the chorus of voices:  I continually see two cases where 
>> real bugs crop up:
>>
>> 1) hacker uses spin_lock_irq() in incorrect context (where it is not 
>> safe to do a blind enable/disable)
>>
>> 2) hacker uses spin_lock_irq() correctly, but the surrounding code 
>> changes, thus invalidating prior assumptions.
>>
>> I would even go so far as to support the drastic measure of deleting 
>> spin_lock_irq().
>>
>> spin_lock_irqsave() generates fewer bugs, is more future-proof, and by 
>> virtue of 'flags' permits architectures a bit more flexibility.
> 
> Could we add a debug option that warned if spin_lock_irq is
> executed with IRQs turned off already?

Seems reasonable but perhaps arch-specific?

Also, I think someone (akpm?) mentioned an effort had been made before, 
and run into some problems.  I don't have details...

	Jeff



