From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] ARM devel (pt 1) updates
Date: Sun, 28 Feb 2010 20:41:22 +0100
Message-ID: <10f740e81002281141u3a51f368u85830a1da20675dd@mail.gmail.com>
References: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk>
	 <10f740e81002281049g3f56ec78v28dfff1a9ab85102@mail.gmail.com>
	 <20100228190241.GA9546@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34510 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936463Ab0B1TlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 14:41:24 -0500
Received: by wya21 with SMTP id 21so961769wya.19
        for <linux-arch@vger.kernel.org>; Sun, 28 Feb 2010 11:41:22 -0800 (PST)
In-Reply-To: <20100228190241.GA9546@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Sun, Feb 28, 2010 at 20:02, Russell King <rmk@arm.linux.org.uk> wrot=
e:
> On Sun, Feb 28, 2010 at 07:49:40PM +0100, Geert Uytterhoeven wrote:
>> On Sun, Feb 28, 2010 at 19:04, Russell King <rmk@arm.linux.org.uk> w=
rote:
>> > For linux-arch: this contains the patch
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"MM: Pass a PTE pointer to update_mmu_c=
ache() rather than the PTE itself"
>> > which was previously sent to linux-arch for testing.
>>
>> Documentation/cachetlb.txt still lacks documentation for the `pte' p=
arameter.
>> Can you please fix that?
>
> Didn't I reply to your email about that? =C2=A0No response was forthc=
oming.

Yes you did; you said "I'm open to suggestions for a suitable
description for it.".
Sorry, I forgot to reply that I find that a very uncommon attitude...

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
