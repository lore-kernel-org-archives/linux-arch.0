Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439E122E.3080902@yahoo.com.au>
Date: Tue, 13 Dec 2005 11:13:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> The attached patch introduces a simple mutex implementation as an alternative
> to the usual semaphore implementation where simple mutex functionality is all
> that is required.
> 
> This is useful in two ways:
> 
>  (1) A number of archs only provide very simple atomic instructions (such as
>      XCHG on i386, TAS on M68K, SWAP on FRV) which aren't sufficient to
>      implement full semaphore support directly. Instead spinlocks must be
>      employed to implement fuller functionality.
> 

We have atomic_cmpxchg. Can you use that for a sufficient generic
implementation?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
