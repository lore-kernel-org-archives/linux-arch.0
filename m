From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Q: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove single
 ipi fallback for smp_call_function_many())
Date: Wed, 18 Feb 2009 09:17:44 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902180915430.21686@localhost.localdomain>
References: <20090217192810.GA4980@redhat.com> <20090217213256.GJ6761@linux.vnet.ibm.com> <20090217214518.GA13189@redhat.com> <20090217223910.GM6761@linux.vnet.ibm.com> <20090218135212.GB23125@wotan.suse.de> <alpine.LFD.2.00.0902180744520.21686@localhost.localdomain>
 <20090218162116.GC29863@elte.hu> <alpine.LFD.2.00.0902180828430.21686@localhost.localdomain> <20090218165808.GA9120@elte.hu> <20090218170517.GA9769@elte.hu> <20090218171048.GA12299@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33229 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753471AbZBRRSg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Feb 2009 12:18:36 -0500
In-Reply-To: <20090218171048.GA12299@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Yinghai Lu <yinghai@kernel.org>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jens Axboe <jens.axboe@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org



On Wed, 18 Feb 2009, Ingo Molnar wrote:
>=20
> ok, it's documented:
>=20
>    Intel=C2=AE 64 and IA-32 Architectures
>    Software Developer=E2=80=99s Manual
>                            Volume 3A:
>        System Programming Guide, Part 1
>=20
>  9.5.3        MSR Access in x2APIC Mode

Well, mine says

	9.5.3 Error Handling

so I guess I need to download a newer version. After all, mine is=20
"ancient" in being a year old (the February-2008 version) and not cover=
ing=20
x2APIC at all.

			Linus
