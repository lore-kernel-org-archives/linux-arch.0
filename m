From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Tue, 21 Jul 2020 21:20:09 +1000
Message-ID: <1595329799.y24rka8cv4.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
        <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
        <20200709083113.GI597537@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgGULUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:20:18 -0400
In-Reply-To: <20200709083113.GI597537@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>

Excerpts from Peter Zijlstra's message of July 9, 2020 6:31 pm:
> On Wed, Jul 08, 2020 at 07:54:34PM -0400, Waiman Long wrote:
>> On 7/8/20 4:41 AM, Peter Zijlstra wrote:
>> > On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> > > Yes, powerpc could certainly get more performance out of the slow
>> > > paths, and then there are a few parameters to tune.
>> > Can you clarify? The slow path is already in use on ARM64 which is wea=
k,
>> > so I doubt there's superfluous serialization present. And Will spend a
>> > fair amount of time on making that thing guarantee forward progressm, =
so
>> > there just isn't too much room to play.
>> >=20
>> > > We don't have a good alternate patching for function calls yet, but
>> > > that would be something to do for native vs pv.
>> > Going by your jump_label implementation, support for static_call shoul=
d
>> > be fairly straight forward too, no?
>> >=20
>> >    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
>> >=20
>> Speaking of static_call, I am also looking forward to it. Do you have an
>> idea when that will be merged?
>=20
> 0day had one crash on the last round, I think Steve send a fix for that
> last night and I'll go look at it.
>=20
> That said, the last posting got 0 feedback, so either everybody is
> really happy with it, or not interested. So let us know in the thread,
> with some review feedback.
>=20
> Once I get through enough of the inbox to actually find the fix and test
> it, I'll also update the thread, and maybe threaten to merge it if
> everybody stays silent :-)

I'd like to use it in powerpc. We have code now for example that patches=20
a branch immediately at the top of memcpy which branches to a different=20
version of the function. pv queued spinlock selection obviously, and
there's a bunch of platform ops struct things that get filled in at boot=20
time, etc.

So +1 here if you can get them through. I'm not 100% sure we can do
it with existing toolchain and no ugly hacks, but there's no way to
structure things that can get around that AFAIKS. We'd eventually
use it though, I'd say.

Thanks,
Nick
