From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
Date: Wed, 19 Apr 2017 08:38:34 +1000
Message-ID: <1492555114.25766.93.camel@kernel.crashing.org>
References: <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
 <1492044780.7236.87.camel@kernel.crashing.org>
 <20170418085732.GA23882@red-moon>
 <1492511808.25766.91.camel@kernel.crashing.org>
 <20170418110350.GA1941@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170418110350.GA1941@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua>
List-Id: linux-arch.vger.kernel.org

On Tue, 2017-04-18 at 12:03 +0100, Lorenzo Pieralisi wrote:
> > The above would effectively disable mmap'ing of IO space for any
> > architecture that doesn't have pgprot_nonposted... so everybody
> > except
> > ARM. Thus breaking a number of systems that have been working fine
> > for
> > years.
> 
> pci_remap_iospace() is used on ARM/ARM64 only AFAICT I do not
> understand
> what I would actually break (and I am not sure at all how well PCI IO
> space is tested on ARM/ARM64 machines anyway).

My bad, I incorrectly assumed you were hacking the generic sysfs PCI
mapping.

Cheers,
Ben.
