From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Date: Wed, 4 May 2011 14:17:51 +0200
Message-ID: <BANLkTi=kRLxKS417xhaWDpF4h8+VTcUQQA@mail.gmail.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 3, 2011 at 23:30, Sven Eckelmann <sven@narfation.org> wrote=
:
> Introduce an *_dec_not_zero operation. =C2=A0Make this a special case=
 of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

> =C2=A0arch/m68k/include/asm/atomic.h =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
