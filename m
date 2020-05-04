Return-Path: <SRS0=VNB8=6S=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Mon, 4 May 2020 11:50:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 00/14] Move the ReST files from Documentation/*.txt
Message-ID: <20200504115023.2ead040f@coco.lan>
In-Reply-To: <9f79e15a-4e36-3747-51fc-ca2d8ab616b7@gmail.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <9f79e15a-4e36-3747-51fc-ca2d8ab616b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, David Howells <dhowells@redhat.com>, Andrea Parri <parri.andrea@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Will Deacon <will@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Joe Perches <joe@perches.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200504095023.ETnueYpx7v_kITz6BxIpfGzqr6DwiFRf6_Q3MpxCR9k@z>

Em Mon, 4 May 2020 18:25:51 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> (CC to documentation, get_maintainer, and LKMM maintainers)
> 
> Hi Mauro,
> 
> As I didn't receive "[PATCH 12/14] docs: move remaining stuff under
> Documentation/*.txt to Documentation/staging", I'm replying to
> [PATCH 00/14].
>
> diff stat above shows you are not moving Documentation/atomic_bitops.txt in
> this series. However, PATCH 12/14 contains the following hunks:
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1aa6e89e7424..8aa8f7c0db93 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS  
> [...]
> > @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > -F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/staging/atomic_bitops.txt
> >  F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst  
> 
> [...]
> 
> > diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
> > index dd90c9792909..edeeb8375006 100644
> > --- a/include/asm-generic/bitops/atomic.h
> > +++ b/include/asm-generic/bitops/atomic.h
> > @@ -8,7 +8,7 @@
> >  
> >  /*
> >   * Implementation of atomic bitops using atomic-fetch ops.
> > - * See Documentation/atomic_bitops.txt for details.
> > + * See Documentation/staging/atomic_bitops.txt for details.
> >   */
> >  
> >  static inline void set_bit(unsigned int nr, volatile unsigned long *p)  
> 
> Please drop them.

Thanks for pointing! Yeah, I noticed that too from Joe's review.
Already dropped locally. I'll post a new version without such change.


Thanks,
Mauro
