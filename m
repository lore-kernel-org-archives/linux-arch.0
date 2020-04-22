From: "Karstens, Nate" <Nate.Karstens@garmin.com>
Subject: RE: [PATCH 1/4] fs: Implement close-on-fork
Date: Wed, 22 Apr 2020 16:02:49 +0000
Message-ID: <6ed7bd08892b4311b70636658321904f@garmin.com>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com>
 <fa6c5c9c7c434f878c94a7c984cd43ba@garmin.com>
 <20200422154356.GU5820@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200422154356.GU5820@bombadil.infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>"netdev@vger.kernel.org" <ne>
List-Id: linux-arch.vger.kernel.org

> It's not safe to call system() from a threaded app.  That's all.  It's ri=
ght there in the DESCRIPTION:

That is true, but that description is missing from both the Linux man page =
and the glibc documentation (https://www.gnu.org/software/libc/manual/html_=
mono/libc.html#Running-a-Command). It seems like a minor point that won't b=
e noticed until it causes a problem, and problems are rare enough they migh=
t go unnoticed for a while. We have removed system() from our application, =
but we're also concerned that libraries we integrate will use system() with=
out our knowledge.

-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>
Sent: Wednesday, April 22, 2020 10:44
To: Karstens, Nate <Nate.Karstens@garmin.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>; Jeff Layton <jlayton@kernel.o=
rg>; J. Bruce Fields <bfields@fieldses.org>; Arnd Bergmann <arnd@arndb.de>;=
 Richard Henderson <rth@twiddle.net>; Ivan Kokshaysky <ink@jurassic.park.ms=
u.ru>; Matt Turner <mattst88@gmail.com>; James E.J. Bottomley <James.Bottom=
ley@hansenpartnership.com>; Helge Deller <deller@gmx.de>; David S. Miller <=
davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; linux-fsdevel@vger.=
kernel.org; linux-arch@vger.kernel.org; linux-alpha@vger.kernel.org; linux-=
parisc@vger.kernel.org; sparclinux@vger.kernel.org; netdev@vger.kernel.org;=
 linux-kernel@vger.kernel.org; David Laight <David.Laight@aculab.com>; Chan=
gli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH 1/4] fs: Implement close-on-fork

CAUTION - EXTERNAL EMAIL: Do not click any links or open any attachments un=
less you trust the sender and know the content is safe.


On Wed, Apr 22, 2020 at 03:36:09PM +0000, Karstens, Nate wrote:
> There was some skepticism about whether our practice of
> closing/reopening sockets was advisable. Regardless, it does expose
> what I believe to be something that was overlooked in the forking
> process model. We posted two solutions to the Austin Group defect tracker=
:

I don't think it was "overlooked" at all.  It's not safe to call system() f=
rom a threaded app.  That's all.  It's right there in the DESCRIPTION:

   The system() function need not be thread-safe.
https://pubs.opengroup.org/onlinepubs/9699919799/functions/system.html

> Ultimately the Austin Group felt that close-on-fork was the preferred
> approach. I think it's also worth pointing that out Solaris reportedly
> has this feature
> (https://www.mail-archive.com/austin-group-l@opengroup.org/msg05359.html)=
.

I am perplexed that the Austin Group thought this was a good idea.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
