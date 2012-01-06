From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [GIT PATCH] driver core merge for 3.3
Date: Fri, 6 Jan 2012 22:31:48 +0000
Message-ID: <20120106223148.GN20752@decadent.org.uk>
References: <20120106201126.GA7239@kroah.com>
 <CAMuHMdVdTcJFePA2tf-jqnLGW_2i7rJLqAX521SM+rz0YzXJNg@mail.gmail.com>
 <20120106220608.GA20623@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33115 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab2AFWby (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2012 17:31:54 -0500
Content-Disposition: inline
In-Reply-To: <20120106220608.GA20623@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Jan 06, 2012 at 02:06:08PM -0800, Greg KH wrote:
> On Fri, Jan 06, 2012 at 10:38:41PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Jan 6, 2012 at 21:11, Greg KH <gregkh@suse.de> wrote:
> > > Ben Hutchings (1):
> > > =A0 =A0 =A0topology: Provide CPU topology in sysfs in !SMP config=
urations
> >=20
> > FWIW, as reported before, I can confirm that 3.2.0-next-20120106 cr=
ashes
> > on m68k during boot:
[...]
> > Disabling lock debugging due to kernel taint
> > Kernel panic - not syncing: Attempted to kill init!
> >=20
> > Reverting the above commit (ccbc60d3e19a1b6ae66ca0d89b3da02dde62088=
b)
> > fixes it.
> >=20
> > So to preserve bisectability, you may want to drop this ommit until=
 the
> > UP-only archs have been fixed.
>=20
> Ick, sorry for missing that report, you are right.
>=20
> Ben, I thought this patch was for UP systems, how did this work on yo=
ur
> testing?

It works just fine on UP x86.  However I have been made aware that
it breaks on m68k and I told you as much in
<1325462025.13595.189.camel@deadeye>:

> None of these architectures appears to call register_cpu():
>=20
>     c6x frv h8300 m68k microblaze openrisc score um xtensa
>=20
> and therefore they will all panic at boot following this change (comm=
it
> ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b).  So either I can try to fi=
x
> them or else it must be reverted for now.

Ben.

> Linus, can you revert this, or I can if you want me to.
>=20
> thanks,
>=20
> greg k-h
>=20

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert =
Camus
