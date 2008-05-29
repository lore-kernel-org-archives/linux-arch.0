From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 09:10:06 +0200
Message-ID: <200805290910.07207.arnd@arndb.de>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<1211926779.3286.104.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1211926779.3286.104.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: benh@kernel.crashing.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: linux-arch.vger.kernel.org

On Wednesday 28 May 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-27 at 14:55 -0700, Linus Torvalds wrote:
> > 
> > On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > > 
> > > A problem with __raw_ though is that they -also- don't do byteswap,
> > 
> > Well, that's why there is __readl() and __raw_readl(), no?
> 
> As I replied to somebody else, __readl() is news to me :-) we dont' have
> those on powerpc.
> 

It's not exactly a well-established interface. Only five architectures
define these functions, and there is not a single user in the kernel
source outside of these architecture's io.h files.

	Arnd <><
