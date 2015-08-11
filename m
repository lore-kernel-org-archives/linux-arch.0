From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Tue, 11 Aug 2015 12:07:20 +0100
Message-ID: <55C9D768.7060409@imgtec.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
 <20150810.152938.1076489414700359615.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="U0IvxqsACcuHvLxNR0nPTFRJ99mulIrVC"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:58747 "EHLO
	imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933715AbbHKLHj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2015 07:07:39 -0400
In-Reply-To: <20150810.152938.1076489414700359615.davem@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, keescook@chromium.org, akpm@linux-foundation.org, monstr@monstr.eu, lftan@altera.com, jonas@southpole.se, chris@zankel.net, jcmvbkbc@gmail.com, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org

--U0IvxqsACcuHvLxNR0nPTFRJ99mulIrVC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi David,

On 10/08/15 23:29, David Miller wrote:
> From: James Hogan <james.hogan@imgtec.com>
> Date: Fri, 7 Aug 2015 16:21:53 +0100
>=20
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
>>   copies, clear_user, compatibility accessors (copy_in_user and
>>   _unaligned), the user string accessors, and the user checksum
>>   functions, all of which need special handling in arch code with EVA.=

>>
>> Tested on MIPS with and without EVA, and on x86_64.
>>
>> Only build tested for arm, blackfin, metag, microblaze, openrisc,
>> parisc, powerpc, sh, sparc, tile, i386 & xtensa.
>>
>> All arches were audited for the appropriate exports, only score is kno=
wn
>> to still be missing some.
>=20
> James, thanks for doing this work.
>=20
> If I understand the MIPS EVA facility correctly, it operates exactly li=
ke
> how sparc64 does.  Wherein user and kernel virtual addresses are fully
> segregated, and one must use a specially tagged load or store to access=

> user addresses.

Yes, sort of. Roughly speaking, 6 segments in the MIPS virtual address
space become configurable such that each one may be:
* TLB mapped and accessible to user and kernel (both modes must share
TLB mappings in that segment)
* TLB mapped in user mode, but not-TLB-mapped to kernel mode (a window
into physical memory).
* (and various other combinations)

This allows the kernel virtual address space to be extended down to
overlap the user address space and make more physical memory directly
accessible to the kernel, and potentially for the user virtual address
space to extend upwards too.

So if there is any overlap, the EVA load/store instructions must be used
whenever user memory is accessed by kernel.

> This actually creates problems for the tests as currently coded on
> such systems (this problem existed before your changes).  You might
> not be triggering this problem on MIPS EV but it certainly is there.
>=20
> For example, consider this test:
>=20
> 	ret |=3D test(!copy_from_user(bad_usermem, (char __user *)kmem,
> 				    PAGE_SIZE),
> 		    "illegal reversed copy_from_user passed");
>=20
> If the 'kmem' access faults, we will try to zero out PAGE_SIZE bytes
> at 'bad_usermem'.  But this is not necessarily going to fail.

Out of interest, is the zeroing a strict requirement for correct use, or
a safety precaution to prevent data leakage in case of bad error checking=
?

(A quick look reveals that for copy_from_user() when access_ok() fails,
only arm, arm64, frv, m32r, m68k, sparc, tile, x86, and xtensa do this).

>=20
> The user address 'bad_usermem', on MIPS EV and sparc64, could just as
> equally happen to be a legitimate kernel address.  So this clear will
> succeed and we will end up clearing memory at an arbitrary kernel
> address.

That's a good point. The reversed tests aren't really safe in that case.
With MIPS EVA the user address is very likely to be a valid
non-TLB-mapped address to kernel mode, and will zero arbitrary memory.
They could also potentially crash the kernel if user memory isn't
normally kernel accessible and the arch doesn't fix up faults for the
kernel accesses (not EVA, but maybe sparc64?).

It is also possible (though less likely) that the kernel address will
have a valid user mapping at the same address, so the reversed
copy_to_user test may well leak arbitrary kernel memory to user memory
without faulting.

> There is no real way to trap this situation as a native load/store
> will work just fine on these addresses.
>=20
> I don't have a good suggestion other than to say that these tests
> seem to only be valid in a combined kernel/user address space, ie.
> for systems other than MIPS EV and sparc64.

Yes, although I think the all-kernel ones are still valuable for testing
where it can be assumed that kernel addresses are unlikely to be valid
user addresses (otherwise they may also succeed where they should fail
for similar reasons, but are otherwise harmless).

> Also, I think the tests you added and protected with MIPS ifdefs could
> equally be enabled on sparc64.

Yes, it sounds like it. I'll try the ARCH_SPLIT_VA_SPACE idea.

I have since tested these ones on a different (out of tree) EVA
configuration (legacy segment layout, but EVA instructions enabled) and
it ends up accessing kernel only addresses (not in the overlapping area)
with EVA instructions, which would normally get caught by access_ok() in
the other illegal tests, but are not handled properly by the arch (they
generate address error exception instead of TLB invalid exception). It
sounds like they should just work out of the box on sparc64 though if
they literally use a different ASI (aside from the risk of false positive=
s).

Thanks for the feedback!

Cheers
James


--U0IvxqsACcuHvLxNR0nPTFRJ99mulIrVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVyddvAAoJEGwLaZPeOHZ6AAEQAKvT7PjDOttuoWTS+OZ16NDR
FVIXZ5kyjOxiqQolz4qj2JH9+w5XbhX24mLsJPh+wx5mRSO6JYGNrIP4lSTQyhl0
Eu2T0IQUpVHMXv8APkqt6GNKa2EE9/bx7lCtGMziAajk7VG+0ZTKQ4K665a68+kv
QAveT0u0IqrZfHlvtE22EDr3HFqP0j75HbnlzCYNX1WrHRUi74mKl6O26JS4r4AE
9tBZ/YxOIuTFbgtblF/topUrm0+usThY/TeZVBCT/oyCbWrrM5Klh4XNHnF8TOuf
wtdFMeFmUOXmhh6nNXWoz2IAgNfpb3U0cI2ZCGzPLZDgDCx2L05gL4nfyX+i4GMj
nalC/CCEHJMgw98EfX7ocCwKymV0PFTRTA2xgeoaY48xXrvi2FoGiVmwwHJ+X0kT
Clw+ylxU2wTkX5HFrhIWe1hdi3++bsml2aJdq4t/tJR3w1lk4i7Dc8HvrVjUeAlk
LVGSAFkwZ/d0gco1QRrYwRnZnc7PxgEwEK2+rW0jQ/YvGPsSw/fAD0w4l8x2UwJN
H2qBkFEdQ3kQwN6SWvf0cFD1kAY72aE6JQZ0R9BHK31tLWeeEtvJGYqWzWfcX12z
Z4PrwDDem3bNzL8HbmV3vY5ldZSnqLeO6cfFLZT53SSlo5BSz0g+sobEKWuPGcNo
iJtm0pIFCMb/YVp4OdJA
=aGiL
-----END PGP SIGNATURE-----

--U0IvxqsACcuHvLxNR0nPTFRJ99mulIrVC--
