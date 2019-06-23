From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Mon, 24 Jun 2019 07:58:34 +1000
Message-ID: <20190624075834.2491a61a@canb.auug.org.au>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7388630775926265412=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190623190929.GL2226@sasha-vm>
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

--===============7388630775926265412==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CR.if9_1Fi5MEdkDk1BLyhb"; protocol="application/pgp-signature"

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Sun, 23 Jun 2019 15:09:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> Appologies about this. I ended up with way more travel than I would have
> liked (writing this from an airport). I've reset our hyperv-next branch
> to remove these 3 commits until we figure this out.

But not pushed out, yet?

--=20
Cheers,
Stephen Rothwell

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0P9goACgkQAVBC80lX
0GyfOQf+KDEXgXOC5E+iMk6d4D73wD02MBcwff9B0zoCSHO7wBwHMfcazt0CBgJn
kDTyqzDFLcuCIPrA89xcZybdoNMg4aIooHEbEzdjaXFpm/Fs7d+jo+KVC0CoYEw5
pqOio0r0q85NiYk6eENxVa+j+yfmvnxKcVJO5s+T2ifWbWq06fhziMUkf3ZEytHl
1n48f9Hc2L5Zp4SoYWSF27Ro4Mo0H9aUH7RPvlt1tZkHN0OdfRS3NR84FN+w+KVU
TZpFLuislCHo8QKh/5OMv1AxaWP/RX2vJael9DguO+6hZyYBglxTK6+E1IIYe9C/
h0h8OPDTSELsQJmcd9Mda8F4vKV6qA==
=/eNi
-----END PGP SIGNATURE-----

--Sig_/CR.if9_1Fi5MEdkDk1BLyhb--


--===============7388630775926265412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7388630775926265412==--
