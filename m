From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Fri, 17 Jul 2020 10:26:32 -0400
Message-ID: <20200717142632.GA1147780@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:

...
> +Note that when the cmpxchg_release() fails due to another task already
> +having done it, a second smp_load_acquire() is required, since we still
> +need to acquire the data that the other task released.

When people talk about releasing data, they usually mean something 
different from what you mean here (i.e., they usually mean 
deallocating).  Likewise, acquiring data (to the extent that it means 
anything) would generally be regarded as meaning a simple read.  I 
recommend changing the last phrase above to:

	... since we still need a load-acquire of the data on which
	the other task performed a store-release.

Alan Stern
