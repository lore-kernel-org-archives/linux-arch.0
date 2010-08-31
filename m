From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Tue, 31 Aug 2010 09:36:16 +0200
Message-ID: <AANLkTikJ5pio3WYmZFAyWpD32hssZoDxX7XSTXN_qV09@mail.gmail.com>
References: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
	<20100827020038.27277.27239.stgit@warthog.procyon.org.uk>
	<4C7B59E1.6010904@snapgear.com>
	<26799.1283201411@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57068 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab0HaHgR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 Aug 2010 03:36:17 -0400
In-Reply-To: <26799.1283201411@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 30, 2010 at 22:50, David Howells <dhowells@redhat.com> wrot=
e:
> Greg Ungerer <gerg@snapgear.com> wrote:
>
>> I have no problem with the changes as such. But I would rather
>> not have separate mm and no headers if we can avoid it.
>
> Well, I can roll the headers into one, but then it'll be much more #i=
fdef'd if
> you're okay with that. =C2=A0The IRQ handling seems sufficiently diff=
erent to
> warrant that.

Indeed, m68k doesn't use generic hardirqs yet, m68knommu does.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
