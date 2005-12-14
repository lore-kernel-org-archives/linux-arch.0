Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1134490205.11732.97.camel@localhost.localdomain>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 11:29:41 +0100
Message-Id: <1134556187.2894.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-12-13 at 16:10 +0000, Alan Cox wrote:
> On Maw, 2005-12-13 at 15:39 +0000, David Howells wrote:
> >  (3) Some people want mutexes to be:
> > 
> >      (a) only releasable in the same context as they were taken
> > 
> >      (b) not accessible in interrupt context, or that (a) applies here also
> > 
> >      (c) not initialisable to the locked state
> > 
> >      But this means that the current usages all have to be carefully audited,
> >      and sometimes that unobvious.
> 
> Only if you insist on replacing them immediately. If you submit a
> *small* patch which just adds the new mutexes then a series of small
> patches can gradually convert code where mutexes are better. 

this unfortunately is not very realistic in practice... 
