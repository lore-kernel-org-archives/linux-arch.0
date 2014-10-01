From: =?gbk?B?WHVldGFvIEd1YW4g?= <gxt@pku.edu.cn>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_Re:_[PATCH]_unicore32:_Remove_u?=
 =?utf-8?Q?nneeded_Kconfig_entry_NO=5FIOPORT=5FMAP?=
Date: Wed, 1 Oct 2014 22:38:59 +0800 (CST)
Message-ID: <1890664630.35241.1412174339749.JavaMail.root@bj-mail03.pku.edu.cn>
References: <1411981207.6334.6.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411981207.6334.6.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


----- Paul Bolle <pebolle@tiscali.nl> =E5=86=99=E9=81=93=EF=BC=9A
> On Sun, 2014-09-28 at 09:49 +0800, Xuetao Guan wrote:
> > Sorry for late reply.
>=20
> You replied within four days. That's rather quick, actually.
>=20
> > I checked this config, and it's only used for HAS_IOPORT_MAP in lib=
/Kconfig
> > Sure, removing it means no different for .config file.
> > I think a better way is reserving it
>=20
> I'm not sure I get what you're saying here: what do mean with "reserv=
ing
> it"?

I mean, it's better to keep the code unchanged.

>=20
> > or moving it into arch/Kconfig
>=20
> Without a (treewide) patch I find it hard to say whether that's worth
> the trouble. But even if that move would be done, wouldn't it include
> dropping this entry from arch/unicore32 anyway?

IMHO, this config could be removed from kernel code.

>=20
>=20
> Paul Bolle
>=20
