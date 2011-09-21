From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 35/57] media: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 12:27:37 +0200
Message-ID: <20110921102737.GA1966@pengutronix.de>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-36-git-send-email-yong.zhang0@gmail.com>
Reply-To: MJPEG-tools user list <mjpeg-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7338837238611510894=="
Return-path: <mjpeg-users-bounces@lists.sourceforge.net>
In-Reply-To: <1316597339-29861-36-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=mjpeg-users>
List-Post: <mailto:mjpeg-users@lists.sourceforge.net>
List-Help: <mailto:mjpeg-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mjpeg-users>,
	<mailto:mjpeg-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: mjpeg-users-bounces@lists.sourceforge.net
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: Kamil Debski <k.debski@samsung.com>, David =?iso-8859-15?Q?H=E4rdeman?= <david@hardeman.nu>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Igor M. Liplianin" <liplianin@netup.ru>, linux-arch@vger.kernel.org, Mats Randgaard <mats.randgaard@cisco.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Jarod Wilson <jarod@redhat.com>, Muralidharan Karicheri <m-karicheri2@ti.com>, Istvan Varga <istvan_v@mailbox.hu>, Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org, Lucas De Marchi <lucas.demarchi@profusion.mobi>, ivtv-devel@ivtvdriver.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Nieder <jrnieder@gmail.com>, Jean Delvare <khali@linux-fr.org>, mjpeg-users@lists.sourceforge.net, tglx@linutronix.de, Andy Walls <awalls@md.metrocast.net>, Devin Heitmueller <dheitmueller@ker>
List-Id: linux-arch.vger.kernel.org


--===============7338837238611510894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2011 at 05:28:36PM +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled=
],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
>=20
> So now this flag is a NOOP and can be removed.
>=20
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Umm, I didn't ack this patch but the MTD one :) Nevermind, I had a look
here as well and it looks okay, so you can keep the ack.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk55vBkACgkQD27XaX1/VRtN+ACeJicE8N9nJ5HZeH4nJxgHFC3c
R48Ani+vdh7t8DZcOKEafS9SSY3jkaPH
=Ia6P
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============7338837238611510894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
--===============7338837238611510894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Mjpeg-users mailing list
Mjpeg-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/mjpeg-users

--===============7338837238611510894==--
