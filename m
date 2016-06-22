From: David Howells <dhowells@redhat.com>
Subject: Re: cmpxchg and x86 flags output
Date: Wed, 22 Jun 2016 17:14:23 +0100
Message-ID: <16406.1466612063@warthog.procyon.org.uk>
References: <7d1c236f-80d1-2c58-be0e-6676769636b3@zytor.com> <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com> <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com> <20160615085002.GC30935@twins.programming.kicks-ass.net> <4467.1466499980@warthog.procyon.org.uk> <559ea507-b3cb-74e0-7816-26bb8cbc0238@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbcFVQOZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 12:14:25 -0400
In-Reply-To: <7d1c236f-80d1-2c58-be0e-6676769636b3@zytor.com>
Content-ID: <16405.1466612063.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

H. Peter Anvin <hpa@zytor.com> wrote:

> So how do we make this move forward?

Getting my API additions in is relatively straightforward, I think.  The
whether-or-notness of the cmpxchg operation succeeding can be calculated by
comparing the original value read from memory with the value-to-be-replaced
inside the API function.

This can later be replaced with the boolean output from the CMPXCHG
instruction, the branch target from the LL/SC skipping or the result of the
intrinsics.

David
