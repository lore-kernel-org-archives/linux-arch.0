From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:18:44 +0200
Message-ID: <20170607121844.maut2n46gjaav5ic@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
 <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 07, 2017 at 02:06:13PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:

> > +static inline int atomic_fetch_sub(unsigned int mask, atomic_t *v)
> > +{
> > +	int out;
> > +
> > +	__asm__ __volatile__ (
> > +		"amosub.w %2, %1, %0"
> > +		: "+A" (v->counter), "=r" (out)
> > +		: "r" (mask));
> > +	return out;
> > +}

Your instruction manual does not list AMOSUB as a valid instruction. So
either it is wrong or this code never compiled. Please clarify.
