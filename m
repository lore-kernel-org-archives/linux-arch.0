From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Date: Tue, 21 Jan 2020 15:47:16 +0100
Message-ID: <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
 <20200120202359.GF2935@paulmck-ThinkPad-P72>
 <20200121091501.GF14914@hirez.programming.kicks-ass.net>
 <20200121142109.GQ2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200121142109.GQ2935@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, andreyknvl@google.com, glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 21, 2020 at 06:21:09AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 21, 2020 at 10:15:01AM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> > > We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> > > and atomic_set() are considered to be non-racy, right?
> > 
> > What is racy? :-) You can make data races with atomic_{read,set}() just
> > fine.
> 
> Like "fairness", lots of definitions of "racy".  ;-)
> 
> > Anyway, traditionally we call the read-modify-write stuff atomic, not
> > the trivial load-store stuff. The only reason we care about the
> > load-store stuff in the first place is because C compilers are shit.
> > 
> > atomic_read() / test_bit() are just a load, all we need is the C
> > compiler not to be an ass and split it. Yes, we've invented the term
> > single-copy atomicity for that, but that doesn't make it more or less of
> > a load.
> > 
> > And exactly because it is just a load, there is no __test_bit(), which
> > would be the exact same load.
> 
> Very good!  Shouldn't KCSAN then define test_bit() as non-racy just as
> for atomic_read()?

Sure it does; but my comment was aimed at the gripe that test_bit()
lives in the non-atomic bitops header. That is arguably entirely
correct.
