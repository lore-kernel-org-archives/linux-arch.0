From: Martyn Welch <martyn.welch@ge.com>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing PAGE_KERNEL_NOCACHE
Date: Thu, 23 Jun 2011 13:13:38 +0100
Message-ID: <4E032DF2.20108@ge.com>
References: <20110623114536.GA14011@linux-mips.org> <4E032940.5010205@ge.com> <20110623120234.GA22524@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110623120234.GA22524@linux-mips.org>
Sender: linux-sh-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 23/06/11 13:02, Ralf Baechle wrote:
> On Thu, Jun 23, 2011 at 12:53:36PM +0100, Martyn Welch wrote:
>=20
>> On 23/06/11 12:45, Ralf Baechle wrote:
>>> On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi =
driver turns
>>> into tragedy:
>>>
>>>   CC [M]  drivers/staging/comedi/drivers.o
>>> drivers/staging/comedi/drivers.c: In function =E2=80=98comedi_buf_a=
lloc=E2=80=99:
>>> drivers/staging/comedi/drivers.c:505:41: error: =E2=80=98PAGE_KERNE=
L_NOCACHE=E2=80=99 undeclared (first use in this function)
>>> drivers/staging/comedi/drivers.c:505:41: note: each undeclared iden=
tifier is rep orted only once for each function it appears in
>>> make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
>>>
>>> Restrict the driver to only those architectures that define PAGE_KE=
RNEL_NOCACHE.
>>>
>>> PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as=
 SGI IP27
>>> are even uable to offer uncached operation - at least in the way an=
 unwitting
>>> driver might assume.  I haven't looked in details how the driver is=
 using
>>> the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-sty=
le using
>>> cached memory and the flush_kernel_vmap_range / invalidate_kernel_v=
map_range
>>> APIs in conjunction with the DMA API is a practical alternative.
>>>
>>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>>
>>>  drivers/staging/comedi/Kconfig |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comed=
i/Kconfig
>>> index 1502d80..bccdc12 100644
>>> --- a/drivers/staging/comedi/Kconfig
>>> +++ b/drivers/staging/comedi/Kconfig
>>> @@ -2,6 +2,7 @@ config COMEDI
>>>  	tristate "Data acquisition support (comedi)"
>>>  	default N
>>>  	depends on m
>>> +	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE || =
X86
>>
>> I'm sure I got comedi to compile on a 32-bit PPC board not that long=
 ago. Has
>> something changed, or is this just not an exhaustive list?
>=20
> (Adding the PPC folks to cc.)
>=20
> A "git grep -w PAGE_KERNEL_NOCACHE arch/powerpc/" doesn't find anythi=
ng so
> I don't think the driver will build there.  I don't have a PPC toolch=
ain
> to verify that.

Ah, just found the tree looks like I had a little patch to make it seem=
ingly
work, though it will make it "not work" for most other archs at a guess=
 (it
may not even be right on PPC):

diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/=
drivers.c
index 44d6b62..263ad3d 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -505,7 +505,7 @@ int comedi_buf_alloc(struct comedi_device *dev, str=
uct
comedi_subdevice *s,
                }
                if (i =3D=3D n_pages) {
                        async->prealloc_buf =3D
-                           vmap(pages, n_pages, VM_MAP, PAGE_KERNEL_NO=
CACHE);
+                           vmap(pages, n_pages, VM_MAP, PAGE_KERNEL_NC=
);
                }
                vfree(pages);

(Sorry for the wrapping)

--=20
Martyn Welch (Principal Software Engineer) | Registered in England and
GE Intelligent Platforms                   | Wales (3828642) at 100
T +44(0)127322748                          | Barbirolli Square, Manches=
ter,
E martyn.welch@ge.com                      | M2 3AB  VAT:GB 927559189
