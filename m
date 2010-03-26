From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Fri, 26 Mar 2010 17:42:05 +0000
Message-ID: <28287.1269625325@redhat.com>
References: <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org> <20100326144241.8583.95617.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772Ab0CZRm2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 13:42:28 -0400
In-Reply-To: <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Where did you find that "doesn't modify its output" thing? It's not true. 
> The truth is that the destination is undefined. Just read the dang Intel 
> documentation, it's very clearly stated right there.

Hmmm...  My ancient Borland Assembler dead-tree manual doesn't mention that.

David
