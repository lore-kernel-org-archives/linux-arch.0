From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove
	single ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 18:10:48 +0100
Message-ID: <20090218171048.GA12299@elte.hu>
References: <20090217192810.GA4980@redhat.com> <20090217213256.GJ6761@linux.vnet.ibm.com> <20090217214518.GA13189@redhat.com> <20090217223910.GM6761@linux.vnet.ibm.com> <20090218135212.GB23125@wotan.suse.de> <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain> <20090218162116.GC29863@elte.hu> <alpine.LFD.2.00.0902180828430.21686@localhost.localdomain> <20090218165808.GA9120@elte.hu> <20090218170517.GA9769@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:56380 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbZBRRLX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Feb 2009 12:11:23 -0500
Content-Disposition: inline
In-Reply-To: <20090218170517.GA9769@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Yinghai Lu <yinghai@kernel.org>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


ok, it's documented:

   Intel=C2=AE 64 and IA-32 Architectures
   Software Developer=E2=80=99s Manual
                           Volume 3A:
       System Programming Guide, Part 1

 9.5.3        MSR Access in x2APIC Mode

 To allow for efficient access to the APIC registers in x2APIC=20
 mode, the serializing semantics of WRMSR are relaxed when=20
 writing to the APIC registers. Thus, system software should not=20
 use =E2=80=9CWRMSR to APIC registers in x2APIC mode=E2=80=9D as a seri=
alizing=20
 instruction. Read and write accesses to the APIC registers will=20
 occur in program order. A WRMSR to an APIC register may=20
 complete before all preceding stores are globally visible;=20
 software can prevent this by inserting a serializing=20
 instruction or MFENCE before the WRMSR.

	Ingo
