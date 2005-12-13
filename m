Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 11:00:15 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213100015.GA32194@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213093949.GC26097@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> > On Tue, Dec 13, 2005 at 08:54:41AM +0100, Ingo Molnar wrote:
> > > - i did not touch the 'struct semaphore' namespace, but introduced a
> > >   'struct compat_semaphore'.
> > 
> > Because it's totally braindead.  Your compat_semaphore is a real 
> > semaphore and your semaphore is a mutex.  So name them as such.
> 
> well, i had the choice between a 30K patch, a 300K patch and a 3000K 
> patch. I went for the 30K patch ;-)

in that sense i'm all for going for the 300K patch, which is roughly the 
direction David is heading into: rename to 'struct mutex' but keep the 
down/up APIs, and introduce sem_down()/sem_up()/ for the cases that need 
full semaphores.

i dont think the 3000K patch (full API rename, introduction of 
mutex_down()/mutex_up()) is realistic.

	Ingo
