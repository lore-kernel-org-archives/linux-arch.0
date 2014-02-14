From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Fri, 14 Feb 2014 10:50:11 +0100
Message-ID: <20140214095011.GG27965@twins.programming.kicks-ass.net>
References: <20140207074405.GM5002@laptop.programming.kicks-ass.net> <20140207165028.GO4250@linux.vnet.ibm.com> <20140207165548.GR5976@mudshark.cambridge.arm.com> <20140207180216.GP4250@linux.vnet.ibm.com> <1391992071.18779.99.camel@triegel.csb> <CA+55aFwTwCPMpYTL_vCgNNP0hE8s2sgB0iw-79=xoj99V0JUNA@mail.gmail.com> <20140211155941.GU4250@linux.vnet.ibm.com> <1392185194.18779.2239.camel@triegel.csb> <20140212091907.GA3545@laptop.programming.kicks-ass.net> <1392354475.18779.3849.camel@triegel.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-182019-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <1392354475.18779.3849.camel@triegel.csb>
To: Torvald Riegel <triegel@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 13, 2014 at 09:07:55PM -0800, Torvald Riegel wrote:
> That depends on what your goal is.

A compiler that we don't need to fight in order to generate sane code
would be nice. But as Linus said; we can continue to ignore you lot and
go on as we've done.
