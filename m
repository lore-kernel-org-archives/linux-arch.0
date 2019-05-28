From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
Date: Tue, 28 May 2019 19:01:32 +0200
Message-ID: <20190528190132.Horde.a454OBLbW8Q4Xvx6vYRfSA1@messagerie.si.c-s.fr>
References: <20190523112116.19233-1-vincenzo.frascino@arm.com>
 <20190523112116.19233-4-vincenzo.frascino@arm.com>
 <87lfyrp0d2.fsf@concordia.ellerman.id.au>
 <afb7395f-43e9-c304-2db2-349e6727b687@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <afb7395f-43e9-c304-2db2-349e6727b687@arm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
List-Id: linux-arch.vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> a =C3=A9crit=C2=A0:

> Hi Michael,
>
> thank you for your reply.
>
> On 28/05/2019 07:19, Michael Ellerman wrote:
>> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>>
>>> The current version of the multiarch vDSO selftest verifies only
>>> gettimeofday.
>>>
>>> Extend the vDSO selftest to clock_getres, to verify that the
>>> syscall and the vDSO library function return the same information.
>>>
>>> The extension has been used to verify the hrtimer_resoltion fix.
>>
>> This is passing for me even without patch 1 applied, shouldn't it fail
>> without the fix? What am I missing?
>>
>
> This is correct, because during the refactoring process I missed an "n" :=
)
>
> if=C2=B7((x.tv_sec=C2=B7!=3D=C2=B7y.tv_sec)=C2=B7||=C2=B7(x.tv_sec=C2=B7!=
=3D=C2=B7y.tv_sec))
>
> Should be:
>
> if=C2=B7((x.tv_sec=C2=B7!=3D=C2=B7y.tv_sec)=C2=B7||=C2=B7(x.tv_nsec=C2=B7=
!=3D=C2=B7y.tv_nsec))

Maybe you'd better use timercmp() from sys/time.h

Christophe

>
> My mistake, I am going to fix the test and re-post v5 of this set.
>
> Without my patch if you pass "highres=3Doff" to the kernel (as a command =
line
> parameter) it leads to a broken implementation of clock_getres since=20=
=20
>=20the value
> of CLOCK_REALTIME_RES does not change at runtime.
>
> Expected result (with highres=3Doff):
>
> # uname -r
> 5.2.0-rc2
> # ./vdso_clock_getres
> clock_id: CLOCK_REALTIME [FAIL]
> clock_id: CLOCK_BOOTTIME [PASS]
> clock_id: CLOCK_TAI [PASS]
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> clock_id: CLOCK_MONOTONIC [FAIL]
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>
> The reason of this behavior is that the only clocks supported by getres o=
n
> powerpc are CLOCK_REALTIME and CLOCK_MONOTONIC, the rest on the clocks us=
e
> always syscalls.
>
>> # uname -r
>> 5.2.0-rc2-gcc-8.2.0
>>
>> # ./vdso_clock_getres
>> clock_id: CLOCK_REALTIME [PASS]
>> clock_id: CLOCK_BOOTTIME [PASS]
>> clock_id: CLOCK_TAI [PASS]
>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>> clock_id: CLOCK_MONOTONIC [PASS]
>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>
>> cheers
>>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> ---
>>>
>>> Note: This patch is independent from the others in this series, hence i=
t
>>> can be merged singularly by the kselftest maintainers.
>>>
>>>  tools/testing/selftests/vDSO/Makefile         |   2 +
>>>  .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>>>  2 files changed, 126 insertions(+)
>>>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
>
> --
> Regards,
> Vincenzo
