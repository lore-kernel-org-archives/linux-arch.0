From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/4] kbuild: Move vmlinux link out of top-level
	Makefile
Date: Sun, 29 Apr 2012 13:03:21 +0200
Message-ID: <20120429110321.GA7925@merkur.ravnborg.org>
References: <20120428205651.GA7426@merkur.ravnborg.org> <CAMuHMdXsSva4U+-dnyGYOEPGcFWaTSBwkfs_b9JNjW=gxUiQXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXsSva4U+-dnyGYOEPGcFWaTSBwkfs_b9JNjW=gxUiQXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 29, 2012 at 10:26:25AM +0200, Geert Uytterhoeven wrote:
> On Sat, Apr 28, 2012 at 22:56, Sam Ravnborg <sam@ravnborg.org> wrote:
> > anyway - so there where nothing gained by using
>=20
> ... there was ...
>=20
> > - We no logner rebuild if one of the .tmp_kallsyms
>=20
> longer
>=20
> > =A0files are deleted.
>=20
> ... is deleted
>=20
> > - rebuild if options to ld changes (Andi Kleen)
>=20
> change

Thanks for all the grammatic corrections. I will await until tonight an=
d
submit a v3 with these corrected and any other comments that may show u=
p until then.

	Sam
