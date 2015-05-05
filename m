From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
Date: Tue, 05 May 2015 19:09:57 +0200
Message-ID: <5548F965.9070302@dawncrow.de>
References: <55464BB2.7030401@dawncrow.de> <20150505105111.GB1550@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150505105111.GB1550@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

Am 05.05.2015 um 12:51 schrieb Will Deacon:
> On Sun, May 03, 2015 at 05:24:18PM +0100, Andr=E9 Hentschel wrote:
>> From: Andr=E9 Hentschel <nerv@dawncrow.de>
>>
>> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user write=
able TLS
>> register on ARM is preserved per thread.
>>
>> This patch does it analogous to the ARM patch, but for compat mode o=
n ARM64.
>>
>> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jonathan Austin <jonathan.austin@arm.com>=20
>>
>> ---
>> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641=
efa74a031)
>=20
> Curious, but why do you need this? iirc, we added this for arch/arm/ =
because
> of some windows rt (?) emulation in wine. Is that still the case here=
 and is
> anybody actually using that?

Yes, Windows ARM binaries are the well known use case, but also the com=
pat mode should do
what the arm kernel is doing I=92d think and the code wasn't adjusted y=
et.

What i'm curious about is why the main TLS register on arm64 is the use=
r writeable,
I'm not an security expert but this looks odd. I could easily provoke a=
 crash by writing
to it...

CCing Catalin Marinas
