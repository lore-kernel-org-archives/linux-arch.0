From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Testing of function/data-sections on linux-2.6.35-rc4
Date: Sun, 18 Jul 2010 20:24:53 +0200
Message-ID: <AANLkTin-9VsTJxGclRUrJIizn9aDZ6pjxmByBCWB0Hqr@mail.gmail.com>
References: <201007181703.17022.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <201007181703.17022.vda.linux@googlemail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.cz>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 18, 2010 at 17:03, Denys Vlasenko <vda.linux@googlemail.com=
> wrote:
> I am sending this email from the machine which runs the kernel
> built with -ffunction-sections -fdata-sections --gc-sections.

(sorry for the previous HTML-email)

=46or the record, what are the metrics of this kernel vs. the standard =
one?

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
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
