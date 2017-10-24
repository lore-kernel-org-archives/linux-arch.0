From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 17/19] locking/barriers: Kill lockless_dereference
Date: Tue, 24 Oct 2017 11:31:04 +0200
Message-ID: <20171024093104.rukpl26fukj7bxvg@gmail.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
 <1508792849-3115-17-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508792849-3115-17-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> From: Will Deacon <will.deacon@arm.com>
> 
> lockless_dereference is a nice idea, but its gained little traction in
> kernel code since it's introduction three years ago. This is partly

s/its/it
s/it's/its

> because it's a pain to type, but also because using READ_ONCE instead
> will work correctly on all architectures apart from Alpha, which is a
> fully supported but somewhat niche architecture these days.
> 
> This patch moves smp_read_barrier_depends() (a NOP on all architectures
> other than Alpha) from lockless_dereference into READ_ONCE, converts
> the few actual users over to READ_ONCE and then finally removes
> lockless_dereference altogether.

Nit: if we refer to smp_read_barrier_depends() with parentheses (which is the nice 
thing to do for function-alike symbols), then we should do the same with 
READ_ONCE() and lockless_dereference() as well.

Also, could we please split this into three patches:

 #1: Add smp_read_barrier_depends() to READ_ONCE()
 #2: Convert all lockless_dereference() users to READ_ONCE()
 #3: Remove the now unused lockless_dereference() API

to make it easier to analyze if bisected to, should any problems arise?

Thanks,

	Ingo
