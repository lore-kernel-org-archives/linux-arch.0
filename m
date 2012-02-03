From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 01/15] Make %pR could handle bus resource with domain
Date: Fri, 3 Feb 2012 09:23:44 -0800
Message-ID: <CAE9FiQUqLwgXMOH-oAf4o-9O_cyLaRs1h8Abg+U-4iu3CRipfA@mail.gmail.com>
References: <1328136242-17725-1-git-send-email-yinghai@kernel.org>
	<1328136242-17725-2-git-send-email-yinghai@kernel.org>
	<CAErSpo6sdsV_ZEkfLq-tGxY4GvyWSz99h31XqS62RjFvthvJhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6sdsV_ZEkfLq-tGxY4GvyWSz99h31XqS62RjFvthvJhw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 3, 2012 at 8:26 AM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> On Wed, Feb 1, 2012 at 2:43 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
>> So could use %pR for busn_res with domain nr in start/end
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> =A0lib/vsprintf.c | =A0 28 ++++++++++++++++++++++++----
>> =A01 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index 8e75003..b34eeea 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -451,6 +451,12 @@ char *resource_string(char *buf, char *end, str=
uct resource *res,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.precision =3D -1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =3D SPECIAL | SMALL | ZEROPAD,
>> =A0 =A0 =A0 =A0};
>> + =A0 =A0 =A0 static const struct printf_spec domain_spec =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .base =3D 16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .field_width =3D 4,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .precision =3D -1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D SMALL | ZEROPAD,
>> + =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0static const struct printf_spec bus_spec =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.base =3D 16,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.field_width =3D 2,
>> @@ -507,11 +513,25 @@ char *resource_string(char *buf, char *end, st=
ruct resource *res,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0specp =3D &mem_spec;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0decode =3D 0;
>> =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 p =3D number(p, pend, res->start, *specp);
>> - =A0 =A0 =A0 if (res->start !=3D res->end) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D '-';
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->end, *specp=
);
>> +
>> + =A0 =A0 =A0 if (res->flags & IORESOURCE_BUS && res->end >> 8) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->start >> 8,=
 domain_spec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D ':';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, res->start & 0xf=
f, *specp);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res->start !=3D res->end) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D '-';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, =
res->end >> 8, domain_spec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *p++ =3D ':';
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D number(p, pend, =
res->end & 0xff, *specp);
>
> The "<< 8", ">>8", and "& 0xff" patterns are used frequently in these
> patches. =A0I think it's worth adding macros or inline functions to m=
ake
> it clear that all these places are connected.

ok will check if can use

busn_domain_nr(res): res->end >> 8
busn_bus_nr(res): res->end & 0xff;
busn_val(domain_nr, bus_nr)

instead.

Thanks

Yinghai
