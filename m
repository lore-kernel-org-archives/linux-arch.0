Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbXGJRok (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jul 2007 13:44:40 -0400
Message-ID: <4693C580.2000506@garzik.org>
Date: Tue, 10 Jul 2007 13:44:32 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: fallocate-implementation-on-i86-x86_64-and-powerpc.patch
References: <20070710013152.ef2cd200.akpm@linux-foundation.org>	<20070710115251.GG2343@thunk.org> <20070710101558.cea7aab1.akpm@linux-foundation.org>
In-Reply-To: <20070710101558.cea7aab1.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-kernel@vger.kernel.org, Amit Arora <aarora@in.ibm.com>, Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, "Luck, Tony" <tony.luck@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mark Fasheh <mark.fasheh@oracle.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:
> So I dropped everything.  Let's start again from scratch.  I'd suggest that
> for now we go with just an i386/x86_64 implementation, let the arch
> maintainers wire things up when that has settled down.


It's my observation that that plan usually works the best.  Arch 
maintainers come along and wire up batches of syscalls when they have a 
chance to glance at the ABI, and catch up with x86[-64].

	Jeff




