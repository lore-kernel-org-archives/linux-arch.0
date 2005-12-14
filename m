Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439FFF63.6020105@yahoo.com.au>
Date: Wed, 14 Dec 2005 22:17:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <439F6EAB.6030903@yahoo.com.au>  <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com>
In-Reply-To: <13613.1134557656@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>atomic_cmpxchg should be available on all platforms.
> 
> 
> Two points:
> 
>  (1) If it's using spinlocks, then it's pointless to use atomic_cmpxchg.
> 

Why?

>  (2) atomic_t is a 32-bit type, and on a 64-bit platform I will want a 64-bit
>      type so that I can stick the owner address in there (I've got a second
>      variant not yet released).
> 

I'm sure you could use a seperate field as it would be a debug
option, right?

But atomic longs are coming along and it is probably feasable to
do 64-bit atomic_cmpxchg on all 64-bit word architectures if you
really needed that.

Send instant messages to your online friends http://au.messenger.yahoo.com 
