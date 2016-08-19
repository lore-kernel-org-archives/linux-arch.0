From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cmpxchg and x86 flags output
Date: Fri, 19 Aug 2016 10:22:59 -0700
Message-ID: <d92e22b3-d0af-de6f-def6-9dfe73b91542@zytor.com>
References: <7d1c236f-80d1-2c58-be0e-6676769636b3@zytor.com>
 <5e5b99d7-c739-9743-b3e0-fbe0636d6dee@zytor.com>
 <40fd5f74-190e-b805-fbaa-f84899190fbc@zytor.com>
 <20160615085002.GC30935@twins.programming.kicks-ass.net>
 <4467.1466499980@warthog.procyon.org.uk>
 <559ea507-b3cb-74e0-7816-26bb8cbc0238@zytor.com>
 <16406.1466612063@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42580 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754653AbcHSRZL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Aug 2016 13:25:11 -0400
In-Reply-To: <16406.1466612063@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 06/22/16 09:14, David Howells wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> So how do we make this move forward?
> 
> Getting my API additions in is relatively straightforward, I think.  The
> whether-or-notness of the cmpxchg operation succeeding can be calculated by
> comparing the original value read from memory with the value-to-be-replaced
> inside the API function.
> 
> This can later be replaced with the boolean output from the CMPXCHG
> instruction, the branch target from the LL/SC skipping or the result of the
> intrinsics.
> 

Hi David,

Any news on this?  Can we perhaps help making this go forward at some point?

	-hpa
