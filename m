From: Piotr Hosowicz <piotr@hosowicz.com>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Sat, 28 Aug 2010 18:01:01 +0200
Message-ID: <4C7932BD.8040403@example.com>
References: <20100828141637.421594670@chello.nl>	 <4C7923B4.6030208@example.com> <1283008225.1975.3598.camel@laptop>	 <4C79287B.9060609@example.com> <1283009031.1975.3615.camel@laptop>
Reply-To: piotr@hosowicz.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:56695 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752717Ab0H1QCg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 12:02:36 -0400
In-Reply-To: <1283009031.1975.3615.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On 28.08.2010 17:23, Peter Zijlstra wrote:
> On Sat, 2010-08-28 at 17:17 +0200, Piotr Hosowicz wrote:
>>>     git remote add mmu_preempt git://git.kernel.org/pub/scm/linux/k=
ernel/git/peterz/linux-2.6-mmu_preempt.git
>>>     git remote update
>>>     git checkout mmu_preempt/mmu_preempt
>>>
>>> or
>>>
>>>     git checkout -b mmu_preempt origin/master
>>>     git pull git://git.kernel.org/pub/scm/linux/kernel/git/peterz/l=
inux-2.6-mmu_preempt.git mmu_preempt
>>
>> Which is better? Thanks, I'll try.
>
> Fully depends on how you manage your git tree, the first will keep
> giving you the same tree while the second will try and merge my chang=
es
> into whatever you got from Linus' tree, which keeps moving fwd and mi=
ght
> thus start failing (at which point I'll have to either rebase or
> backmerge Linus' changes).

I'll risk the second way. I almost do not manage the tree, I just copy=20
my local copy to tmp dir, then git pull from Linus, if there are change=
s=20
I build the kernel.

Regards,

Piotr Hosowicz

--=20
Z cyklu "Uroki demokracji", czyli pytania i odpowiedzi w teledurniejach=
:
- W kt=F3rym kraju znajduje si=EA Mount Everest?
- Hm, to nie Szkocja, prawda?
NP: Peter Green Splinter Group - I Can't Help Myself
NB: 2.6.36-rc2-next-20100827
