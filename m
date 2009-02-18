From: Gleb Natapov <gleb@redhat.com>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove
	single ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 18:37:22 +0200
Message-ID: <20090218163722.GJ26845@redhat.com>
References: <20090217101130.GA8660@wotan.suse.de> <1234866453.4744.58.camel@laptop> <20090217112657.GE26402@wotan.suse.de> <20090217192810.GA4980@redhat.com> <20090217213256.GJ6761@linux.vnet.ibm.com> <20090217214518.GA13189@redhat.com> <20090217223910.GM6761@linux.vnet.ibm.com> <20090218135212.GB23125@wotan.suse.de> <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain> <20090218162116.GC29863@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=cp1255
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:44261 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbZBRQkp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Feb 2009 11:40:45 -0500
Content-Disposition: inline
In-Reply-To: <20090218162116.GC29863@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Suresh Siddha <suresh.b.siddha@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Yinghai Lu <yinghai@kernel.org>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 18, 2009 at 05:21:16PM +0100, Ingo Molnar wrote:
>=20
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > On Wed, 18 Feb 2009, Nick Piggin wrote:
> > >=20
> > > I agree with you both that we *should* make arch interrupt code
> > > do the ordering, but given the subtle lockups on some architectur=
es
> > > in this new code, I didn't want to make it significantly weaker..=
=2E
> > >=20
> > > Though perhaps it appears that I have, if I have removed an smp_m=
b
> > > that x86 was relying on to emit an mfence to serialise the apic.
> >=20
> > The thing is, if the architecture doesn't order IPI wrt cache coher=
ency,=20
> > then the "smp_mb()" doesn't really do so _either_.=20
> >=20
> > It might hide some architecture-specific implementation issue, of c=
ourse,=20
> > so random amounts of "smp_mb()"s sprinkled around might well make s=
ome=20
> > architecture "work", but it's in no way guaranteed. A smp_mb() does=
 not=20
> > guarantee that some separate IPI network is ordered - that may well=
 take=20
> > some random machine-specific IO cycle.
> >=20
> > That said, at least on x86, taking an interrupt should be a seriali=
zing=20
> > event, so there should be no reason for anything on the receiving s=
ide.=20
> > The _sending_ side might need to make sure that there is serializat=
ion=20
> > when generating the IPI (so that the IPI cannot happen while the wr=
ites=20
> > are still in some per-CPU write buffer and haven't become part of t=
he=20
> > cache coherency domain).
> >=20
> > And at least on x86 it's actually pretty hard to generate out-of-or=
der=20
> > accesses to begin with (_regardless_ of any issues external to the =
CPU).=20
> > You have to work at it, and use a WC memory area, and I'm pretty su=
re we=20
> > use UC for the apic accesses.
>=20
> yeah, we do. I do remember one x2apic related memory ordering=20
> bug though which happened in the past 6 months or so, lemme find=20
> the commit.
>=20
> This one is it:
>=20
>   d6f0f39: x86: add smp_mb() before sending INVALIDATE_TLB_VECTOR
>=20
> attached below.
>=20
> The reason for that is that x2apic changes the access sequence=20
> from mmio (which old lapic used to be, and which was mapped UC),=20
> to an MSR sequence:
>=20
>  static inline void native_x2apic_icr_write(u32 low, u32 id)
>  {
>          wrmsrl(APIC_BASE_MSR + (APIC_ICR >> 4), ((__u64) id) << 32 |=
 low);
>  }
>=20
> But ... WRMSR should already be serializing - it is documented=20
> as a serializing instruction.
>=20
=46WIW that is what Intel docs says:

To allow for efficient access to the APIC registers in x2APIC mode,
the serializing semantics of WRMSR are relaxed when writing to the APIC
registers. Thus, system software should not use =93WRMSR to APIC regist=
ers
in x2APIC mode=94 as a serializing instruction. Read and write accesses
to the APIC registers will occur in program order.

> I've cc:-ed Suresh & other APIC experts - exactly what type of=20
> hang did that patch fix? Do certain CPUs perhaps cut=20
> serialization corners, to speed up x2apic accesses?
>=20
> 	Ingo
>=20
> ------------------->
> >From d6f0f39b7d05e62b347c4352d070e4afb3ade4b5 Mon Sep 17 00:00:00 20=
01
> From: Suresh Siddha <suresh.b.siddha@intel.com>
> Date: Tue, 4 Nov 2008 13:53:04 -0800
> Subject: [PATCH] x86: add smp_mb() before sending INVALIDATE_TLB_VECT=
OR
>=20
> Impact: fix rare x2apic hang
>=20
> On x86, x2apic mode accesses for sending IPI's don't have serializing
> semantics. If the IPI receivner refers(in lock-free fashion) to some
> memory setup by the sender, the need for smp_mb() before sending the
> IPI becomes critical in x2apic mode.
>=20
> Add the smp_mb() in native_flush_tlb_others() before sending the IPI.
>=20
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/x86/kernel/tlb_32.c |    6 ++++++
>  arch/x86/kernel/tlb_64.c |    5 +++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/x86/kernel/tlb_32.c b/arch/x86/kernel/tlb_32.c
> index e00534b..f4049f3 100644
> --- a/arch/x86/kernel/tlb_32.c
> +++ b/arch/x86/kernel/tlb_32.c
> @@ -154,6 +154,12 @@ void native_flush_tlb_others(const cpumask_t *cp=
umaskp, struct mm_struct *mm,
>  	flush_mm =3D mm;
>  	flush_va =3D va;
>  	cpus_or(flush_cpumask, cpumask, flush_cpumask);
> +
> +	/*
> +	 * Make the above memory operations globally visible before
> +	 * sending the IPI.
> +	 */
> +	smp_mb();
>  	/*
>  	 * We have to send the IPI only to
>  	 * CPUs affected.
> diff --git a/arch/x86/kernel/tlb_64.c b/arch/x86/kernel/tlb_64.c
> index dcbf7a1..8f919ca 100644
> --- a/arch/x86/kernel/tlb_64.c
> +++ b/arch/x86/kernel/tlb_64.c
> @@ -183,6 +183,11 @@ void native_flush_tlb_others(const cpumask_t *cp=
umaskp, struct mm_struct *mm,
>  	cpus_or(f->flush_cpumask, cpumask, f->flush_cpumask);
> =20
>  	/*
> +	 * Make the above memory operations globally visible before
> +	 * sending the IPI.
> +	 */
> +	smp_mb();
> +	/*
>  	 * We have to send the IPI only to
>  	 * CPUs affected.
>  	 */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
			Gleb.
