From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Mon, 24 Jun 2019 11:20:29 +1000
Message-ID: <20190624112029.4f42a8cd@canb.auug.org.au>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <20190624075834.2491a61a@canb.auug.org.au>
 <20190624002430.GN2226@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3153319181193121366=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190624002430.GN2226@sasha-vm>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Huw Davies <huw@codeweavers.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-mips@vger.kernel.org" <linux-mips@v>
List-Id: linux-arch.vger.kernel.org

--===============3153319181193121366==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UW6IjEE3Jj_YtxhGwam1e.t"; protocol="application/pgp-signature"

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Sun, 23 Jun 2019 20:24:30 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> Pushed now. For some reason the airport wifi was blocking ssh :/

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QJV0ACgkQAVBC80lX
0GwUBQf/e/6tJWyAWMaopYMBDqN2qz4oN/vHsi0Cl4cEtZikDfm20K5/e1B/rwg4
3AdDGd4MfB2z5/yvCCH0gZcA3R8U8r/OX6rpU6BHD6jewnLN813ja7GesU+lgWGE
fDznHmIHmGaN2LljjUA34WkBymJGMDsOcA30q6ZIdO48ABULY+FstQOahDrTFMde
Btm0wVAvmSOP5iIIXt64JWYPhNzGJljLoW9Y5SzpAQOIrTCzYaTIcKceQsBXmPoK
XH6Ypn5GZCfCNZD/9reOW8IG8CNsSN+7OBdtFFC9W7/OGZdAmMz9n6eX+a/9WS3x
VqP7o7p8NE5G2ug+cDsnFn1aIkDb6g==
=/UhR
-----END PGP SIGNATURE-----

--Sig_/UW6IjEE3Jj_YtxhGwam1e.t--


--===============3153319181193121366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3153319181193121366==--
