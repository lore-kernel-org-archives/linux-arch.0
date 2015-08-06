From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 0/7] test_user_copy improvements
Date: Thu, 6 Aug 2015 17:28:32 +0100
Message-ID: <55C38B30.5030405@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
 <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:60242 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753253AbbHFQ2s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2015 12:28:48 -0400
In-Reply-To: <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>

--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On 05/08/15 21:26, Kees Cook wrote:
> On Wed, Aug 5, 2015 at 8:48 AM, James Hogan <james.hogan@imgtec.com> wr=
ote:
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
>> James Hogan (7):
>>   test_user_copy: Check legit kernel accesses
>>   test_user_copy: Check unchecked accessors
>>   test_user_copy: Check __clear_user()/clear_user()
>>   test_user_copy: Check __copy_in_user()/copy_in_user()
>>   test_user_copy: Check __copy_{to,from}_user_inatomic()
>>   test_user_copy: Check user string accessors
>>   test_user_copy: Check user checksum functions
>>
>>  lib/test_user_copy.c | 221 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 221 insertions(+)
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>=20
> Ooooh! Nice! This is great, thank you. :) Great to hear it helped find
> a bug too. :)
>=20
> I'm wondering if we need to macro-ize any of these. Probably not, but
> it just feels like there's a lot of repeated stuff now. But I think
> it's a bit of an illusion since each test is ever so slightly
> different from the others.

Yeh, I wondered that too, but I agree they're all slightly different in
their requirements so it'd just end up confusing things.

>=20
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

James


--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVw4sxAAoJEGwLaZPeOHZ60TYQALZHVpKGUHKd/ATy5gxfqq8+
DM12XcxjOhP2Adzl8StQ+sF6TSHf5K9fyqul5NLrj5k4Vk9mnITcxJ4BVNTpTurh
cIuvcrcdunDYOH30mlAAnl2XYULl96Oi94gu0PbMLGNgdTugqJ9s5xP4i2zAKJKv
GzqzkHnLvrphtZ3FKP4ZF0XXjWmsBBnzBSWcDlgRDfdkx1MiSIBBGUA3yjja39AH
YM1Zjuo5Dn7A1ABi+fECvofM7C12T1nQiaaxNUwpkYnUZW1S8HS4TVqb+EgAlzL2
jEZEzo3KzuiKaIqF9IELkEOtMYne/Of6IIXtSDoPiiDaJblBfFU+WtzorV7dttMk
6h4037fnEPBJHmDHy8hyltmzeMcJFQDSwpIkIgbdahMHPEtXNZbncvD5TaojAixP
E6KCBsazjUguCGm4sPk3hhTPZTwS5rsK1sA72Zn38J3FHwzoJLYYf9wYih9w162P
0UImDGAYS/1LIiWIl4aPEjQ1xITlw/IqY7Up8y8Z5LLO0GjXfja8iHr62BpfKAM1
LqP0N9D+g6S6T5b4vImPHM4lrPh1k9pNVX4IHFjm7bNHMc5BJLaOQvVo06JT4rMv
hHHnSl6hlzX3EfSXrh2HfSnej01OXur0nOKcNPJSfxMx/pIJs1MejpqfsSx0MgiC
D6szhs9/VIhNSzWidoeE
=OHbs
-----END PGP SIGNATURE-----

--pSjgpWuB5QAVeNG7kw5WspEfp6siBa50O--
