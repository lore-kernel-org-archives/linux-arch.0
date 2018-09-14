From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Date: Fri, 14 Sep 2018 09:36:49 -0700
Message-ID: <20180914163649.GA13942@linux.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 02:10:18PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains memory-model updates, not yet ready for inclusion:

Summarizing my current state for the week after next's planned
for-inclusion series:

	ccc8b5139f65 tools/memory-model: Add litmus-test naming scheme
	c8c5779c854f tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
	a5109023cf9e tools/memory-model: Fix a README typo
	abdb4ce79ba3 tools/memory-model: Add more LKMM limitations

		I have these queued for the next merge window.	There has
		been some discussion of c8c5779c854f, and it would be
		good to resolve issues.  However, the patch is supported
		by Peter Zijlstra (x86) and Will Deacon (ARM), so I
		am OK sending it as-is if needed.  We always have the
		opportunity of adding other patches as needed.

		The latest email from Andrea indicated some concerns about
		the commit log, which cannot be changed after acceptance,
		so resolving those concerns is the highest priority.

	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()

		Small change, needs an ack.  Looks to me like is is
		just aligning the documentation with the code, so
		should not be controversial (famous last words).

		Please take a look and consider giving feedback
		and/or a review/ack.

	f3625642c96d EXP tools/memory-model: Add scripts to check github litmus tests
	eaaac2854b75 EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"

		These add regression-test capability and need a review
		and/or ack before they can be submitted.  I do not
		consider them to be particularly urgent.

							Thanx, Paul
