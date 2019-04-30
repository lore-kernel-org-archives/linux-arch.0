Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35916 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3Cqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 22:46:49 -0400
Date: Tue, 30 Apr 2019 12:46:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/5] Allow CPU0 to be nohz full
References: <20190411033448.20842-1-npiggin@gmail.com>
        <20190425120427.GS4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425120427.GS4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <1556592099.38esq4uhhz.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190430024640.qWgAdNXYKwDtv4D-Gv5ZbbRvDAWsyyFefcw4xVBCI-A@z>

Peter Zijlstra's on April 25, 2019 10:04 pm:
> On Thu, Apr 11, 2019 at 01:34:43PM +1000, Nicholas Piggin wrote:
>> Since last time, I added a compile time option to opt-out of this
>> if the platform does not support suspend on non-zero, and tried to
>> improve legibility of changelogs and explain the justification
>> better.
>>=20
>> I have been testing this on powerpc/pseries and it seems to work
>> fine (the firmware call to suspend can be called on any CPU and
>> resumes where it left off), but not included here because the
>> code has some bitrot unrelated to this series which I hacked to
>> fix. I will discuss it and either send an acked patch to go with
>> this series if it is small, or fix it in powerpc tree.
>>=20
>=20
> Rafael, Frederic, any comments?
>=20

Sorry to ping again, I guess people are probably busy after vacation.
Any chance we could get this in next merge window? Peter are you okay
with the config option as it is, then we can look at adapting it to
what x86 needs as a follow up (e.g., allow nohz CPU0 for
cpu0_hotpluggable case)?

Thanks,
Nick

=
