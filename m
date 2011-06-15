From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Wed, 15 Jun 2011 07:36:34 -0700
Message-ID: <20110615143634.GA12757@ericsson.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
	<20110614223404.GA30057@linux-mips.org>
	<4DF8329C.7000904@zytor.com>
	<20110615083437.GA32624@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110615083437.GA32624@linux-mips.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 15, 2011 at 04:34:37AM -0400, Ralf Baechle wrote:
> On Tue, Jun 14, 2011 at 09:18:36PM -0700, H. Peter Anvin wrote:
> 
> > On 06/14/2011 03:34 PM, Ralf Baechle wrote:
> > > 
> > > There is no point in offering to build something that couldn't possibly be
> > > used.  It just makes the kernel harder to configure and inflates the test
> > > matrix for no good reason.
> > > 
> > 
> > I see... that's why a bunch of devices that only exist on ARM and MIPS
> > SoCs are offered on x86 platforms?
> 
> Well, if you notice one of those, yell.  Or send patches.  Most of those
> have been fixed.
> 
I think he was being sarcastic, and wanted to say that it should be that way.

Guenter
