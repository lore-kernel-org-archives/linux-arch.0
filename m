From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 0/4] metag,parisc: Stack limit patches
Date: Thu, 15 May 2014 00:25:06 +0100
Message-ID: <5373FB52.5030404@imgtec.com>
References: <1400071968-21581-1-git-send-email-james.hogan@imgtec.com> <5373C28C.3040106@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FmsEtE3KekkjGM54OudD0OkHRBhhpevf7"
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5373C28C.3040106-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
Cc: "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

--FmsEtE3KekkjGM54OudD0OkHRBhhpevf7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Helge,

On 14/05/14 20:22, Helge Deller wrote:
> On 05/14/2014 02:52 PM, James Hogan wrote:
>> Patch 1 is a metag bug fix for v3.15 & stable.
>>
>> Patch 2 depends on patch 1, and makes the stack limit configurable.
>> Helge: I don't object if you want to take this patch yourself since it=

>> was originally yours, so long as it goes after patch 1 (which I'll try=

>> and get into v3.15-rc6).
>=20
> Thanks for cleaning it up!
> I'd really prefer if you could push the whole series through your tree.=

> That way you can easily ensure the correct sequence.

Okay, no problem, and I see the parisc patch is already in mainline.

> IMHO, it would be nice if all four patches would still go into 3.15, es=
p.
> since it affects our platforms (parisc & metag) only.

Right. That doesn't sound unreasonable since patch 2 restores default
80MB stacks for parisc, patch 3 may prevent confusing userland, and
patch 4 is just an obvious cleanup as a result of earlier patches.

Cheers
James

>=20
> Helge
>=20
>>
>> Patch 3 depends on patch 1, and removes the RLIMIT_STACK default value=

>> for metag. I'll take this through metag tree for v3.16.
>>
>> Patch 4 depends on patch 3 and the corresponding parisc patch and
>> removes the ability to override the default hard RLIMIT_STACK. Dependi=
ng
>> on when the parisc patch reaches mainline I'll try and get this in for=

>> v3.16.
>>
>> Helge Deller (1):
>>   parisc,metag: Do not hardcode maximum userspace stack size
>>
>> James Hogan (3):
>>   metag: Reduce maximum stack size to 256MB
>>   metag: Remove _STK_LIM_MAX override
>>   asm-generic: remove _STK_LIM_MAX
>>
>>  arch/metag/include/asm/processor.h     |  2 ++
>>  arch/metag/include/uapi/asm/Kbuild     |  2 +-
>>  arch/metag/include/uapi/asm/resource.h |  7 -------
>>  arch/parisc/include/asm/processor.h    |  5 +++++
>>  arch/parisc/kernel/sys_parisc.c        |  6 +++---
>>  fs/exec.c                              |  6 +++---
>>  include/asm-generic/resource.h         |  2 +-
>>  include/uapi/asm-generic/resource.h    |  7 -------
>>  mm/Kconfig                             | 15 +++++++++++++++
>>  9 files changed, 30 insertions(+), 22 deletions(-)
>>  delete mode 100644 arch/metag/include/uapi/asm/resource.h
>>
>> Cc: Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>
>> Cc: "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
>> Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>
>=20


--FmsEtE3KekkjGM54OudD0OkHRBhhpevf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc/tfAAoJEGwLaZPeOHZ6DhUP/2TlOvuMrdpijyMeLu6mzd6D
tqNwZCw35jqG9SZHKzytGc3H7XCvS/WePh6X189R9ToOneAK8FSKnp/hF6dLjywL
eOlE6ygYcMosTRVjNgGD06NxKSB0v+drqgbjXHEZI2rXnjddaoT0qy/6qYp9t95n
VK2cZ2R7mI6hPPY1OrGkty4FdcWLTdDN4QQrPpXat0V125S9u57f3Ptdp9CXk6bR
aAm85bb0ZEOKzlBttcQwBfJ+eAUPNnAExuXZzrCrY9FqPBOM2A0fyKaXB/uJpNOQ
UTr0qXVAYPiynJf1Kr84cP0wEMpgqxD7rf4HnCW3BMk77t6xoIJxVqeTbRCCMmyN
KeyDNu7UgnMm/iPjy2U+LtAVVdhrVBt2+X8EFI1uX3rgWmOTG65yqky6VU6hK/FT
q0fOkKoe+HXn8Ds81ktgh7Yq0sESex1EEVJKCsx3YEsiA8yausTWPJOCx6gyc/+3
aUOnmqFo+zD8umtVbmZZRswZ+ES92ASiLp6CcYyp9ZUFqb5jR8yDveBzy1aRCCRX
9J4kV4S6b6tx8tT6HUGJ1hWJC4iu/Td8Wh60GgjNRU3wf2JrdVzb2BU3R57RUAG9
RPtWsGJRmqv//xO6OgR+3MdJ9msr8AQP4wAjbGao050ttKaXGQO8ORGJUb8X+Gum
86sij8b/3b4mgzsf49ea
=NzJq
-----END PGP SIGNATURE-----

--FmsEtE3KekkjGM54OudD0OkHRBhhpevf7--
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
