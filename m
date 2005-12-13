Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20051213090349.GE10088@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu>
	 <1134460804.2866.17.camel@laptopd505.fenrus.org>
	 <20051213090349.GE10088@elte.hu>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 10:19:30 +0100
Message-Id: <1134465570.7362.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-12-13 at 10:03 +0100, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > even better than that, why not use the solution that we've implemented 
> > > for the -rt patchset, more than a year ago?
> > > 
> > > the solution i took was this:
> > > 
> > > - i did not touch the 'struct semaphore' namespace, but introduced a
> > >   'struct compat_semaphore'.
> > 
> > which I think is wrong. THis naming sucks. Sure doing a full sed on 
> > the tree is not pretty but it's also not THAT painful. And the pain of 
> > wrong names is something the kernel needs to carry around for years.
> 
> well, i'm all for renaming struct semaphore to struct mutex, but dont 
> the same arguments apply as to 'struct timer_list'?

don't think so; this is not a "lets do them one by one over the year",
this is a "do them all right now at once" move.
