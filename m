From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Sun, 29 Apr 2012 10:28:08 +0200
Message-ID: <CAMuHMdUWFFvD26YyVYyyYAAacjwNhZ-pmHe6ap0raPo1jGRB9Q@mail.gmail.com>
References: <20120428205651.GA7426@merkur.ravnborg.org>
	<20120428205919.GC7442@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20120428205919.GC7442@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Apr 28, 2012 at 22:59, Sam Ravnborg <sam@ravnborg.org> wrote:
> Move the final link of vmlinux to a script to improve
> readability and maintainability of the code.
> The Makefil fragments used to link vmlinux has over the

Makefile

> years seen far too much changes and the logic was very

=2E.. too many ...

> hard to follow.

> "um" has special link requirments - and the
> only was to handle this was to hard-code the linking

only way ...

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
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
