From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: dma-mapping commit breaks UML
Date: Thu, 30 Sep 2010 10:34:00 +0200
Message-ID: <201009301034.01157.toralf.foerster@gmx.de>
References: <201009291155.30873.toralf.foerster@gmx.de> <201009291629.39077.toralf.foerster@gmx.de> <20100930144059N.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930144059N.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


=46UJITA Tomonori wrote at 07:45:19
> On Wed, 29 Sep 2010 16:29:38 +0200
>=20
> Toralf **UNKNOWN CHARSET** <toralf.foerster@gmx.de> wrote:
> > but catched another compile error - how can I now automatically
> > git-bisect for that wrong commit w/o heavy scripting ? - Or simply
> > asking who to blame wrt this compile error ?
>=20
> Fortunately, looks like we can easily figure out the root cause of
> this (commit d6d1b650ae6acce73d55dd0246de22180303ae73), the last
> commit to arch/um/drivers/hostaudio_kern.c
>=20
> The following patch works?

YES :-)

> diff --git a/arch/um/drivers/hostaudio_kern.c
> b/arch/um/drivers/hostaudio_kern.c index 0c46e39..63c740a 100644
> --- a/arch/um/drivers/hostaudio_kern.c
> +++ b/arch/um/drivers/hostaudio_kern.c
> @@ -40,6 +40,11 @@ static char *mixer =3D HOSTAUDIO_DEV_MIXER;
>  "    This is used to specify the host mixer device to the hostaudio
> driver.\n"\ "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
>=20
> +module_param(dsp, charp, 0644);
> +MODULE_PARM_DESC(dsp, DSP_HELP);
> +module_param(mixer, charp, 0644);
> +MODULE_PARM_DESC(mixer, MIXER_HELP);
> +
>  #ifndef MODULE
>  static int set_dsp(char *name, int *add)
>  {
> @@ -56,15 +61,6 @@ static int set_mixer(char *name, int *add)
>  }
>=20
>  __uml_setup("mixer=3D", set_mixer, "mixer=3D<mixer device>\n" MIXER_=
HELP);
> -
> -#else /*MODULE*/
> -
> -module_param(dsp, charp, 0644);
> -MODULE_PARM_DESC(dsp, DSP_HELP);
> -
> -module_param(mixer, charp, 0644);
> -MODULE_PARM_DESC(mixer, MIXER_HELP);
> -
>  #endif
>=20
>  /* /dev/dsp file operations */


--=20
MfG/Kind regards
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
