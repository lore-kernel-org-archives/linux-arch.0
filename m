From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: arm64: Request to add error code
Date: Tue, 15 Jan 2013 10:47:25 +0000
Message-ID: <CAHkRjk459Evdt-PQB+ZF_q3Ui58G4t3ApiKDb4RDPaBF320iKA@mail.gmail.com>
References: <50F49614.3040403@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35957 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab3AOKrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2013 05:47:46 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so3182457qcq.28
        for <linux-arch@vger.kernel.org>; Tue, 15 Jan 2013 02:47:45 -0800 (PST)
In-Reply-To: <50F49614.3040403@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-1?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Cc: linux-arch@vger.kernel.org

Hi Andr=E9,

On 14 January 2013 23:34, Andr=E9 Hentschel <nerv@dawncrow.de> wrote:
> i'm new to the list (my first kernel mailing list).
> I'd like to request to add a way to distinguish a read from a write p=
agefault in userspace on arm64(aarch64).
> (That's e.g. in a SIGSEGV handler attached with sigaction and SA_SIGI=
NFO)
> On arm you can use the bit at 0x800 in uc_mcontext.error_code to know=
 which kind it is, but on arm64 i can't find a way.
> (On most other popular architectures you can get that information, to=
o)
> I'd suggest to add a flag to siginfo.si_errno, or to make the esr ava=
ilable to the SIGSEGV handler.

The problem with exposing ESR directly to user is that it depends on
the MMU configuration (e.g. on Cortex-A15 (32-bit) you have different
formats based on whether you have LPAE enabled or not, though the
'write' bit happens to be in the same position).

siginfo for SIGSEGV gives the fault address and type information but,
as you noticed, doesn't say whether it's a read or write. What do you
need this information for?

--=20
Catalin
