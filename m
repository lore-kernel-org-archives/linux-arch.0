From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Date: Mon, 16 Mar 2020 15:48:35 +0000
Message-ID: <20200316154835.GA13004@willie-the-truck>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
 <20200309090650.GF12561@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200309090650.GF12561@hirez.programming.kicks-ass.net>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>, linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 09, 2020 at 10:06:50AM +0100, Peter Zijlstra wrote:
> On Sun, Mar 08, 2020 at 08:56:15PM +0100, Jonathan Neuschäfer wrote:
> > Hi,
> > 
> > this is a short series of unrelated fixes that make the atomic
> > operations documentation look and read a bit better.
> > 
> > Jonathan Neuschäfer (3):
> >   docs: atomic_ops: Remove colons where they don't make sense
> >   docs: atomic_ops: Move two paragraphs into the warning block above
> >   docs: atomic_ops: Steer readers towards using refcount_t for reference
> >     counts
> > 
> >  Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------
> 
> FWIW, I consider this a dead document. I've written
> Documentation/atomic_t.txt and Documentation/atomic_bitops.txt as a
> replacement. If there is anything in atomic_ops you feel is missing from
> those two, please tell as I'm planing to delete atomic_ops soon.

For the deletion:

Acked-by: Will Deacon <will@kernel.org>

Will
