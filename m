From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h
	include
Date: Thu, 25 Oct 2012 14:10:23 +0000
Message-ID: <201210251410.23720.arnd@arndb.de>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
	<1351172416.6232.70.camel@jerome.southpole.se>
	<5089479F.6070608@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <5089479F.6070608@imgtec.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux@lists.openrisc.net, uclinux-dist-devel@blackfin.uclinux.org, Chen Liqin <liqin.chen@sunplusct.com>, Chris Zankel <chris@zankel.net>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 25 October 2012, James Hogan wrote:
> > Who's tree should this go via.  I can take it via the openrisc
> > tree, but it would be good to get some Ack's that this isn't going
> > to break things for the other arch's (in particular score and
> > unicore32, since they are untested).
> 
> Yeh I'd like some acks from score and unicore32 if possible, since I
> didn't notice I needed the openrisc bit until I tried compiling it.

I'm not worried about score, because there have been no updates at
all for the entire last year, and I doubt anyone is using that any
more. I agree that having an Ack from Guan Xuetao would be good.

The patch will also show up in linux-next now, and I can update
it if necessary.

	Arnd
