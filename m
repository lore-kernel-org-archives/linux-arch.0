From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
Date: Fri, 1 Feb 2019 16:20:53 -0500
Message-ID: <6D5F7272-5E25-49C8-BAD4-D0D402068BA0@oracle.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131095638.GA31534@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org


> On Jan 31, 2019, at 4:56 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Jan 30, 2019 at 10:01:32PM -0500, Alex Kogan wrote:
>> Lock throughput can be increased by handing a lock to a waiter on the
>> same NUMA socket as the lock holder, provided care is taken to avoid
>> starvation of waiters on other NUMA sockets. This patch introduces =
CNA
>> (compact NUMA-aware lock) as the slow path for qspinlock.
>=20
> Since you use NUMA, use the term node, not socket. The two are not
> strictly related.
Got it, thanks.

>=20
>> CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads =
are
>> organized in two queues, a main queue for threads running on the same
>> socket as the current lock holder, and a secondary queue for threads
>> running on other sockets. Threads record the ID of the socket on =
which
>> they are running in their queue nodes. At the unlock time, the lock
>> holder scans the main queue looking for a thread running on the same
>> socket. If found (call it thread T), all threads in the main queue
>> between the current lock holder and T are moved to the end of the
>> secondary queue, and the lock is passed to T. If such T is not found, =
the
>> lock is passed to the first node in the secondary queue. Finally, if =
the
>> secondary queue is empty, the lock is passed to the next thread in =
the
>> main queue.
>>=20
>> Full details are available at =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__arxiv.org_abs_1810.=
05600&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3=
F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3D7sFZrsdpLJxLRHIFWN_sE6zgKy20Ti8=
lOoepiEyipAo&s=3D5VRAQVjw0B1SCjvBLzzwxkHQ6TZ3FIl_tGDfvn3FXvo&e=3D.
>=20
> Full details really should also be in the Changelog. You can skip much
> of the academic bla-bla, but the Changelog should be self contained.
>=20
>> We have done some performance evaluation with the locktorture module
>> as well as with several benchmarks from the will-it-scale repo.
>> The following locktorture results are from an Oracle X5-4 server
>> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
>> cores each). Each number represents an average (over 5 runs) of the
>> total number of ops (x10^7) reported at the end of each run. The =
stock
>> kernel is v4.20.0-rc4+ compiled in the default configuration.
>>=20
>> #thr  stock  patched speedup (patched/stock)
>>  1   2.710   2.715  1.002
>>  2   3.108   3.001  0.966
>>  4   4.194   3.919  0.934
>=20
> So low contention is actually worse. Funnily low contention is the
> majority of our locks and is _really_ important.
This can be most certainly engineered out, e.g., by caching the node ID =
on which a task is running.
We will look into that.

>=20
>>  8   5.309   6.894  1.299
>> 16   6.722   9.094  1.353
>> 32   7.314   9.885  1.352
>> 36   7.562   9.855  1.303
>> 72   6.696  10.358  1.547
>> 108   6.364  10.181  1.600
>> 142   6.179  10.178  1.647
>>=20
>> When the kernel is compiled with lockstat enabled, CNA=20
>=20
> I'll ignore that, lockstat/lockdep enabled runs are not what one would
> call performance relevant.
Please, note that only one set of results has lockstat enabled.
The rest of the results (will-it-scale included) do not have it.

Regards,
=E2=80=94 Alex
