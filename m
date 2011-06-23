From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing
	PAGE_KERNEL_NOCACHE
Date: Thu, 23 Jun 2011 07:10:29 -0500
Message-ID: <8B77EED3-D197-4AB9-9594-278DB7002D6D@kernel.crashing.org>
References: <20110623114536.GA14011@linux-mips.org> <4E032940.5010205@ge.com>
	<20110623120234.GA22524@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110623120234.GA22524@linux-mips.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: devel@driverdev.osuosl.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Martyn Welch <martyn.welch@ge.com>, linux-am33-list@redhat.com, Paul Mackerras <paulus@samba.org>, linux-m32r-ja@ml.linux-m32r.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org


On Jun 23, 2011, at 7:02 AM, Ralf Baechle wrote:

> On Thu, Jun 23, 2011 at 12:53:36PM +0100, Martyn Welch wrote:
> =

>> On 23/06/11 12:45, Ralf Baechle wrote:
>>> On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi driv=
er turns
>>> into tragedy:
>>> =

>>>  CC [M]  drivers/staging/comedi/drivers.o
>>> drivers/staging/comedi/drivers.c: In function =91comedi_buf_alloc=92:
>>> drivers/staging/comedi/drivers.c:505:41: error: =91PAGE_KERNEL_NOCACHE=
=92 undeclared (first use in this function)
>>> drivers/staging/comedi/drivers.c:505:41: note: each undeclared identifi=
er is rep orted only once for each function it appears in
>>> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
>>> =

>>> Restrict the driver to only those architectures that define PAGE_KERNEL=
_NOCACHE.
>>> =

>>> PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as SGI=
 IP27
>>> are even uable to offer uncached operation - at least in the way an unw=
itting
>>> driver might assume.  I haven't looked in details how the driver is usi=
ng
>>> the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-style u=
sing
>>> cached memory and the flush_kernel_vmap_range / invalidate_kernel_vmap_=
range
>>> APIs in conjunction with the DMA API is a practical alternative.
>>> =

>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>> =

>>> drivers/staging/comedi/Kconfig |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>> =

>>> diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kc=
onfig
>>> index 1502d80..bccdc12 100644
>>> --- a/drivers/staging/comedi/Kconfig
>>> +++ b/drivers/staging/comedi/Kconfig
>>> @@ -2,6 +2,7 @@ config COMEDI
>>> 	tristate "Data acquisition support (comedi)"
>>> 	default N
>>> 	depends on m
>>> +	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE || X86
>> =

>> I'm sure I got comedi to compile on a 32-bit PPC board not that long ago=
. Has
>> something changed, or is this just not an exhaustive list?
> =

> (Adding the PPC folks to cc.)
> =

> A "git grep -w PAGE_KERNEL_NOCACHE arch/powerpc/" doesn't find anything so
> I don't think the driver will build there.  I don't have a PPC toolchain
> to verify that.

I can verify it fails on PPC as well:

drivers/staging/comedi/drivers.c: In function 'comedi_buf_alloc':
drivers/staging/comedi/drivers.c:505:37: error: 'PAGE_KERNEL_NOCACHE' undec=
lared (first use in this function)
drivers/staging/comedi/drivers.c:505:37: note: each undeclared identifier i=
s reported only once for each function it appears in

However, we do have a #define for PAGE_KERNEL_NC.

- k
