Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439E122E.3080902@yahoo.com.au> 
References: <439E122E.3080902@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 09:54:49 +0000
Message-ID: <22479.1134467689@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> We have atomic_cmpxchg. Can you use that for a sufficient generic
> implementation?

No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.

David
