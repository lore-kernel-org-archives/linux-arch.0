From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] ARM devel (pt 1) updates
Date: Sun, 28 Feb 2010 19:49:40 +0100
Message-ID: <10f740e81002281049g3f56ec78v28dfff1a9ab85102@mail.gmail.com>
References: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36750 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935375Ab0B1Stn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 13:49:43 -0500
Received: by wya21 with SMTP id 21so945833wya.19
        for <linux-arch@vger.kernel.org>; Sun, 28 Feb 2010 10:49:41 -0800 (PST)
In-Reply-To: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Sun, Feb 28, 2010 at 19:04, Russell King <rmk@arm.linux.org.uk> wrot=
e:
> Linus, Andrew,
>
> Please incorporate the latest ARM (for-linus branch) changes, which c=
an be found at:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0master.kernel.org:/home/rmk/linux-2.6-arm.=
git for-linus

Any specific reason this tree is not stored in
/pub/scm/linux/kernel/git/rmk/, so
mere mortals can access it?

> For linux-arch: this contains the patch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"MM: Pass a PTE pointer to update_mmu_cach=
e() rather than the PTE itself"
> which was previously sent to linux-arch for testing.

Documentation/cachetlb.txt still lacks documentation for the `pte' para=
meter.
Can you please fix that?

Thanks!

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
