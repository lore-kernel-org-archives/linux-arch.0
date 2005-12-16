Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <43A2BE49.4000102@yahoo.com.au> 
References: <43A2BE49.4000102@yahoo.com.au>  <43A08D50.30707@yahoo.com.au> <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Fri, 16 Dec 2005 16:02:11 +0000
Message-ID: <20450.1134748931@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> So I don't know why you're so worried about sparc32 and parisc while
> preferring to introduce a worse default implementation that even your frv
> architecture wants to override...?

I now think the base default should be a wrapper around the counting
semaphores, because that is the easiest path (they already exist) and it's
also the fastest path on some platforms.

But I want to be able to override the implementation on such as FRV because I
can do a better mutex than a counting semaphore there as I only have SWAP
available as an atomic op.

However, I would like to make the unconditional-exchange mutex a template that
can be overridden so that other archs can use it with one Kconfig option and a
few #defines in asm/system.h.

David
