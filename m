From: Michal Simek <monstr@monstr.eu>
Subject: Re: [RFA][PATCH 22/27] microblaze: ftrace: Remove check of obsolete
 variable function_trace_stop
Date: Fri, 18 Jul 2014 10:17:47 +0200
Message-ID: <53C8D82B.4030204@monstr.eu>
References: <20140626165221.736847419@goodmis.org>	<20140626165852.891982463@goodmis.org> <20140715175112.3e9128be@gandalf.local.home>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nogRgSMw4WqDkuUfvdiFWBL3sdoqw3iJa"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140715175112.3e9128be@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nogRgSMw4WqDkuUfvdiFWBL3sdoqw3iJa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On 07/15/2014 11:51 PM, Steven Rostedt wrote:
> Michal,
>=20
> Can you please test and ack this and patch 6 of this series. Otherwise =
I
> may have to stip it out of the series which will break the build on
> microblaze.
>=20
> You can test my branch at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git=

> rfc/remove-function-trace-stop

I have tested this full branch and there is no issue on Microblaze that's=
 why
here is:
Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal











--nogRgSMw4WqDkuUfvdiFWBL3sdoqw3iJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPI2DUACgkQykllyylKDCHVHwCdFN2HCNBBNuZkfZBaWKM7Iedl
GzAAn0sQJuhc5NLobEt7iE3qCUKl22Fa
=kG0E
-----END PGP SIGNATURE-----

--nogRgSMw4WqDkuUfvdiFWBL3sdoqw3iJa--
