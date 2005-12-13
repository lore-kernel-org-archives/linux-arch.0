Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 05:39:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213123930.GI9286@parisc-linux.org>
References: <20051212161944.3185a3f9.akpm@osdl.org> <dhowells1134431145@warthog.cambridge.redhat.com> <23765.1134470899@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23765.1134470899@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 10:48:19AM +0000, David Howells wrote:
> > > +#define is_mutex_locked(mutex)	((mutex)->state)
> > 
> > Let's keep the namespace consistent.  mutex_is_locked().
> 
> But that's a poor name: it turns it from a question into a statement:-(

Ah, but look at it in context of how it's used:

	if (is_mutex_locked())
That's gramatically incorrect!

	if (mutex_is_locked())
much better.
