From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: Behaviour of smp_mb__{before,after}_spin* and acquire/release
Date: Tue, 13 Jan 2015 19:45:10 +0100
Message-ID: <20150113184510.GA31525@redhat.com>
References: <20150113163353.GE31784@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150113163353.GE31784@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, torvalds@linux-foundation.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 01/13, Will Deacon wrote:
>
>   1. Does smp_mb__before_spinlock actually have to order prior loads
>      against later loads and stores? Documentation/memory-barriers.txt
>      says it does, but that doesn't match the comment

The comment says that smp_mb__before_spinlock() + spin_lock() should
only serialize STOREs with LOADs. This is because it was added to ensure
that the setting of condition can't race with ->state check in ttwu().

But since we use wmb() it obviously serializes STOREs with STORES. I do
not know if this should be documented, but we already have another user
which seems to rely on this fact: set_tlb_flush_pending().

As for "prior loads", this doesn't look true...

Oleg.
