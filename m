From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/8] Allow inlined spinlocks again V5
Date: Mon, 31 Aug 2009 10:59:11 +0200
Message-ID: <20090831085911.GA10144@osiris.boeblingen.de.ibm.com>
References: <20090829102115.638224800@de.ibm.com>
 <20090829111642.GA17951@elte.hu>
 <20090829135906.GA11215@osiris.boeblingen.de.ibm.com>
 <20090829141354.GA29896@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.17.163]:53602 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbZHaMYw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:24:52 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7V8xDUG005382
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 08:59:13 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7V8xCdJ2760896
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 10:59:13 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7V8xBp5014797
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 10:59:12 +0200
Content-Disposition: inline
In-Reply-To: <20090829141354.GA29896@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

On Sat, Aug 29, 2009 at 04:13:54PM +0200, Ingo Molnar wrote:
> A third question would be, now that we have this flexible method to 
> inline/uninline locking APIs, mind checking say a 64-bit x86 
> defconfig and see whether that generic set of inline/noinline 
> decisions actually results in the smallest possible kernel image 
> size?
> 
> I.e. we could use this opportunity to re-tune the generic defaults. 
> (and thus your patch-set would become an improvement as well.)

Considering the large x86 user base I have no doubts that you
will easily find volunteers who will be happy to do this :)
