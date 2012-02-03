From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/15] Make %pR could handle bus resource with domain
Date: Fri, 3 Feb 2012 08:26:37 -0800
Message-ID: <CAErSpo6sdsV_ZEkfLq-tGxY4GvyWSz99h31XqS62RjFvthvJhw@mail.gmail.com>
References: <1328136242-17725-1-git-send-email-yinghai@kernel.org> <1328136242-17725-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1328136242-17725-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 1, 2012 at 2:43 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> So could use %pR for busn_res with domain nr in start/end
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> =A0lib/vsprintf.c | =A0 28 ++++++++++++++++++++++++----
> =A01 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 8e75003..b34eeea 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -451,6 +451,12 @@ char *resource_string(char *buf, char *end, stru=
ct resource *res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.precision =3D -1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D SPECIAL | SMALL | ZEROPAD,
> =A0 =A0 =A0 =A0};
> + =A0 =A0 =A0 static const struct printf_spec domain_spec =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =3D 16,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .field_width =3D 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .precision =3D -1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D SMALL | ZEROPAD,
> + =A0 =A0 =A0 };
> =A0 =A0 =A0 =A0static const struct printf_spec bus_spec =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.base =3D 16,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.field_width =3D 2,
> @@ -507,11 +513,25 @@ char *resource_string(char *buf, char *end, str=
uct resource *res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0specp =3D &mem_spec;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0decode =3D 0;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 p =3D number(p, pend, res->start, *specp);
> - =A0 =A0 =A0 if (res->start !=3D res->end) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D '-';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->end, *specp)=
;
> +
> + =A0 =A0 =A0 if (res->flags & IORESOURCE_BUS && res->end >> 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->start >> 8, =
domain_spec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D ':';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->start & 0xff=
, *specp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res->start !=3D res->end) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D '-';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, r=
es->end >> 8, domain_spec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D ':';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, r=
es->end & 0xff, *specp);

The "<< 8", ">>8", and "& 0xff" patterns are used frequently in these
patches.  I think it's worth adding macros or inline functions to make
it clear that all these places are connected.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->start, *spec=
p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res->start !=3D res->end) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D '-';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, r=
es->end, *specp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0if (decode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (res->flags & IORESOURCE_MEM_64)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D string(p, pend, =
" 64bit", str_spec);
> --
> 1.7.7
>
