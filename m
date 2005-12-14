Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1134558188.25663.5.camel@localhost.localdomain>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:08:27 +0100
Message-Id: <1134558507.2894.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2005-12-14 at 11:03 +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 11:29 +0100, Arjan van de Ven wrote:
> > > >      But this means that the current usages all have to be carefully audited,
> > > >      and sometimes that unobvious.
> > > 
> > > Only if you insist on replacing them immediately. If you submit a
> > > *small* patch which just adds the new mutexes then a series of small
> > > patches can gradually convert code where mutexes are better. 
> > 
> > this unfortunately is not very realistic in practice... 
> 
> Strange because it is how most such work has been done in the past, from
> the big kernel lock to the scsi core rewrite.

1) the BKL change hasn't finished, and we're 5 years down the line. API
changes done gradual tend to take forever in practice, esp if there's no
"compile" incentive for people to fix things. 

2) the scsi rewrite was a major functional change. that's different from
a basically pure API change (split). Splitting functional changes to one
part of the kernel up into a sequence is very good. THat's different
though: even in the scsi change, API changes that went outside the scsi
core into the drivers were mostly done in one bang (not all of them, the
ones that weren't ended up being rather painful)


>  You also forgot to attach
> a reason you think it isnt realistic ?
> 
that was in a follow up email
