Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 10:39:49 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213093949.GC26097@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090219.GA27857@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 13, 2005 at 08:54:41AM +0100, Ingo Molnar wrote:
> > - i did not touch the 'struct semaphore' namespace, but introduced a
> >   'struct compat_semaphore'.
> 
> Because it's totally braindead.  Your compat_semaphore is a real 
> semaphore and your semaphore is a mutex.  So name them as such.

well, i had the choice between a 30K patch, a 300K patch and a 3000K 
patch. I went for the 30K patch ;-)

> > - i introduced a 'type-sensitive' macro wrapper that switches down() 
> >   (and the other APIs) to either to the assembly variant (if the 
> >   variable's type is struct compat_semaphore), or switches it to the new 
> >   generic mutex (if the type is struct semaphore), at build-time. There 
> >   is no runtime overhead due to this build-time-switching.
> 
> And this one is probably is a great help to win the obsfucated C 
> contests, but otherwise just harmfull.

i never found it to be harmful in any way, and we've now got a year of 
experience with them. Could you elaborate?

	Ingo
