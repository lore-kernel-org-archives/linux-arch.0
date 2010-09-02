From: Piotr Hosowicz <piotr@hosowicz.com>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Thu, 02 Sep 2010 16:53:37 +0200
Message-ID: <4C7FBA71.5040609@example.com>
References: <20100828141637.421594670@chello.nl>	 <4C7923B4.6030208@example.com> <1283008225.1975.3598.camel@laptop>	 <4C79287B.9060609@example.com> <1283009031.1975.3615.camel@laptop> <4C7A56BC.6010705@example.com> <4C7D0B72.5050700@example.com>
Reply-To: piotr@hosowicz.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 26.mail-out.ovh.net ([91.121.27.225]:55779 "HELO
	26.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752197Ab0IBPCF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Sep 2010 11:02:05 -0400
In-Reply-To: <4C7D0B72.5050700@example.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: piotr@hosowicz.com
Cc: Peter Zijlstra <peterz@infradead.org>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On 31.08.2010 16:02, Piotr Hosowicz wrote:
> On 29.08.2010 14:46, Piotr Hosowicz wrote:
>> On 28.08.2010 17:23, Peter Zijlstra wrote:
>>> On Sat, 2010-08-28 at 17:17 +0200, Piotr Hosowicz wrote:
>>>>> git remote add mmu_preempt
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-mm=
u_preempt.git
>>>>>
>>>>>
>>>>> git remote update
>>>>> git checkout mmu_preempt/mmu_preempt
>>>>>
>>>>> or
>>>>>
>>>>> git checkout -b mmu_preempt origin/master
>>>>> git pull
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-mm=
u_preempt.git
>>>>>
>>>>> mmu_preempt
>>>>
>>>> Which is better? Thanks, I'll try.
>>>
>>> Fully depends on how you manage your git tree, the first will keep
>>> giving you the same tree while the second will try and merge my cha=
nges
>>> into whatever you got from Linus' tree, which keeps moving fwd and =
might
>>> thus start failing (at which point I'll have to either rebase or
>>> backmerge Linus' changes).
>>
>> I chose the second path, kernel built OK, but then I had to build NV=
idia
>> module and I started Xorg. I logged in and then the screen froze for=
 a
>> while, then Kde background went black and I had to hard reset the PC=
,
>> bezcause couldn't switch to VT. I attach my Xorg log.
>
> Now I had done it the second way you described and everything seems t=
o
> be working ok.

Still works OK and I perceive that it is better, Peter.

Do you know when Linus will be back from Brazil?

Regards,

Piotr Hosowicz

--=20
Z cyklu "Uroki demokracji", czyli pytania i odpowiedzi w teledurniejach=
:
- Ile k=F3=B3 ma tr=F3jko=B3owiec?
- Dwa.
NP: Peter Green Splinter Group - Indians
NB: 2.6.36-rc3-20100831-1507-pz+
