From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 04/24] arm64: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 18:23:56 +0200
Message-ID: <20150710162356.GM19282@twins.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.361407648@infradead.org>
 <20150710084258.GA29323@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150710084258.GA29323@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, min
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 10, 2015 at 09:42:59AM +0100, Will Deacon wrote:
> Hi Peter,
> 
> On Thu, Jul 09, 2015 at 06:28:59PM +0100, Peter Zijlstra wrote:
> > Implement atomic logic ops -- atomic_{or,xor,and}.
> > 
> > These will replace the atomic_{set,clear}_mask functions that are
> > available on some archs.
> > 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Whilst this is pretty straight-foward, I have some serious rework on arm64
> atomic.h pending, so do you mind if I take this via the arm64 tree and
> resolve the conflicts myself?

Are those public anywhere.. The thing is, at the end of this series I
pretty much assume all archs will have these ops available, so whatever
tree I stick the rest in woudl have to pull in your branch too.

Also, IF you apply locally, do not forget to s/or/orr/ on the 64bit
versions, I seem to have missed updating those, just like I did on 32bit
arm.
