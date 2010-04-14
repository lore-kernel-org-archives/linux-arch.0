From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Wed, 14 Apr 2010 12:49:20 +0100
Message-ID: <17213.1271245760@redhat.com>
References: <20100406133026.GD20577@parisc-linux.org> <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org> <20100326144241.8583.95617.stgit@warthog.procyon.org.uk> <28287.1269625325@redhat.com> <alpine.LFD.2.00.1003261042580.3721@i5.linux-foundation.org> <20100326175827.GD20055@linux-mips.org> <alpine.LFD.2.00.1003261100440.3721@i5.linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775Ab0DNLtx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Apr 2010 07:49:53 -0400
In-Reply-To: <20100406133026.GD20577@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>
Cc: dhowells@redhat.com, Ralf Baechle <ralf@linux-mips.org>, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:

> I don't know whether we can get it /documented/, but the architect I
> asked said "We'll never get away with reverting to the older behavior,
> so in essence the architecture is set to not overwrite."

Does that mean we can rely on it?  Linus?

David
