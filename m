From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Date: Mon, 15 Oct 2018 07:16:59 +0200
Message-ID: <4517632.a0TFakfgol@daneel.sf-tec.de>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org> <c6280818c999449646ec216984f2df9e@sf-tec.de> <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3045382.2mgNMOvJcN"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-parisc-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

--nextPart3045382.2mgNMOvJcN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Firoz Khan wrote:
> Hi Rolf,
> 
> On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Firoz Khan wrote:

> > > +prefix="$4"
> > > +offset="$5"
> > > +
> > > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > > +    echo "#ifndef ${fileguard}"
> > > +    echo "#define ${fileguard}"
> > > +    echo ""
> > > +
> > > +    nxt=0
> > > +    while read nr abi name entry compat ; do
> > > +     if [ -z "$offset" ]; then
> > > +         echo -e "#define __NR_${prefix}${name}\t$nr"
> > 
> > This mixed indentation with both tabs and spaces is a bit messy.
> 
> Is this what you suggested?
> -           echo -e "#define __NR_${prefix}${name}\t$nr"
> +           echo "#define __NR_${prefix}${name} $nr"

No, this was actually only about the script itself. Looks like your editor has 
tab-width 8 and indentation 4 or so.

Eike
--nextPart3045382.2mgNMOvJcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCW8QiywAKCRBcpIk+abn8
TkW/AJ9u7BePqjngSBek/LuUdC5oSBYJUQCgknrnxjpoIDZmHtjFwq8YzC1FGpA=
=1rfo
-----END PGP SIGNATURE-----

--nextPart3045382.2mgNMOvJcN--
