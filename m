From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 23:18:04 +0200
Message-ID: <10f740e80906021418i1d58f5eer940e7a8ec9fb8b9e@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	 <20090602211057.GA10800@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f216.google.com ([209.85.220.216]:43580 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZFBVSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 17:18:07 -0400
In-Reply-To: <20090602211057.GA10800@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-e

On Tue, Jun 2, 2009 at 23:10, Russell King <rmk@arm.linux.org.uk> wrote=
:
> On Tue, Jun 02, 2009 at 11:29:46AM -0600, Grant Likely wrote:
>> Embedded PowerPC and Microblaze has tackled this problem with the
>> "Flattened Device Tree" data format which is derived from the
>> OpenFirmware specifications, and there is some interest and debate (=
as
>> discussed recently on the ARM mailing list) about making flattened
>> device tree usable by ARM also (which I'm currently
>> proof-of-concepting).
>
> Note that I have to point out that ARM will probably never be in a
> situation where you can have a one kernel image boots on everything.
> That _is_ practical today (and does happen with all PXA now) with wha=
t
> we have within a very big restriction - which is that the kernel must
> be built to support PXA and not Atmel SoCs.
>
> I really don't think combining SoC support is going to be realistic,
> device tree or not. =C2=A0When we had just four machine types (RiscPC=
,
> EBSA110, EBSA285, Netwinder) I did look into this and came to the
> conclusion that it would be far too inefficient for there to be any
> win.
>
> The big problem we have is that the only commonality between differen=
t
> SoCs is that the CPU executes ARM instructions. =C2=A0Everything else=
 is
> entirely up to the SoC designer - eg location of memory, spacing of
> memory banks, type of interrupt controller, etc is all highly SoC
> specific. =C2=A0Nothing outside of the ARM CPU itself is standardized=
=2E

That sounds very similar to m68k, which does support generic kernels
(except for Sun-3, which uses a completely different MMU)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
