From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] Implement close-on-fork
Date: Fri, 15 May 2020 17:03:42 +0100
Message-ID: <20200515160342.GE23230@ZenIV.linux.org.uk>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200515152321.9280-1-nate.karstens@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Karstens <nate.karstens@garmin.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Changli Gao <xiaosuo@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, May 15, 2020 at 10:23:17AM -0500, Nate Karstens wrote:

> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

It penalizes every call of fork() in the system (as well as adds
an extra dirtied cacheline on each socket()/open()/etc.), adds
memory footprint and complicates the API.  All of that - to deal
with rather uncommon problem that already has a portable solution.

As for the Austin Group, the only authority it has ever had derives
from consensus between existing Unices.  "Solaris does it, Linux and
*BSD do not" translates into "Austin Group is welcome to take a hike".
BTW, contrary to the lovely bit of misrepresentation in that
thread of theirs ("<LWN URL> suggests that" != "someone's comment
under LWN article says it _appears_ that"), none of *BSD do it.

IMO it's a bad idea.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
