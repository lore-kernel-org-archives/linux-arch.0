From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 45/56] microblaze_v2: headers simple files - empty or redirect to asm-generic
Date: Tue, 6 May 2008 11:02:20 +0200
Message-ID: <200805061102.22528.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <1209954849.5798.80.camel@localhost> <fa686aa40805050810w2a0ff71fv9daff4ba198cf978@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58723 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763737AbYEFJDR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 05:03:17 -0400
In-Reply-To: <fa686aa40805050810w2a0ff71fv9daff4ba198cf978@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Williams <john.williams@petalogix.com>, monstr@seznam.cz, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

On Monday 05 May 2008, Grant Likely wrote:
> > =A0These are all just includes of asm-generic/* (hooray!).
> >
> > =A0But, is it reasonable to to suggest adding asm-generic at the en=
d of the
> > =A0kernel include path, and save all this verbosity?
> >
> > =A0Principle of least surprise maybe?
>=20
> Convention in the other archs is already established to explicitly
> include asm-generic files one by one. =A0It is probably best to match
> existing convention for commonality sake.

Right, I agree. We may eventually want to move to something more sophis=
ticated,
but we should not change the current way of doing this while we're in t=
he process
of adding a new architecture.

	Arnd <><
