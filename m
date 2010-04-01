From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Thu, 01 Apr 2010 09:15:51 -0700
Message-ID: <4BB4C6B7.40302@zytor.com>
References: <20100325194100.GA2364@debian>	 <20100331134048.da4e35a7.akpm@linux-foundation.org>	 <4BB3B4DB.7040904@kernel.org> <20100331210145.GB32165@parisc-linux.org>	 <4BB3B8FC.1020608@zytor.com> <20100331211754.GC32165@parisc-linux.org>	 <alpine.DEB.2.00.1003311640410.30456@router.home>	 <20100331215411.GB17715@flint.arm.linux.org.uk>	 <4BB3C540.9000405@zytor.com> <1270075071.7101.79.camel@pasglop>	 <20100331154955.54176e5e.akpm@linux-foundation.org>	 <1270084631.7101.81.camel@pasglop>	 <20100331182654.d36c87ff.akpm@linux-foundation.org>	 <4BB43CAC.3080102@zytor.com>	 <20100331233330.1a7357e4.akpm@linux-foundation.org> <1270104536.7101.114.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270104536.7101.114.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Yinghai Lu <yinghai@kernel.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/31/2010 11:48 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2010-03-31 at 23:33 -0400, Andrew Morton wrote:
>> Just a few instructions, I guess.   But we can do it with zero.
>>
>> And from a design POV, pretending that down_read()/down_write() can be
>> called with interrupts disabled is daft - they cannot!  Why muck up
>> the
>> usual code paths with this startup-specific hack? 
> 
> Because we the problem of when interrupts are enabled for the first time
> is a nasty one, and having entire layer of things not usable at the
> right level of init because somewhere something might do an irq enable
> due to calling generic code that down's a semaphore is a PITA.
> 
> Seriously, Andrew, I don't see a clean solution... Something -somewhere-
> will have to be ugly.
> 
> Allocation is a pretty basic service that a lot of stuff expect
> especially when booting.
> 
> We went through that discussion before when we moved the SLAB init
> earlier during boot, because it makes no sense to have tons of code to
> have to figure out what allocator to call depending on what phase of the
> moon it's called from (especially when said code can also be called
> later during boot, say for hotplug reasons).
> 
> So we moved sl*b init earlier, thus we ought to be able to also
> kmem_cache_alloc() earlier. We -fixed- that problem already afaik.

I would like to point out that initialization is a particular subcase of
a more general rule:

- It is safe to call a semaphore/rwlock down with IRQ disabled *if and
only if* the caller can guarantee non-contention.

Initialization is an obvious subcase, but there might be others.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
