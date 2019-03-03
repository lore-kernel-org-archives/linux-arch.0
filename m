Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfCCDeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Mar 2019 22:34:44 -0500
Date: Sun, 03 Mar 2019 13:34:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
In-Reply-To: <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <1551583190.duzqnmfnvg.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303033436.AiKjR1T5iTGkrUgdpqhFFDOG4vN2LRfubO4SreU4sos@z>

Linus Torvalds's on March 3, 2019 12:18 pm:
> On Sat, Mar 2, 2019 at 5:43 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Is there a reason to call this "mmiowb"? We already have wmb that
>> orders cacheable stores vs mmio stores don't we?
>=20
> Sadly no it doesn't. Not on ia64, and people tried to make that the
> new rule because of the platform breakage on what some people thought
> would be a major platform.

Let me try this again, because I was babbling a train of thought=20
continuing from my past mails on the subject.

  Kill mmiowb with fire.

It was added for a niche platform that hasn't been produced for 10
years for a CPU ISA that is no longer being developed. Let's make mb/wmb
great again (aka actually possible for normal people to understand).

If something comes along again that reorders mmios from different CPUs=20
in the IO controller like the Altix did, they implement wmb the slow and=20
correct way. They can add a new faster primitive for the few devices=20
they care about in the couple of perf critical places that matter.

It doesn't have to be done all at once with this series, obviously this=20
is a big improvement on its own. But why perpetuate the nomenclature
and concept for new code added now?=20

Thanks,
Nick

=
