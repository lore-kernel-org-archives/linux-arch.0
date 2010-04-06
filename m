From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] X86: Optimise fls(), ffs() and fls64()
Date: Tue, 6 Apr 2010 07:40:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004060732490.3487@i5.linux-foundation.org>
References: <20100326144241.8583.95617.stgit@warthog.procyon.org.uk> <alpine.LFD.2.00.1003261005490.3721@i5.linux-foundation.org> <20100326173730.GA27489@pendragon.3leafnetworks.com> <alpine.LFD.2.00.1003261038160.3721@i5.linux-foundation.org>
 <20100406135732.GC24003@shareable.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60757 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754497Ab0DFOob (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 10:44:31 -0400
In-Reply-To: <20100406135732.GC24003@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Scott Lurndal <scott.lurndal@3leafsystems.com>, David Howells <dhowells@redhat.com>, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Tue, 6 Apr 2010, Jamie Lokier wrote:
>=20
> On the same subject of relying on undocumented features:
>=20
>   /* If SMP and !X86_PPRO_FENCE. */
>   #define smp_rmb()      barrier()
>=20
> I've seen documentation, links posted to lkml ages ago, which implies
> this is fine on 64-bit for both Intel and AMD.
>=20
> But it appears to be relying on undocumented behaviour on 32-bit...

That memory ordering whitepaper is very much supposed to cover all the=20
32-bit CPU's too. The people involved were convinced that neither AMD n=
or=20
Intel had ever produced anything that would do anything that broke the=20
rules.=20

In fact, at least the Intel "memory ordering whitepaper" doesn't even=20
exist any more. Go to intel.com and search, and you'll find:

  "Intel=AE 64 Architecture Memory Ordering White Paper

   This document has been merged into Volume 3A of Intel 64 and IA-32=20
   Architectures Software Developers Manual."

which makes it pretty clear that it's not a 64-bit vs 32-bit issue.

> Are you sure it is ok?  Has anyone from Intel/AMD ever confirmed it i=
s
> ok?  Has it been tested?  Clones?

No clones need apply - nobody ever did very aggressive memory re-orderi=
ng,=20
and clones generally never did SMP either.

There is a VIA chip (I think) that had some relaxed cache mode, but tha=
t=20
needed a cr4 bit enable or similar, and since it wasn't SMP it only=20
mattered for DMA (and possibly nontemporal stores).

Anyway, it all boils down to: yes, we can depend on the memory ordering=
=2E

		Linus
