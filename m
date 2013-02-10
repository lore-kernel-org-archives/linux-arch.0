From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 0/6] ARM: mm: HugeTLB + THP support.
Date: Sun, 10 Feb 2013 22:45:59 +0200
Message-ID: <CANOLnONh3rtqLXZ7LrEW9ML-Dzpr0=xmkeqnTVVzt3iq2sNyhg@mail.gmail.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43667 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681Ab3BJUqA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Feb 2013 15:46:00 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so5556563obb.9
        for <linux-arch@vger.kernel.org>; Sun, 10 Feb 2013 12:45:59 -0800 (PST)
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com

On Fri, Feb 8, 2013 at 5:01 PM, Steve Capper <steve.capper@arm.com> wro=
te:
> Hello,
> The following patches bring both HugeTLB support and Transparent
> HugePage (THP) support to ARM.
>
> These are not intended for 3.9.

I've tested this on 3.2 with this series and dependencies (LPAE and
some others) backported because I currently only have full board
support on 3.2. This was done on OMAP3/CortexA8 pandora board running
PSX emulator that renders graphics to 16bpp 1024x512 framebuffer
(sometimes 2048x1024 in "enhanced" mode). Here are some average frames
per second counter readings without huge pages and with them:

(not showing games as they are irrelevant here)
no hugetlb / hugetlb
game1: ~52 / 57
game2: ~67 / 77
game3: 21 / 26
game4: 22 / 25

As it can be seen here huge pages are very useful for this kind of
load, so I'm really looking forward for this to get merged.

=46WIW:
Tested-by: Grazvydas Ignotas <notasas@gmail.com>


--=20
Gra=C5=BEvydas
