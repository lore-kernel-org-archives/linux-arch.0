Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439F6EAB.6030903@yahoo.com.au>
Date: Wed, 14 Dec 2005 12:00:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <439E122E.3080902@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com>
In-Reply-To: <22479.1134467689@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>We have atomic_cmpxchg. Can you use that for a sufficient generic
>>implementation?
> 
> 
> No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.
> 

atomic_cmpxchg should be available on all platforms.

While it may be strictly unnecessary, if it can be used to avoid
having a crappy default implementation that requires it to be
reimplemented in all architectures then that would be a good thing.

Any arguments about bad scalability or RT behaviour of the hashed
spinlock emulation atomic_t implementations are silly because they
are used by all atomic_ operations. It is an arch implementation
detail that generic code should not have to worry about.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
