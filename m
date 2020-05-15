From: "Karstens, Nate" <Nate.Karstens@garmin.com>
Subject: RE: [PATCH v2] Implement close-on-fork
Date: Fri, 15 May 2020 16:26:28 +0000
Message-ID: <954ef5ce2e47472f8b41300bf59209c5@garmin.com>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515160342.GE23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200515160342.GE23230@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kerne>
List-Id: linux-arch.vger.kernel.org

Al,

The reference to the POSIX change was included more for a reference to that=
 discussion, not to say "POSIX did this and so Linux must do it to". In any=
 case, the documentation presented to the Austin Group was focused more aro=
und the issue we ran into and some alternative solutions. In reviewing the =
notes from the meeting I didn't get the impression that they added this to =
POSIX simply because Solaris and *BSD already had it (reference https://aus=
tingroupbugs.net/view.php?id=3D1317, the first solution we suggested).

> It penalizes every call of fork() in the system

Is the performance hit really that drastic? fork() does a lot of stuff and =
this really seems like a drop in the bucket...

> adds an extra dirtied cacheline on each socket()/open()/etc.

It sounds like we can work to improve that, though.

> already has a portable solution

What is the solution?

Thanks,

Nate

-----Original Message-----
From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
Sent: Friday, May 15, 2020 11:04
To: Karstens, Nate <Nate.Karstens@garmin.com>
Cc: Jeff Layton <jlayton@kernel.org>; J. Bruce Fields <bfields@fieldses.org=
>; Arnd Bergmann <arnd@arndb.de>; Richard Henderson <rth@twiddle.net>; Ivan=
 Kokshaysky <ink@jurassic.park.msu.ru>; Matt Turner <mattst88@gmail.com>; J=
ames E.J. Bottomley <James.Bottomley@hansenpartnership.com>; Helge Deller <=
deller@gmx.de>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba=
@kernel.org>; Eric Dumazet <edumazet@google.com>; David Laight <David.Laigh=
t@aculab.com>; linux-fsdevel@vger.kernel.org; linux-arch@vger.kernel.org; l=
inux-alpha@vger.kernel.org; linux-parisc@vger.kernel.org; sparclinux@vger.k=
ernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Changli Ga=
o <xiaosuo@gmail.com>
Subject: Re: [PATCH v2] Implement close-on-fork

CAUTION - EXTERNAL EMAIL: Do not click any links or open any attachments un=
less you trust the sender and know the content is safe.


On Fri, May 15, 2020 at 10:23:17AM -0500, Nate Karstens wrote:

> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

It penalizes every call of fork() in the system (as well as adds an extra d=
irtied cacheline on each socket()/open()/etc.), adds memory footprint and c=
omplicates the API.  All of that - to deal with rather uncommon problem tha=
t already has a portable solution.

As for the Austin Group, the only authority it has ever had derives from co=
nsensus between existing Unices.  "Solaris does it, Linux and *BSD do not" =
translates into "Austin Group is welcome to take a hike".
BTW, contrary to the lovely bit of misrepresentation in that thread of thei=
rs ("<LWN URL> suggests that" !=3D "someone's comment under LWN article say=
s it _appears_ that"), none of *BSD do it.

IMO it's a bad idea.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
