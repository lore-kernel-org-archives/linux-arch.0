From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Fri, 7 Feb 2014 18:20:53 +0100
Message-ID: <20140207172053.GT5002@laptop.programming.kicks-ass.net>
References: <20140206192743.GH4250@linux.vnet.ibm.com> <1391721423.23421.3898.camel@triegel.csb> <20140206221117.GJ4250@linux.vnet.ibm.com> <1391730288.23421.4102.camel@triegel.csb> <20140207042051.GL4250@linux.vnet.ibm.com> <20140207074405.GM5002@laptop.programming.kicks-ass.net> <20140207165028.GO4250@linux.vnet.ibm.com> <20140207165548.GR5976@mudshark.cambridge.arm.com> <20140207170654.GQ5002@laptop.programming.kicks-ass.net> <20140207171336.GU5976@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-181907-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20140207171336.GU5976@mudshark.cambridge.arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Torvald Riegel <triegel@redhat.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 07, 2014 at 05:13:36PM +0000, Will Deacon wrote:
> Understood, but that doesn't explain why Paul wants to add ISB/isync
> instructions which affect the *CPU* rather than the compiler!

I doubt Paul wants it, but yeah, I'm curious about that proposal as
well, sounds like someone took a big toke from the bong again; it seems
a favourite past time amongst committees.
