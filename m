Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43A350C0.8030805@yahoo.com.au>
Date: Sat, 17 Dec 2005 10:41:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <43A2BE49.4000102@yahoo.com.au>  <43A08D50.30707@yahoo.com.au> <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com> <20220.1134748431@warthog.cambridge.redhat.com>
In-Reply-To: <20220.1134748431@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:

>>It is not even clear that any ll/sc based architectures would need to override
>>an atomic_cmpxchg variant at all because you can assume an unlocked fastpath
> 
> 
> That's irrelevant. Any arch that has LL/SC almost certainly emulates CMPXCHG
> with LL/SC.
> 

It is not irrelevant because many architectures that would care are ll/sc
based and many others have a native cmpxchg ie. cmpxchg wouldn't be a bad
choice for default.

> 
>>and not do the additional initial load to prime the cmpxchg.
> 
> 
> Two points:
> 
>  (1) LL/SC does not require an additional initial load.
> 

?? I was only talking about cmpxchg

>  (2) CMPXCHG does an implicit load; how else can it compare?
> 

Read Russell's posts. He points out that most usages of cmpxchg
will require an additional load compared with an llsc in order to
find the value to work on.

cmpxchg(lock, UNLOCKED, LOCKED)

does not (although it may still require an extra branch).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
