From: "Bird, Tim" <Tim.Bird@sony.com>
Subject: RE: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Date: Fri, 31 Jul 2020 21:57:41 +0000
Message-ID: <CY4PR13MB1175A3B5D9DE33D3A1E045A6FD4E0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200731212721.GC32670@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200731212721.GC32670@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "josh@joshtriplett.org" <josh@joshtriplett.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ksummit <ksummit-discuss@lists.linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

> -----Original Message-----
> From: josh@joshtriplett.org
>=20
> On Fri, Jul 31, 2020 at 05:00:12PM +0200, Arnd Bergmann wrote:
> > The majority of the code in the kernel deals with hardware that was mad=
e
> > a long time ago, and we are regularly discussing which of those bits ar=
e
> > still needed. In some cases (e.g. 20+ year old RISC workstation support=
),
> > there are hobbyists that take care of maintainership despite there bein=
g
> > no commercial interest. In other cases (e.g. x.25 networking) it turned
> > out that there are very long-lived products that are actively supported
> > on new kernels.
> >
> > When I removed support for eight instruction set architectures in 2018,
> > those were the ones that no longer had any users of mainline kernels,
> > and removing them allowed later cleanup of cross-architecture code that
> > would have been much harder before.
> >
> > I propose adding a Documentation file that keeps track of any notable
> > kernel feature that could be classified as "obsolete", and listing
> > e.g. following properties:
> >
> > * Kconfig symbol controlling the feature
> >
> > * How long we expect to keep it as a minimum
> >
> > * Known use cases, or other reasons this needs to stay
> >
> > * Latest kernel in which it was known to have worked
> >
> > * Contact information for known users (mailing list, personal email)
> >
> > * Other features that may depend on this
> >
> > * Possible benefits of eventually removing it
>=20
> We had this once, in the form of feature-removal-schedule.txt. It was,
> itself, removed in commit 9c0ece069b32e8e122aea71aa47181c10eb85ba7.
>=20
> I *do* think there'd be value in having policies and processes for "how
> do we carefully remove a driver/architecture/etc we think nobody cares
> about". That's separate from having an actual in-kernel list of "things
> we think we can remove".

I'm not sure the documents are the same.  I think what Arnd is proposing
is more of a "why is this thing still here?" document.  When someone does
research into who's still using a feature and why, that can be valuable inf=
ormation
to share so that future maintenance or removal decisions can be better info=
rmed.

Maybe e-mails are sufficient for this, but they'd be harder to find than so=
mething in
the kernel source. But that supposes that people would look at the file, wh=
ich=20
appears didn't happen with feature-removal-schedule.txt.

 -- Tim
