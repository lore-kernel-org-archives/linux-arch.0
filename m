From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
Date: Thu, 15 Oct 2009 12:59:13 +0100
Message-ID: <1255607953.10164.63.camel@pc1117.cambridge.arm.com>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
	<20091012.023744.157085851.davem@davemloft.net>
	<20091012100023.GC29310@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.0910121634170.7327@sister.anvils>
	<20091012170312.GB9453@flint.arm.linux.org.uk>
	<20091013020752.GB5736@linux-sh.org>
	<1255540229.15103.50.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255540229.15103.50.camel@pc1117.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Nitin Gupta <ngupta@vflare.org>, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-10-14 at 18:10 +0100, Catalin Marinas wrote:
> On Tue, 2009-10-13 at 11:07 +0900, Paul Mundt wrote:
> > On Mon, Oct 12, 2009 at 06:03:12PM +0100, Russell King wrote:
> > > I don't see that there should have been any bearing on whether a page
> > > has a mapping or not when we get to update_mmu_cache.  The issue here
> > > is that > if PG_arch_1 is set on a page, then we didn't flush it at
> > > the time when we believed it was appropriate to do so. <
> > > 
> > > Tell me I'm wrong (having only just sent it to Linus...)
> > 
> > Having looked at the ARM fix, in the !mapping case do you not need the
> > I-cache flush on vma->vm_flags & VM_EXEC? Or is the presumption that
> > flush_icache_page()-type action doesn't need to be undertaken by
> > flush_dcache_page()/update_mmu_cache() when there is no page_mapping()?
> 
> If I understand Nitin's scenario correctly, I think it should also
> invalidate the I-cache.
> 
> For executable anonymous pages containing, it's the user app writing the
> code (JIT etc.) and it calls an ARM-specific syscall for I and D cache
> maintenance. If such page is read back from swap, following Nitin's
> scenario, the I-cache would need to be invalidated as well otherwise it
> can have stale entries.

We can have a scenario where I-cache invalidation would not help on ARM.
Some apps may temporarily change protection from RX to RW to write some
data (not instructions) to a page containing code. If Nitin's scenario
happens when the page is RW, the VM_EXEC wouldn't be set, hence no
I-cache invalidation.

The app would later do mprotect(RX) but on some ARM processors
flush_cache_range() is a no-op and therefore no cache flushing. What
other architectures with Harvard caches do for mprotect(RX)? Is this
assumed to invalidate the I-cache?

(we have another I-D cache coherency problem on ARM with COW text pages
following a RX -> RW -> write data -> RX scenario and there are a few
solutions for this, though none of them optimal with the current cache
flushing API, especially with the read-implies-exec ELF personality)

-- 
Catalin
