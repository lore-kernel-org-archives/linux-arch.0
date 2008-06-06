From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Fri, 6 Jun 2008 10:32:47 +1000
Message-ID: <200806061032.47598.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <4846AD84.2090800@sgi.com> <4846B084.6000607@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762888AbYFFAdR@vger.kernel.org>
In-Reply-To: <4846B084.6000607@cosmosbay.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Mike Travis <travis@sgi.com>, Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 05 June 2008 01:11:00 Eric Dumazet wrote:
> Mike Travis a =E9crit :
> > I'm a bit confused.  Why is DEFINE_PER_CPU_SHARED_ALIGNED() conditi=
oned
> > on ifdef MODULE?
> Because we had crashes when loading oprofile module, when a previous
> version of oprofile used to use DEFINE_PER_CPU_SHARED_ALIGNED variabl=
e
>
> module loader only takes into account the special section ".data.perc=
pu"
> and ignores ".data.percpu.shared_aligned"
>
> I therefore submitted two patches :

Put one way, putting page-aligned per-cpu data in a separate section is=
 a=20
space-saving hack: one which is not really required for modules because=
 of=20
the low frequency of such variables.  Put another way, not respecting=20
the .data.percpu.shared_aligned section in modules is a bug.

But a comment would probably be nice!

Cheers,
Rusty.
