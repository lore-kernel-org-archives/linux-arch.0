From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Mon, 10 Dec 2018 23:46:21 +0000
Message-ID: <20181210234620.rcmapky2aj7eb2wh@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
Content-Language: en-US
Content-ID: <5FAF10F29AFEAA4094E3BA4773787464@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Firoz Khan <firoz.khan@linaro.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Maciej,

On Mon, Dec 10, 2018 at 11:32:46PM +0000, Maciej W. Rozycki wrote:
> On Mon, 10 Dec 2018, Paul Burton wrote:
>=20
> > And I realise that undoing that but keeping n64 in our own filenames &
> > macros is another type of inconsistency, but something imperfect is
> > unavoidable at this point given that the engineers way back when decide=
d
> > to use "ABI64" for n64.
>=20
>  My feeling has been n32 was invented at SGI as an afterthought, hence th=
e=20
> choice of having ABI32 or ABI64 defined for the 32-bit (now o32) and the=
=20
> 64-bit (now n64) ABI respectively was reasonable.

I'd agree if _MIPS_SIM were defined as _ABI32 for o32, but:

  $ mips-linux-gcc -mabi=3D32 -dM -E - </dev/null | grep ABIO32
  #define _ABIO32 1
  #define _MIPS_SIM _ABIO32

...so _MIPS_SIM is:

  _ABIO32 for o32
  _ABIN32 for n32
  _ABI64 for n64

That doesn't seem very consistent to me, and means that there inevitably
has to be some ugliness once there are multiple 64-bit ABIs.

To me it feels like the result of someone thinking "one 64-bit MIPS ABI
ought to be enough for anybody". I'm undecided whether that person was
shortsighted or a genius whose vision was simply incomprehensible to
those of us that followed.

Thanks,
    Paul
