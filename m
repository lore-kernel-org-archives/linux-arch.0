From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: kbuild: fixing the select problem
Date: Thu, 6 May 2010 19:25:15 +0200
Message-ID: <p2l10f740e81005061025l276d91b5mf87d2af65438539a@mail.gmail.com>
References: <1273096160.23208.35.camel@mulgrave.site>
	 <p2x10f740e81005052347x9430657fua98b8982e860bd2d@mail.gmail.com>
	 <1273151844.23208.48.camel@mulgrave.site> <28312.1273164427@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <28312.1273164427@localhost>
Sender: linux-kbuild-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, May 6, 2010 at 18:47,  <Valdis.Kletnieks@vt.edu> wrote:
> On Thu, 06 May 2010 09:17:24 EDT, James Bottomley said:
>> On Thu, 2010-05-06 at 08:47 +0200, Geert Uytterhoeven wrote:
>> > On Wed, May 5, 2010 at 23:49, James Bottomley
>> > <James.Bottomley@hansenpartnership.com> wrote:
>> > > [Sam: I know you don't maintain kbuild anymore, but since you ha=
ve the
>> > > most experience, if you could find time to comment, I'd be grate=
ful]
>> > >
>> > > The select problem is that the kbuild select directive will turn=
 a
>> > > symbol on without reference to its dependencies. =C2=A0This, in =
turn, means
>> > > that either selected symbols must select their dependencies, or =
that
>> > > people using select have to be aware of the selected symbol's de=
pendency
>> > > and build those dependencies into their symbol (leading to dupli=
cation
>> > > and the possibility of getting the dependencies out of sync). =C2=
=A0We use
>> > > select for the scsi transport classes, so we run into this probl=
em in
>> > > SCSI quite a lot.
>> > >
>> > > I think the correct fix is to make a symbol that selects another=
 symbol
>> > > automatically inherit all of the selected symbol's dependencies.
>> >
>> > What if there's a good reason the selected symbol has this depende=
ncy?
>> > E.g. it depends on a critical feature not available? Like CONFIG_H=
AS_IOMEM?
>>
>> I don't quite understand the question. =C2=A0If a selected symbol ha=
s a
>> critical dependency which is config'd to N then the build usually
>> breaks ... that's what I'm calling the select problem. =C2=A0I thoug=
ht
>> CONFIG_HAS_IOMEM was usually selected by the architecture, though. =C2=
=A0In
>> the new proposal, we wouldn't be able to generate the invalid
>> configuration in the first place.
>
> I think Geert is asking "If the arch says CONFIG_HAS_IOMEM=3Dn, but s=
ome driver
> does a 'select CONFIG_FOO' which then (under your proposal) forces th=
e
> value CONFIG_BAR=3Dy, which eventually ends up with CONFIG_HAS_IOMEM=3D=
y, what
> should the behavior be?"

Yep, that was my (bogus) question...

> (I suspect the right answer here is "one of the symbols is buggy and =
its
> 'select' should be a 'depends' instead", but somebody else better dou=
ble-check
> that conclusion - I'm hardly a Kconfig expert).

No, the CONFIG_FOO will inherit the dependency on CONFIG_HAS_IOMEM.

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
