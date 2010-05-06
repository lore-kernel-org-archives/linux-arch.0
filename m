From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: kbuild: fixing the select problem
Date: Thu, 6 May 2010 08:47:39 +0200
Message-ID: <p2x10f740e81005052347x9430657fua98b8982e860bd2d@mail.gmail.com>
References: <1273096160.23208.35.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1273096160.23208.35.camel@mulgrave.site>
Sender: linux-kbuild-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 5, 2010 at 23:49, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> [Sam: I know you don't maintain kbuild anymore, but since you have th=
e
> most experience, if you could find time to comment, I'd be grateful]
>
> The select problem is that the kbuild select directive will turn a
> symbol on without reference to its dependencies. =C2=A0This, in turn,=
 means
> that either selected symbols must select their dependencies, or that
> people using select have to be aware of the selected symbol's depende=
ncy
> and build those dependencies into their symbol (leading to duplicatio=
n
> and the possibility of getting the dependencies out of sync). =C2=A0W=
e use
> select for the scsi transport classes, so we run into this problem in
> SCSI quite a lot.
>
> I think the correct fix is to make a symbol that selects another symb=
ol
> automatically inherit all of the selected symbol's dependencies.

What if there's a good reason the selected symbol has this dependency?
E.g. it depends on a critical feature not available? Like CONFIG_HAS_IO=
MEM?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
