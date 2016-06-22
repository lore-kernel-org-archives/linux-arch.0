Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36872 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbcFVRtu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 13:49:50 -0400
Subject: Re: cmpxchg and x86 flags output
References: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com>
 <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com>
 <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net>
 <4467.1466499980@warthog.procyon.org.uk>
 <16238.1466611894@warthog.procyon.org.uk>
 <8455f920-3fea-a20b-1ac1-857870c80338@zytor.com>
 <CA+55aFxva_dW+=10JA9G1d1uAW1rHimLS5jGVUeNxfFepFzA9A@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <c4704d53-e6eb-4cc4-4d3f-023ff36157b6@zytor.com>
Date: Wed, 22 Jun 2016 10:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFxva_dW+=10JA9G1d1uAW1rHimLS5jGVUeNxfFepFzA9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20160622174906.k-vN-dsY1scPg6-hux2W3_0V-tnA9J2cL0ylkBUII2I@z>

On 06/22/16 10:11, Linus Torvalds wrote:
> 
> I thought Richard Henderson already had a patch for the condition code
> asm outputs, but maybe I misremember.
> 

It is already in the released version of gcc 6.1; there is a patchset in
-tip already for using it for everything other than cmpxchg using the
CC_SET/CC_OUT macros I proposed a while ago.  cmpxchg is special because
it requires API changes to take advantage of, which as far as I
understand happens to be exactly the API changes that David has already
implemented.  Apparently some other architectures really can benefit
from intrinsics, so that is okay; we can use inline asm with flags
output on x86.

	-hpa


