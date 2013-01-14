From: =?ISO-8859-15?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: arm64: Request to add error code
Date: Tue, 15 Jan 2013 00:34:44 +0100
Message-ID: <50F49614.3040403@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab3ANXer (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jan 2013 18:34:47 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Hi,
i'm new to the list (my first kernel mailing list).
I'd like to request to add a way to distinguish a read from a write pag=
efault in userspace on arm64(aarch64).
(That's e.g. in a SIGSEGV handler attached with sigaction and SA_SIGINF=
O)
On arm you can use the bit at 0x800 in uc_mcontext.error_code to know w=
hich kind it is, but on arm64 i can't find a way.
(On most other popular architectures you can get that information, too)
I'd suggest to add a flag to siginfo.si_errno, or to make the esr avail=
able to the SIGSEGV handler.
Any hints or suggestions?

--=20

Best Regards, Andr=E9 Hentschel
