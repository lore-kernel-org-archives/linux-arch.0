From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Date: Fri, 14 Feb 2020 10:55:13 +0100
Message-ID: <20200214095513.GJ14879@hirez.programming.kicks-ass.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2020 at 12:01:29PM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs into memory-model.
> 
> So I begin to do this and the plan is to add the litmus tests we already
> use in atomic_t.txt, ones from Paul's litmus collection[2], and any
> other valuable litmus test we come up while adding the previous two
> kinds of tests.
> 
> This patchset finishes the first part (adding atomic_t.txt litmus
> tests). I also improve the atomic_t.txt to make it consistent with the
> litmus tests.
> 
> One thing to note is patch #2 requires a modification to herd and I just
> made a PR to Luc's repo:
> 
> 	https://github.com/herd/herdtools7/pull/28
> 
> , so if this patchset looks good to everyone and someone plans to take
> it (and I assume is Paul), please wait until that PR is settled. And
> probably we need to bump the required herd version because of it.
> 
> Comments and suggesions are welcome!

Very nice, thanks!
