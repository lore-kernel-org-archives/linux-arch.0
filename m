From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Date: Tue, 10 Mar 2020 12:42:26 +0000
Message-ID: <20200310124226.GC4106@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7862888218451467479=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200309210505.GM4101@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Jones <drjones@redhat.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Sudakshina Das <su>
List-Id: linux-arch.vger.kernel.org


--===============7862888218451467479==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 09:05:05PM +0000, Mark Brown wrote:
> On Fri, Mar 06, 2020 at 10:27:29AM +0000, Catalin Marinas wrote:

> > Does this series affect uprobes in any way? I.e. can you probe a landing
> > pad?

> You can't probe a landing pad, uprobes on landing pads will be silently
> ignored so the program isn't disrupted, you just don't get the expected
> trace from those uprobes.  This isn't new with the BTI support since
> the landing pads are generally pointer auth instructions, these already
> can't be probed regardless of what's going on with this series.  It's
> already on the list to get sorted.

Sorry, I realized thanks to Amit's off-list prompting that I was testing
that I was verifying with the wrong kernel binary here (user error since
it took me a while to sort out uprobes) so this isn't quite right - you
can probe the landing pads with or without this series.

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nizEACgkQJNaLcl1U
h9CwvAf/ZRKRyzQ70X79x8NhEkUSVp2jprVe6r4y/8/g449xGTTicMDIWQKGeikg
Z2v/GrsJ7+EAW4fiTl3dz+srzmuQCLS+67Dk/PwL4G4l8eJKQlBVj8BpiAASUml6
mx3mbdZSIfcRKgz3BbzAsmW6p186TYm1Eh0MAQJhN11goYRuZjs0MNTDwZ0RuvSZ
76rUJVdjbiFhjam1Et05p4G8HDQFKU0QArmyibQtCz1kU9+7affCfVyXFj3bnXx4
qepGxIs1ld2UGb4lZ1BdlDxDpQoaQ+nVPxPRic0loZbovKlASlaSyKuRFl49jYg1
8wHzzFxXeERLY2RJGZxzvae6Fq1zzA==
=fbe8
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--


--===============7862888218451467479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7862888218451467479==--
