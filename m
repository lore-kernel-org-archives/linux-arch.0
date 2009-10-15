From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [rfc][patch 4a/6] brlock: "fast" brlocks
Date: Thu, 15 Oct 2009 13:05:21 +0200
Message-ID: <1255604722.8392.467.camel@twins>
References: <20091015044026.319860788@suse.de>
	 <20091015050048.777261867@suse.de>  <20091015065839.GA4262@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20091015065839.GA4262@wotan.suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Thu, 2009-10-15 at 08:58 +0200, Nick Piggin wrote:
> [Not for merge. Stop reading if you're not interested in locking minutiae.]
> 
> OK, this is untested but I think the theory is right. Basically it is taking
> the idea from Dave M's cool brlock optimisation stuff with one further
> optimisation in that the read locker does not check the spinlock but
> rather we keep another wlocked variable together inthe same cacheline per
> CPU, so the read locker only has to touch one cacheline rather than 2.
> 
> This actually will reduce the number of atomics by 2 per path lookup,
> however we have an smp_mb() there now which is really nasty on some
> architectures (like ia64 and ppc64), and not that nice on x86 either.
> We can probably do something interesting on ia64 and ppc64 so that we
> take advantage of the fact rlocked and wlocked are in the same cacheline
> so cache coherency (rather than memory consistency) should always provide
> a strict ordering there. We still do need an acquire barrier -- but it is
> a much nicer lwsync or st.acq on ppc and ia64.
> 
> But: is the avoidance of the atomic RMW a big win? On x86 cores I've tested
> IIRC mfence is about as costly as a locked instruction which includes the
> mfence...
> 
> So long story short: it might be a small win but it is going to be very
> arch specific and will require arch specific code to do the barriers and
> things. The generic spinlock brlock isn't bad at all, so I'll just post
> this as a curiosity for the time being.
>  

fwiw, I rather like this implementation better, and adding lockdep
annotations to this one shouldn't be hard.
