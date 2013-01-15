From: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: Re: arm64: Request to add error code
Date: Tue, 15 Jan 2013 20:27:38 +0100
Message-ID: <50F5ADAA.20001@dawncrow.de>
References: <50F49614.3040403@dawncrow.de> <CAHkRjk459Evdt-PQB+ZF_q3Ui58G4t3ApiKDb4RDPaBF320iKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60610 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3AOT1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2013 14:27:44 -0500
In-Reply-To: <CAHkRjk459Evdt-PQB+ZF_q3Ui58G4t3ApiKDb4RDPaBF320iKA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>

Am 15.01.2013 11:47, schrieb Catalin Marinas:
> Hi Andr=E9,
>=20
> On 14 January 2013 23:34, Andr=E9 Hentschel <nerv@dawncrow.de> wrote:
>> i'm new to the list (my first kernel mailing list).
>> I'd like to request to add a way to distinguish a read from a write =
pagefault in userspace on arm64(aarch64).
>> (That's e.g. in a SIGSEGV handler attached with sigaction and SA_SIG=
INFO)
>> On arm you can use the bit at 0x800 in uc_mcontext.error_code to kno=
w which kind it is, but on arm64 i can't find a way.
>> (On most other popular architectures you can get that information, t=
oo)
>> I'd suggest to add a flag to siginfo.si_errno, or to make the esr av=
ailable to the SIGSEGV handler.
>=20
> The problem with exposing ESR directly to user is that it depends on
> the MMU configuration (e.g. on Cortex-A15 (32-bit) you have different
> formats based on whether you have LPAE enabled or not, though the
> 'write' bit happens to be in the same position).
>=20
> siginfo for SIGSEGV gives the fault address and type information but,
> as you noticed, doesn't say whether it's a read or write. What do you
> need this information for?
>=20

Thanks for the answer and the confirmation.
I'm porting Wine to arm64, some winelib applications may rely on the in=
formation in case they handle the exception.

--=20

Best Regards, Andr=E9 Hentschel
