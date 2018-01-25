From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Automate memory-barriers.txt; provide Linux-kernel
 memory model
Date: Thu, 25 Jan 2018 01:35:29 -0800
Message-ID: <20180125093529.GA3741@linux.vnet.ibm.com>
References: <20180119035855.GA29296@linux.vnet.ibm.com>
 <20180119171211.GA13636@linux.vnet.ibm.com>
 <20180124000014.GA1562@linux.vnet.ibm.com>
 <20180124105955.GA21491@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124105955.GA21491@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, linux-kernel@vger.kernel.org, elena.reshetova@intel.com, mhocko@suse.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 24, 2018 at 10:59:55AM +0000, Will Deacon wrote:
> Hi Paul,
> 
> On Tue, Jan 23, 2018 at 04:00:14PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 19, 2018 at 09:12:11AM -0800, Paul E. McKenney wrote:
> > > On Thu, Jan 18, 2018 at 07:58:55PM -0800, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > There is some reason to believe that Documentation/memory-barriers.txt
> > > > could use some help, and a major purpose of this patch is to provide
> > > > that help in the form of a design-time tool that can produce all valid
> > > > executions of a small fragment of concurrent Linux-kernel code, which is
> > > > called a "litmus test".  This tool's functionality is roughly similar to
> > > > a full state-space search.  Please note that this is a design-time tool,
> > > > not useful for regression testing.  However, we hope that the underlying
> > > > Linux-kernel memory model will be incorporated into other tools capable
> > > > of analyzing large bodies of code for regression-testing purposes.
> > > > 
> > > > The main tool is herd7, together with the linux-kernel.bell,
> > > > linux-kernel.cat, linux-kernel.cfg, linux-kernel.def, and lock.cat files
> > > > added by this patch.  The herd7 executable takes the other files as input,
> > > > and all of these files collectively define the Linux-kernel memory memory
> > > > model.  A brief description of each of these other files is provided
> > > > in the README file.  Although this tool does have its limitations,
> > > > which are documented in the README file, it does improve on the version
> > > > reported on in the LWN series (https://lwn.net/Articles/718628/ and
> > > > https://lwn.net/Articles/720550/) by supporting locking and arithmetic,
> > > > including a much wider variety of read-modify-write atomic operations.
> > > > Please note that herd7 is not part of this submission, but is freely
> > > > available from http://diy.inria.fr/sources/index.html (and via "git"
> > > > at https://github.com/herd/herdtools7).
> > > 
> > > Please note that the latest version of herd is necessary for this version
> > > of the memory model.  With older versions, you will get error messages
> > > like the following:
> > > 
> > > File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)
> > > 
> > > Many thanks to Andrea for spotting this one!
> > 
> > And given that I am hearing no objections, I am thinking in terms of
> > sending this in a pull request later this week.
> 
> No objections from me. I can't claim to have deep knowledge about everything
> being contributed here, but I think that the documentation is well-written
> and a welcome addition to the codebase (thanks, Alan!). I also find that,
> whilst complicated, the gist of the .cat file comes across pretty well and
> is less confusing than the previous situation where we had two .cat files
> for the strong and weak models.
> 
> At this stage of maturity, I think that this is all much better as part of
> the kernel sources and maintained as such, knowing that things will change
> as we encounter new tests and CPU architectures.

Sounds very good to me!  I just sent a pull request.  Wish me luck.  ;-)

							Thanx, Paul
