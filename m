From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/6] ASoC: mxs-saif: fix mixed use of public and
 provider clk API
Date: Thu, 17 Jul 2014 16:06:57 +0100
Message-ID: <20140717150657.GY17528@sirena.org.uk>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-3-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4610133115762055383=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1405606399-26608-3-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Viresh Kumar <viresh.linux@gmail.com>
List-Id: linux-arch.vger.kernel.org


--===============4610133115762055383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8c7vHYlrYOebzgj6"
Content-Disposition: inline


--8c7vHYlrYOebzgj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 04:13:15PM +0200, Tomeu Vizoso wrote:
> In preparation to changing the clk provider API to use struct clk_core instead
> of struct clk.

Acked-by: Mark Brown <broonie@linaro.org>

--8c7vHYlrYOebzgj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx+aOAAoJELSic+t+oim9kbYP/1XSKsTieBgyUHwsZVX4t8n8
RCddHvCUUKM1bGm4/zJcI3EcCy6vjvbt3QkgHSv6JD6ot0jyRo9mzoWEZiUz9lDn
D8JSITKut5tP1Th1bi+yla0Zm2wf56JModA9CBUT0B/BnOkqxgpTlIua5JmkWV6m
x+8e98J/rY68uX69MD2RBhCEMfx8UkHlQ3/nWpFUigsHAOogELhIV+ChFSuVq070
3qbLOzM9Hvbf8clKA0K2c1elyHlG6it+gtSk+6cQs3KH2YU23oi4Yd4b++mGxtsa
MHVca5khElB8RM06cEsacgpB6QDj5ya17QBnEwZa2Y/FT15mKNCHKCDqWHyh8YEm
K3phLMwcpdk2hoDeCt2WCSPpCQmRj2xFxG9BG6M6LEM4eHTx1HWb+Hu5uJvi2qQY
XQi5+3bECfElzmZxgQjfJ867VKHefRiX1nabOE6qdoposm5GoUiga5VpiCYuDc13
9hsCMpEpSg++Y2G6l7cDlvPDaLnIgGAQ2jLFn/Utfb6BRZtHkQ5zP9jKDecWH7C8
I7uGjfwnxn7dRlof42mrkPHstNvWGX5hQfhcggQdIeCOiDRfW/Z9u0lZFRTH5h1R
mKldh7ssgHvYFoMSsBq2tVHZmqAXHHw19OnFQBB2ZPBKJPgsiU1OF1cJQ5i3QJRM
RF2NVRXsIgDlPYLdPWZE
=S67s
-----END PGP SIGNATURE-----

--8c7vHYlrYOebzgj6--

--===============4610133115762055383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============4610133115762055383==--
