From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling
 in fork
Date: Thu, 30 Aug 2018 09:12:13 +1000
Message-ID: <20180830091213.78b64354@roar.ozlabs.ibm.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-3-npiggin@gmail.com>
        <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 29 Aug 2018 08:42:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Aug 28, 2018 at 4:20 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > fork clears dirty/accessed bits from new ptes in the child. This logic
> > has existed since mapped page reclaim was done by scanning ptes when
> > it may have been quite important. Today with physical based pte
> > scanning, there is less reason to clear these bits.  
> 
> Can you humor me, and make the dirty/accessed bit patches separate?

Yeah sure.

> There is actually a difference wrt the dirty bit: if we unmap an area
> with dirty pages, we have to do the special synchronous flush.
> 
> So a clean page in the virtual mapping is _literally_ cheaper to have.

Oh yeah true, that blasted thing. Good point.

Dirty micro fault seems to be the big one for my Skylake, takes 300
nanoseconds per access. Accessed takes about 100. (I think, have to
go over my benchmark a bit more carefully and re-test).

Dirty will happen less often though, particularly as most places we
do write to (stack, heap, etc) will be write protected for COW anyway,
I think. Worst case might be a big shared shm segment like a database
buffer cache, but those kind of forks should happen very very
infrequently I would hope.

Yes maybe we can do that. I'll split them up and try to get some
numbers for them individually.

Thanks,
Nick
