From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing
	PAGE_KERNEL_NOCACHE
Date: Thu, 23 Jun 2011 16:05:57 +0100
Message-ID: <20110623150557.GA9258@linux-mips.org>
References: <20110623114536.GA14011@linux-mips.org> <4E032940.5010205@ge.com>
	<20110623120234.GA22524@linux-mips.org>
	<8B77EED3-D197-4AB9-9594-278DB7002D6D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <8B77EED3-D197-4AB9-9594-278DB7002D6D@kernel.crashing.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: devel@driverdev.osuosl.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Martyn Welch <martyn.welch@ge.com>, Fenghua Yu <fenghua.yu@intel.com>, "linuxppc-dev@lists.ozlabs.org Tony Luck" <tony.luck@intel.com>, linux-am33-list@redhat.com, Paul Mackerras <paulus@samba.org>, linux-m32r-ja@ml.linux-m32r.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 23, 2011 at 07:10:29AM -0500, Kumar Gala wrote:

> > (Adding the PPC folks to cc.)
> > 
> > A "git grep -w PAGE_KERNEL_NOCACHE arch/powerpc/" doesn't find anything so
> > I don't think the driver will build there.  I don't have a PPC toolchain
> > to verify that.
> 
> I can verify it fails on PPC as well:
> 
> drivers/staging/comedi/drivers.c: In function 'comedi_buf_alloc':
> drivers/staging/comedi/drivers.c:505:37: error: 'PAGE_KERNEL_NOCACHE' undeclared (first use in this function)
> drivers/staging/comedi/drivers.c:505:37: note: each undeclared identifier is reported only once for each function it appears in
> 
> However, we do have a #define for PAGE_KERNEL_NC.

Do you think this driver in it's current stage is so valuable that some
ifdefery to get it to work on PPC is the way to go?

IA-64 has PAGE_KERNEL_UC, so basically the same question for IA-64, too.

But preferably the driver should be sorted out properly and until the v1
of my patch which disables it on all architectures that don't provide a
PAGE_KERNEL_NOCACHE definition will do just fine.

  Ralf
