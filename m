From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove
	single ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 18:23:49 +0100
Message-ID: <20090218172349.GA14798@elte.hu>
References: <20090217214518.GA13189@redhat.com> <20090217223910.GM6761@linux.vnet.ibm.com> <20090218135212.GB23125@wotan.suse.de> <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain> <20090218162116.GC29863@elte.hu> <alpine.LFD.2.00.0902180828430.21686@localhost.localdomain> <20090218165808.GA9120@elte.hu> <20090218170517.GA9769@elte.hu> <20090218171048.GA12299@elte.hu> <alpine.LFD.2.00.0902180915430.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:54109 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbZBRRYl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Feb 2009 12:24:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902180915430.21686@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Yinghai Lu <yinghai@kernel.org>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 18 Feb 2009, Ingo Molnar wrote:
> >=20
> > ok, it's documented:
> >=20
> >    Intel=C2=AE 64 and IA-32 Architectures
> >    Software Developer=E2=80=99s Manual
> >                            Volume 3A:
> >        System Programming Guide, Part 1
> >=20
> >  9.5.3        MSR Access in x2APIC Mode
>=20
> Well, mine says
>=20
> 	9.5.3 Error Handling
>=20
> so I guess I need to download a newer version. After all, mine=20
> is "ancient" in being a year old (the February-2008 version)=20
> and not covering x2APIC at all.

Mine is 253668.pdf, that's the freshest available:

  http://download.intel.com/design/processor/manuals/253668.pdf

	Ingo
