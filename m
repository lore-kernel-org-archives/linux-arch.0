Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1134556187.2894.7.camel@laptopd505.fenrus.org>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:03:07 +0000
Message-Id: <1134558188.25663.5.camel@localhost.localdomain>
Mime-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mer, 2005-12-14 at 11:29 +0100, Arjan van de Ven wrote:
> > >      But this means that the current usages all have to be carefully audited,
> > >      and sometimes that unobvious.
> > 
> > Only if you insist on replacing them immediately. If you submit a
> > *small* patch which just adds the new mutexes then a series of small
> > patches can gradually convert code where mutexes are better. 
> 
> this unfortunately is not very realistic in practice... 

Strange because it is how most such work has been done in the past, from
the big kernel lock to the scsi core rewrite. You also forgot to attach
a reason you think it isnt realistic ?

Alan
