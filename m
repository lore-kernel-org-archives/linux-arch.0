From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cmpxchg and x86 flags output
Date: Wed, 22 Jun 2016 09:36:55 -0700
Message-ID: <8455f920-3fea-a20b-1ac1-857870c80338@zytor.com>
References: <F800D95C-A84C-4F54-9620-F28465AC4A16@zytor.com>
 <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com>
 <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net>
 <4467.1466499980@warthog.procyon.org.uk>
 <16238.1466611894@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35312 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbcFVQhm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jun 2016 12:37:42 -0400
In-Reply-To: <16238.1466611894@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 06/22/16 09:11, David Howells wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> The question for me is for things like lock patching that we do on x86...
> 
> This might be pertinent to what you're asking:
> 
> 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70973
> 

I am kind of hesitant to put knowledge of this into gcc, because it
freezes something that currently is not gcc-dependent (although we could
separate out the gcc-generated and non-gcc-generated bits if we really
care.)  With the gcc flags output we can do this with assembly code as
well today (on x86), so it is unclear if we have any compelling reason
to need intrinsics that we won't be able to rely on existing for a long
time (the difference between gcc versions that have flags support and
don't have it has already been abstracted out in the x86/asm branch of
the tip tree, so we don't need two versions.)

	-hpa
