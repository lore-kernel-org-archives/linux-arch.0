From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 26 Aug 2016 16:07:49 +0200
Message-ID: <201608261607.49610.arnd@arndb.de>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <2147968.tzghefjZMo@wuerfel> <20160826211729.592ff5cd@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160826211729.592ff5cd@roar.ozlabs.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org, Segher Boessenkool <segher@kernel.crashing.org>, linux-kbuild@vger.kernel.org, Alan Modra <amodra@gmail.com>, Russell King <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On Friday 26 August 2016, Nicholas Piggin wrote:
> > I still see a problem with big-endian builds failing with
> > thinarc/gc-sections, I'll investigate that some other day,
> > or you could have a look at that if you want to make sure
> > it's an ARM specific problem, not something with your
> > patches in general.
> > 
> > The patch that I sent for enabling the two on ARM blocks
> > out CONFIG_CPU_BIG_ENDIAN, so just revert that hunk to see
> > the problem. It's possible that it only breaks when doing
> > a big-endian build after a little-endian build without
> > a "make clean" inbetween.
> 
> I'm able to build big endian ARM allyesconfig with thin
> archives and gc-sections, worked fine.
> 
> There have been a few bugs in powerpc when failing to notice
> the change when endian of builds was swapped, so maybe you
> got bitten by something similar.

I tracked this down as well now, and it's also a problem on my
local machine, your patches are fine. In order to debug
the other problem, I was building with
"make LD=/home/arnd/..../ld" to try out different
versions of the linker, and that caused the "LD += -EB"
line from arch/arm/Makefile to be ignored.

We should probably override LDFLAGS rather than LD
(and AFLAGS instead of AS) for big-endian builds, but
that is unrelated to your work.

	Arnd
