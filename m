From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 15:27:24 +0100
Message-ID: <4206493.gjdgtfndZ8@wuerfel>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com> <1667268.iM977TQnEK@wuerfel> <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:57930 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbcASO1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2016 09:27:35 -0500
In-Reply-To: <20160119142213.GA12679@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org

On Tuesday 19 January 2016 14:22:13 James Hogan wrote:
> On Tue, Jan 19, 2016 at 03:09:14PM +0100, Arnd Bergmann wrote:
> > On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> > > When a header file is removed from generic-y (often accompanied b=
y the
> > > addition of an arch specific header), the generated wrapper file =
will
> > > persist, and in some cases may still take precedence over the new=
 arch
> > > header.
> > >=20
> > > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for exten=
ded
> > > context") removed ucontext.h from generic-y in arch/mips/include/=
asm/,
> > > and added an arch/mips/include/uapi/asm/ucontext.h. The continued=
 use of
> > > the wrapper when reusing a dirty build tree resulted in build fai=
lures
> > > in arch/mips/kernel/signal.c:
> > >=20
> > > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=
=80=99:
> > > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=
=E2=80=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> > >   return &uc->uc_extcontext;
> > >             ^
> > >=20
> > > Fix by detecting and removing wrapper headers in generated header
> > > directories that do not correspond to a filename in generic-y, ge=
nhdr-y,
> > > or the newly introduced generated-y.
> >=20
> > Good idea.
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Thanks Arnd
>=20
> > Can you merge this through the mips tree, or do you need me to pick=
 it
> > up through asm-generic?
>=20
> I was envisaging the kbuild tree tbh, but I don't really mind how it
> gets merged. This patch depends on patch 1, which adds generated-y to
> x86 so we don't delete their other generated headers, but other than
> that it doesn't really have any dependencies.

Ok, the kbuild tree works fine too, and I guess the x86 tree would
also be fine if that helps avoid the dependency.

	Arnd
