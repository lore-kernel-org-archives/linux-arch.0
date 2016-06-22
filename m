From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cmpxchg and x86 flags output
Date: Tue, 21 Jun 2016 17:09:03 -0700
Message-ID: <7d1c236f-80d1-2c58-be0e-6676769636b3@zytor.com>
References: <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com>
 <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net>
 <4467.1466499980@warthog.procyon.org.uk>
 <559ea507-b3cb-74e0-7816-26bb8cbc0238@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44942 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcFVA3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 20:29:54 -0400
In-Reply-To: <559ea507-b3cb-74e0-7816-26bb8cbc0238@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 06/21/16 10:24, H. Peter Anvin wrote:
> On 06/21/16 02:06, David Howells wrote:
>>
>> However, there's probably not a great deal of difference to be had if the
>> inline asm codes the appropriate instruction in each case for something like
>> x86*.  The emitted code ought to look the same.  The second biggest win for
>> the intriniscs, I think, is the ability to ask the CMPXCHG instruction whether
>> it actually did anything rather than comparing the result.  I added two
>> variants, one that only returned the yes/no and one that passed back the value
>> as well as the yes/no.
>>
> 
> Right, and we want that either way.  The API change that you are
> proposing is definitely what we want; the specifics of the x86
> implementation is sort of orthogonal.
> 

So how do we make this move forward?

	-hpa
