From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 16:52:07 +0000
Message-ID: <509D34B7.1040300@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <20121031223331.GA2764@thor.bakeyournoodle.com> <50926014.1080804@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55568 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab2KIQwK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 11:52:10 -0500
In-Reply-To: <50926014.1080804@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/11/12 11:42, James Hogan wrote:
> On 31/10/12 22:33, Tony Breeds wrote:
>> On Wed, Oct 31, 2012 at 04:13:41PM +0000, James Hogan wrote:
>>> This patchset adds core architecture support to Linux for 
>>> Imagination's Meta ATP (Meta 1) and HTP (Meta 2) processor
>>> cores. It is primarily an RFC patchset to get some early
>>> feedback about what changes we need to make, although of course
>>> all feedback is most welcome.
> 
>> Any chance there are patches out there to build a toolchain?
> 
> Hi Tony,
> 
> We're working on a buildroot release with toolchain patches etc 
> included, which we hope to make available tomorrow, but which may
> slip to late next week (ELC-E).

Hi,

A buildroot git tree with gcc, uClibc, and kernel header patches is
now available here:
git://github.com/img-meta/metag-buildroot.git

Use the meta2_defconfig.

Cheers
James
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnTS3AAoJEKHZs+irPybfL5MQAKNj1yK7H9PKB8ABS0plN/4i
OW3GUcBjUiq4tk/avo2TGKVPrrw8b/d0do7bIyliucPKIlf9J71Ci3NMsaudvKID
d1d6Jsz9y0qw7cBhe2wrcoAVvOCufuepV79OxJe6Z2uIhFZrwhaEbPnjraauswIp
L0bEQYJpvpb8k5l0Lx6LH6nhGSkCZCGt5NeVkESv5idnbkcBEJjWhs4o3yEvA/al
3Ceng1zwnjNPkdl5cJe7Zgsif6rcYxqVIMXs7mmMV0OGknHYD1qX+LBtFLkPiuU/
nVuenVDfIJY+S+D3UFOgBd8r/FxpMZ5EC7S0yVETs3qptuaDyBMbt3O6+TQRZPD3
AKQBi1tEpcG3AYTayp/2QkiXJwctYL3wgUuH4PgumxR6lP4X0dQWoLINZs1UJ61c
TgGX8MHgXNaLWwGpmT9kHAZxmDtwh9hPfR+hMx/BHm8jW3B5LU+3OG2OnMfgBh6V
RHaomIQsY93TqIQ96fo/NVMVHCvni+gGwEqaYgQxM2GPYGNpXeFfZaGTMFKZQ2Zo
eE/wAHD7Jp0r+OCmqMRxhiTfcriw2Fbwv6kjjyE6/zZM0/4XjxWrpN7DcpZumhnC
l5+m2x8MlfVrtGfZDbMnoKMfuMrVp2HH6yfgE2nzAWfAhjabXxmRLtHDJO21LCM4
tbFZnzUsm51ZZZjF59uN
=Uq2G
-----END PGP SIGNATURE-----
