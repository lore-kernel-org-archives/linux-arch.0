From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Thu, 1 Nov 2012 11:42:12 +0000
Message-ID: <50926014.1080804@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <20121031223331.GA2764@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:50174 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147Ab2KALmd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 07:42:33 -0400
In-Reply-To: <20121031223331.GA2764@thor.bakeyournoodle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/10/12 22:33, Tony Breeds wrote:
> On Wed, Oct 31, 2012 at 04:13:41PM +0000, James Hogan wrote:
>> This patchset adds core architecture support to Linux for
>> Imagination's Meta ATP (Meta 1) and HTP (Meta 2) processor cores.
>> It is primarily an RFC patchset to get some early feedback about
>> what changes we need to make, although of course all feedback is
>> most welcome.
> 
> Any chance there are patches out there to build a toolchain?

Hi Tony,

We're working on a buildroot release with toolchain patches etc
included, which we hope to make available tomorrow, but which may slip
to late next week (ELC-E).

In the mean time, there is an older buildroot available here (which
requires registration):
http://www.imgtec.com/minimorph

It still uses our legacy system call numbers, so isn't useful for
running any userland code, but it's sufficient to build the kernel.

Download the Minimorph v1.7 release in the MetaFlow SDK. Extract
metag-linux-GPL-Minimorph_1_0-rel007.tar.gz, and in the buildroot
directory, change the config to save a little time:
$ make comet_defconfig

then switch busybox to v1.19.x (default version doesn't build out of
the box with newer versions of make):
$ make menuconfig
	package selection for target
		BusyBox Version

After building buildroot, the CROSS_COMPILE prefix is:
$buildroot/output/host/usr/bin/metag-linux-

Thanks
James
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkmAUAAoJEKHZs+irPybfj5UQAIPduw5gFld9Cw133l0RWJAp
VPlF+CKN5CGCxQ4jDHAckoI7Yn4Z4Bx/m6luN9u5fKBGeEcS2cXmji81UuSv9oFh
M5WHymfMJEXqGggQX+Ue9ccy3v4X7z95AuwsaxxCT0xhgVmNhWUKNNAT+o2I5YLx
v0Mbs3l2esip97iH0nTZAbsYaC5dZUsCI65bVBZ9vrTRiuMqv8tRo3KpupX2yUcX
BcDBw23x1bligbYtSZyNVMM4WyK+5xDvRomsNlZIePjMUADtx5mwzSeQuxyAJown
gu0mj6lwbyDI+hDudz6kUC5Y+5XC2jEyOBC+xBXiL4fkoVI40WcTO/XDr/3xf8g9
cWYlR+bIPcD98P0MwxHvXZBgia3dpTKC4hVNeW2Pg4veejqQmGgB0r6s/MWLYwB2
3czuYGtz7FufJf0H0lZbhE11anQzsogeHXfAhaJo/6veV53p5ks91Gr+l45VzjXp
ebYoE6BO3afPH4DjvvasnbOvVSgCVdz5g9G+TgGsQ3c+AQ+989+Rq88DFme1SqE4
fRW+0W2zQdSii0DPMYliA3jA0QsRpRkrmGS2BjYWshc4l9TeP+i7t56dVPyPsFFd
TH4cQYDI43popZVZ/EaanEts/EEX04/R/RfzlVafuaBZ/3+ENznQGHQR4L1jaTvq
J5x0MO7Lyj+Rzxh9Us19
=mIEP
-----END PGP SIGNATURE-----
