Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:47723 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbaBXNwy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Feb 2014 08:52:54 -0500
Message-ID: <530B4EB1.9000907@imgtec.com>
Date: Mon, 24 Feb 2014 13:52:49 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH] asm-generic: add sched_setattr/sched_getattr syscalls
References: <1391441617-21518-1-git-send-email-james.hogan@imgtec.com> <20140217184435.GD8361@arm.com>
In-Reply-To: <20140217184435.GD8361@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DSPheHrLGBJJ4VcrXica0DsfFWdjx0VQb"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msalter@redhat.com" <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Richard Kuo <rkuo@codeaurora.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, "linux@openrisc.net" <linux@openrisc.net>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20140224135249.3vXgx8mtvZOVBBLF5evkxHx_M5adTsOsvYgXcGHrQmc@z>

--DSPheHrLGBJJ4VcrXica0DsfFWdjx0VQb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/02/14 18:44, Catalin Marinas wrote:
> On Mon, Feb 03, 2014 at 03:33:37PM +0000, James Hogan wrote:
>> Add the sched_setattr and sched_getattr syscalls to the generic syscal=
l
>> list, which is used by the following architectures: arc, arm64, c6x,
>> hexagon, metag, openrisc, score, tile, unicore32.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>> Cc: linux-c6x-dev@linux-c6x.org
>> Cc: Richard Kuo <rkuo@codeaurora.org>
>> Cc: linux-hexagon@vger.kernel.org
>> Cc: linux-metag@vger.kernel.org
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: linux@lists.openrisc.net
>> Cc: Chen Liqin <liqin.linux@gmail.com>
>> Cc: Lennox Wu <lennox.wu@gmail.com>
>> Cc: Chris Metcalf <cmetcalf@tilera.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks,

FYI I've applied to my fixes branch which is included in linux-next,
I'll send Linus the pull request in a few days.

Cheers
James


--DSPheHrLGBJJ4VcrXica0DsfFWdjx0VQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJTC06yAAoJEKHZs+irPybfN/0QAKd34rJD7Lf6XqMgKHo7tfRD
+LLHi/g8OlR1xkPKXmQlmdyGKtW+QmnGq/GLzJ1dTC8HZh/74i3NAtlTXIlujdsT
ooD0TKqgHPaypdyrHlAO9GSHi241517cdWoai+4bNjg9nxStQ5R69XG4rUYkMkGU
Tg/K6U8W9GNM1btJPGgrjV+qjmJ7zHOAWG1D631K+qxTn605HMefNbpCCJIV4NTg
F6oGRAqaqh/NKLWY59zYz6iyE29chf7TPKSWiDJvHc8ZMfgnb3nhUnktUTHDbOqf
FUfdWnzbvsN2jZFFOzTcoRbwObTYgMz0/Q8l3HZMbFSfLhLvhsZhQPd0SdAVJdzO
zTaKiNun1hGfRhrFDUjmPf7xVur7N3Jq+62MfF0DFCJJ+23bImpW9+NWtJgcaLsS
kVY+1M+ruhH628xBbQxvaAXHDpWhm3LYca+9zQ+fg17XcvEIHZeXcPs5tn/6CKqw
B91Qn+BkAGCaf5QcmI+ZjKONpRtKdKjJPDssAHqmHeLno5/Q1rlDESgTwZriOd8o
nLTTBSEkuY4xDPvB6GXPq83jKUc0x2hqeIjAziM5HM68IDH/eeWu+VY7tsGZepqW
WogeiGNd4InXLUUvMljLPS8a0L4Y4e4vQEtbgO9TlUgnoq1/gXBoKvXlBaL98OZ7
gcQf5gh2u0hqCIZMsbfH
=8jpm
-----END PGP SIGNATURE-----

--DSPheHrLGBJJ4VcrXica0DsfFWdjx0VQb--

