From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h
	include
Date: Thu, 25 Oct 2012 14:07:26 +0000
Message-ID: <201210251407.27145.arnd@arndb.de>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
	<1351172416.6232.70.camel@jerome.southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1351172416.6232.70.camel@jerome.southpole.se>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>, Mike Frysinger <vapier@gentoo.org>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux@lists.openrisc.net, Guan Xuetao <gxt@mprc.pku.edu.cn>, uclinux-dist-devel@blackfin.uclinux.org, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 25 October 2012, Jonas Bonn wrote:
> On Tue, 2012-10-23 at 10:21 +0100, James Hogan wrote:
> > Including <asm/cacheflush.h> from <asm-generic/io.h> prevents
> > cacheflush.h being able to use I/O functions like readl and writel due
> > to circular include dependencies. It doesn't appear as if anything from
> > cacheflush.h is actually used by the generic io.h, so remove the
> > include.
> > 
> > I've compile tested a defconfig compilation of blackfin, openrisc (which
> > needed <asm/pgtable.h> including from it's <asm/io.h> to get the PAGE_*
> > definitions), and xtensa.
> > 
> > Other architectures which use asm-generic/io.h are score and unicore32,
> > and looking at their io.h I don't see any obvious problems.
> 
> Acked-by: Jonas Bonn <jonas@southpole.se> for OpenRISC
> 
> Who's tree should this go via.  I can take it via the openrisc tree, but
> it would be good to get some Ack's that this isn't going to break things
> for the other arch's (in particular score and unicore32, since they are
> untested).

I've put it into the asm-generic tree, now that I have set it up again
for the 3.7 merge window.

	Arnd
