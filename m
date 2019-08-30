From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
Date: Fri, 30 Aug 2019 13:40:07 +0100
Message-ID: <20190830124007.z6f2qjujzluntrwb@willie-the-truck>
References: <20190827131818.14724-1-will@kernel.org>
 <1566947104.2uma6s0pl1.astroid@bobo.none>
 <20190828161256.uevoohval4sko24m@willie-the-truck>
 <1567085427.12jzc6eq6j.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1567085427.12jzc6eq6j.astroid@bobo.none>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 30, 2019 at 12:08:52AM +1000, Nicholas Piggin wrote:
> Will Deacon's on August 29, 2019 2:12 am:
> > On Wed, Aug 28, 2019 at 10:35:24AM +1000, Nicholas Piggin wrote:
> >> From the other side of the fabric you have no such problem. The table
> >> walker is cache coherent apart from the local stores, so we don't need a 
> >> special barrier on the other side. That's why ptesync doesn't broadcast.
> > 
> > Curious: but do you need to do anything extra to take into account
> > instruction fetch on remote CPUs if you're mapping an executable page?
> > We added an IPI to flush_icache_range() in 3b8c9f1cdfc5 to handle this,
> > because our broadcast I-cache maintenance doesn't force a pipeline flush
> > for remote CPUs (and may even execute as a NOP on recent cores).
> 
> Ah, I think the tlbie does not force re-fetch indeed. We may need
> something like that as well.
> 
> What do you do on the user side? Require threads to ISB themselves?

I think they'd probably have to use sys_membarrier() with
MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, yes.

Will
