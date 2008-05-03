From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Sat, 3 May 2008 23:14:23 +0200
Message-ID: <200805032314.24669.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200805031116.50236.arnd@arndb.de> <481C8B48.5020306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:55399 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbYECVOw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 17:14:52 -0400
In-Reply-To: <481C8B48.5020306@redhat.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: John Williams <john.williams@petalogix.com>, monstr@seznam.cz, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>

On Saturday 03 May 2008, Ulrich Drepper wrote:
> Yes, this is how it should be. =C2=A0It's not done because no archite=
cture
> glibc officially supports arrived after these and similar syscalls
> arrived. =C2=A0There is no need to implement the not-*at interface, n=
o need
> to implement the creat syscall, etc etc.

Ah, good! So where should the glibc implementation for these calls go?
In the microblaze (and any future architecture) specific source directo=
ries,
to be consolidated when you get more of them, or in the common places l=
ike
sysdeps/unix/sysv/linux/*.c, with the appropriate #ifndef?

	Arnd <><
