From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Tue, 29 May 2018 10:30:50 +0100
Message-ID: <20180529093050.GB6533@arm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525191020.GA5914@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> This commit documents the scheme used to generate the names for the
> litmus tests.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 1 deletion(-)

Whilst I think documentation like this is extremely important for users,
this feels like it's documenting how to drive parts of diy and I'm not
convinced that it belongs in the kernel source tree as long as the projects
remain separate.

Why not contribute this to the herdtools7 documentation, then just reference
that from here? That would also be helpful for other people interested in
memory models, but perhaps not interested in Linux (assuming such people
exist ;).

Cheers,

Will
