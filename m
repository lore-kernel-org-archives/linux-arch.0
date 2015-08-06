From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 0/7] test_user_copy improvements
Date: Thu, 6 Aug 2015 11:01:58 +0100
Message-ID: <55C33096.1070206@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
 <20150806095009.GA8498@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VJxfWHOrSJ0esFQb94nCRQ69V1PNqXhRM"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:36236 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753433AbbHFKCO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2015 06:02:14 -0400
In-Reply-To: <20150806095009.GA8498@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

--VJxfWHOrSJ0esFQb94nCRQ69V1PNqXhRM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/08/15 10:50, Guenter Roeck wrote:
> Hi James,
>=20
> On Wed, Aug 05, 2015 at 04:48:48PM +0100, James Hogan wrote:
>> These patches extend the test_user_copy test module to handle lots mor=
e
>> cases of user accessors which architectures can override separately, a=
nd
>> in particular those which are important for checking the MIPS Enhanced=

>> Virtual Addressing (EVA) implementations, which need to handle
>> overlapping user and kernel address spaces, with special instructions
>> for accessing user address space from kernel mode.
>>
>> - Checking that kernel pointers are accepted when user address limit i=
s
>>   set to KERNEL_DS, as done by the kernel when it internally invokes
>>   system calls with kernel pointers.
>> - Checking of the unchecked accessors (which don't call access_ok()).
>>   Some of the tests are special cased for EVA at the moment which has
>>   stricter hardware guarantees for bad user accesses than other
>>   configurations.
>> - Checking of other sets of user accessors, including the inatomic use=
r
>>   copies, copy_in_user, clear_user, the user string accessors, and the=

>>   user checksum functions, all of which need special handling in arch
>>   code with EVA.
>>
>> Tested on MIPS with and without EVA, and on x86_64.
>>
> The series causes several build failures with other architectures.

Thanks Guenter, and sorry for the breakage. I've already got some fixes
lined up. From the failure logs it looks like #ifdef CONFIG_COMPAT for
[__]copy_in_user and #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER for the
the ppc64 csum_partial_copy_from_user one Stephen caught should sort it o=
ut.

Cheers
James

>=20
> From next-20150806:
>=20
> Build results:
> 	total: 152 pass: 138 fail: 14
> Failed builds:
> 	alpha:allmodconfig (*)
> 	arm:allmodconfig (*)
> 	arm:omap2plus_defconfig
> 	arm64:allmodconfig
> 	i386:allyesconfig (*)
> 	i386:allmodconfig (*)
> 	m68k:defconfig (*)
> 	m68k:allmodconfig (*)
> 	m68k:sun3_defconfig (*)
> 	mips:allmodconfig
> 	parisc:allmodconfig
> 	s390:allmodconfig
> 	sparc32:allmodconfig (*)
> 	xtensa:allmodconfig (*)
>=20
> The builds marked with (*) fail because of your patch series.
>=20
> Guenter
>=20


--VJxfWHOrSJ0esFQb94nCRQ69V1PNqXhRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVwzCWAAoJEGwLaZPeOHZ6RUkQAKzOhV3G41GH2Wdgf5gY1ZM0
0i4Ca71FvmQh2E/3XMRRpQAqVV3nJ6OZZBU2j+LVfAQf1qfzUkbvUC0L32Qe574l
xPTNZeLjlxDEECGMkLS7Ss+g4PFh9/mr0TBzGFHzimUgIxw6+B7Hk/R/3YLUAt6d
9E4Z0ykj73MBIYBpwKEJ3X5q560vnyL9gmfunHKTUHl+JSFMt6EDHQE7jy1akyjG
6orq1hwlxlWOYSdOGqdi8EbRqvZUMk7dYHuPv7UOA8L6rfkLmQLFU+0qZ3cz4SId
DyuEO3g+yK3ivOqyya++ddcg6BOL/uVT7ZGExKOos2blgYcRxb2FASNifn4ZyP8g
CJ6vWAhJGxRX1Z3qe/VerUvLFOVIZSAkQKAquz+8YZzmyDlKh9V4jAinB3OpcFLq
LSX22XmHthfQEo8KJ89gUqO5hnDe0SvYTFDDKqNrQoCQP7MkJsd4327BpFCJnLL3
NUsuh7m61l9gAI7B4DezDqZSfnxalY+T1KXzFbNzYVMR3rr+Vt1owz/UpthHpcWl
uTn5hX79z+oJyny5hZUV11svFrzUz/Nw6UkK3jjhDI0PIPzUHjimHyKEsTfJjzuJ
VucPkgn9CnsJsAM3oznIJ0+oCJTg8nC+D3C14YN/sqOxrtEgc/z3isj1gJ3udmfZ
XABr3TCHM+YXBqENIJal
=Wb2G
-----END PGP SIGNATURE-----

--VJxfWHOrSJ0esFQb94nCRQ69V1PNqXhRM--
