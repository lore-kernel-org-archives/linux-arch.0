From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Sat, 18 Jul 2020 10:08:11 -0400
Message-ID: <20200718140811.GA1179836@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200718014204.GN5369@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

> This is one of the reasons that the LKMM documetnation is so damn
> difficult to read and understand: just understanding the vocabulary
> it uses requires a huge learning curve, and it's not defined
> anywhere. Understanding the syntax of examples requires a huge
> learning curve, because it's not defined anywhere. 

Have you seen tools/memory-model/Documentation/explanation.txt?  That
file was specifically written for non-experts to help them overcome the
learning curve.  It tries to define the vocabulary as terms are
introduced and to avoid using obscure syntax.

If you think it needs improvement and can give some specific details
about where it falls short, I would like to hear them.

Alan Stern
