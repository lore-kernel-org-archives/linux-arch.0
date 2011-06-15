From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Wed, 15 Jun 2011 08:39:35 +0100
Message-ID: <20110615073935.GA28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org>
	<987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
	<4DF8359F.10809@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DF8359F.10809@zytor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, "Yu, Fenghua" <fenghua.yu@intel.>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
> On 06/14/2011 03:08 PM, Luck, Tony wrote:
> > I took a look at the back of all my ia64 systems - none of them
> > have a parallel port.  It seems unlikely that new systems will
> > start adding parallel ports :-)
> > 
> > So even if I had a printer (or other device) that used a parallel
> > port, I have no way to test it.
> 
> If it has PCI slots, it can have a parallel port.

Is that a clue about where a select statement should be?
