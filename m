From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Thu, 6 Jul 2017 16:45:13 +0100
Message-ID: <20170706154512.GD15574@arm.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-9-palmer@dabbelt.com>
 <20170706020141.GA1965@infradead.org>
 <20170706085503.GA15053@arm.com>
 <20170706153427.GA30746@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706153427.GA30746@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org, mathieu.desnoyers@efficios.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 06, 2017 at 08:34:27AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 06, 2017 at 09:55:03AM +0100, Will Deacon wrote:
> > Agreed on the indirection; it feels like this is something that should be in
> > the vDSO, which could use the cmpxchg instruction if it's available, or
> > otherwise just uses plain loads and stores.
> 
> Even that seems like a lot of indirection for something that is in
> the critical fast path for synchronization.  I really can't understand
> how a new ISA / ABI could even come up with an idea as stupid as making
> essential synchronization primitives optional. 

No disagreement there!

Will
