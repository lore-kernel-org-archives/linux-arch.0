From: =?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?= <nerv@dawncrow.de>
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
Date: Tue, 05 May 2015 19:19:24 +0200
Message-ID: <5548FB9C.4090208@dawncrow.de>
References: <55464BB2.7030401@dawncrow.de> <20150505105111.GB1550@arm.com> <5548F965.9070302@dawncrow.de> <20150505171558.GO1550@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505171558.GO1550@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>, Catalin Marinas <Catalin.Marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

Am 05.05.2015 um 19:15 schrieb Will Deacon:
> On Tue, May 05, 2015 at 06:09:57PM +0100, Andr=C3=A9 Hentschel wrote:
>> Am 05.05.2015 um 12:51 schrieb Will Deacon:
>>> On Sun, May 03, 2015 at 05:24:18PM +0100, Andr=C3=A9 Hentschel wrot=
e:
>>>> From: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>>>>
>>>> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user wri=
teable TLS
>>>> register on ARM is preserved per thread.
>>>>
>>>> This patch does it analogous to the ARM patch, but for compat mode=
 on ARM64.
>>>>
>>>> Signed-off-by: Andr=C3=A9 Hentschel <nerv@dawncrow.de>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Jonathan Austin <jonathan.austin@arm.com>=20
>>>>
>>>> ---
>>>> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f4038136=
41efa74a031)
>>>
>>> Curious, but why do you need this? iirc, we added this for arch/arm=
/ because
>>> of some windows rt (?) emulation in wine. Is that still the case he=
re and is
>>> anybody actually using that?
>>
>> Yes, Windows ARM binaries are the well known use case, but also the =
compat
>> mode should do what the arm kernel is doing I=E2=80=99d think and th=
e code wasn't
>> adjusted yet.
>=20
> Sure, I was just curious.

OK :)
So what about the patch?

>> What i'm curious about is why the main TLS register on arm64 is the =
user
>> writeable, I'm not an security expert but this looks odd. I could ea=
sily
>> provoke a crash by writing to it...
>=20
> You've probably got the wrong TLS. Allowing a program to clobber it's=
 own
> thread-local storage is no worse than allowing it to write to its gen=
eral
> purpose registers, pc, etc.
>=20
> I'm assuming the crash you saw was just a userspace crash, rather tha=
n
> the kernel?
>=20

True, but the system became horribly instable, files were overwritten b=
y others, very strange. It was in a remote KVM VM on bare metal aarch64=
=2E..
I don't dare to try it again because it causes others some trouble, but=
 if someone wants to try it out:
https://github.com/AndreRH/tpidrurw-test
