From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Thu, 4 Jun 2009 12:18:38 -0600
Message-ID: <fa686aa40906041118x1ababaeeuaaca9c6a7e94fcb9@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	<1243964917.4229.54.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1243964917.4229.54.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>, Greg KH <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 2, 2009 at 11:48 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Tue, 2009-06-02 at 11:29 -0600, Grant Likely wrote:
>> One topic that seems to garner debate is the issue of decoupling the
>> kernel image from the target platform. =A0ie. On x86, PowerPC and Sp=
arc
>> a kernel image will boot on any machine (assuming the needed drivers
>> are enabled), but this is rarely the case in embedded. =A0Most embed=
ded
>> kernels require explicit board support selected at compile time with
>> no way to produce a generic kernel which will boot on a whole family
>> of devices, let alone the whole architecture. =A0Part of this is a
>> firmware issue, where existing firmware passes very little in the wa=
y
>> of hardware description to the kernel, but part is also not making
>> available any form of common language for describing the machine.
>
> OK, so my minimal understanding in this area lead me to believe this =
was
> because most embedded systems didn't have properly discoverable busse=
s
> and therefore you had to tailor the kernel configuration exactly to t=
he
> devices the system had.

Yes, mostly true.  The kernel must be explicitly told the layout of
the non-discoverable busses and interconnects.  One method is to use
per-machine statically compiled tables of platform devices, but
nothing forces embedded to do it that way...

>> I think that in the absence of any established standard like the PC
>> BIOS/EFI or a real Open Firmware interface, then the kernel should a=
t
>> least offer a recommended interface so that multiplatform kernels ar=
e
>> possible without explicitly having the machine layout described to i=
t
>> at compile time. =A0I know that some of the embedded distros are
>> interested in such a thing since it gets them away from shipping
>> separate images for each supported board. =A0ie. It's really hard to=
 do
>> a generic live-cd without some form of multiplatform. =A0FDT is a gr=
eat
>> approach, but it probably isn't the only option. =A0It would be wort=
h
>> debating.
>
> It sounds interesting ... however, it also sounds like an area which
> might not impact the core kernel much ... or am I wrong about that? =A0=
The
> topics we're really looking for the Kernel Summit are ones that requi=
re
> cross system input and which can't simply be sorted out by organising=
 an
> Embedded mini-summit.

Hmmm... in reading this thread and thinking about it more, I'm
beginning to think that it might really be a core kernel issue; or at
least a device driver policy one.  Regardless of architecture, at boot
time Linux must use some method to discover the system layout, be it:
1) Reading BIOS/EFI/ACPI/OpenFirmware/FDT data
2) Probing the bus (PCI, USB, etc)
3) Compiled into the kernel (tables of platform devices, machine specif=
ic code)

Many types of devices could be end up being discovered using any of
the above methods.  Ignoring for the time being the complexities and
history of the Linux UART drivers, I'm going to use 16550 serial ports
for an example.  On ARM, a platform device for an 16550 serial port
may be instantiated by machine specific init code, on PowerPC it will
be discovered by a device tree parser, on a PC it could be a legacy
port, and on all three it could hang off a PCI device.  The bus
connection and source of data are different in each case, but the same
core driver will handle all of them.  The real differences are in
discovery and decoding the configuration.

SPI devices (struct spi_device) is possibly a better example.
spi_device drivers that need additional configuration go looking at
the platform_data pointer in the struct device.  This is easy when the
device is hard coded into the kernel because the correct pdata struct
is initialized statically at build time.  When the device is
discovered via one of the other mechanisms, the question remains of
where should the code live that does the translation and fills in the
correct pdata?  The mmc_spi driver handles this by calling out to an
mmc_spi_get_pdata() function (drivers/spi/{mmc_spi,mmc_spi_of}.c.  If
running on an OF platform, mmc_spi_get_pdata() has the knowledge to
decode the device tree data and munge it into the pdata form needed by
the driver.  Both statically compiled and Device Tree described
mmc_spi configurations must be handled, and driver specific decode
methods must exist, but there I don't think there is any desire to
write multiple probe routines for each device driver.  The same issue
stands for i2c, MMIO, and other non-discoverable busses.

=46or drivers which require pdata, writing decode functions is
unavoidable, but it is unclear how to hook in that code with as little
impact on a device driver as possible.  To me the issue is, where
should that code live? and how should it get executed?  (which is why
I think it is a device driver policy issue)  I've used the example of
OF device tree bindings vs. static configuration, but it applies just
as readily to something like UEFI (ie. I see that ARM is a member of
the UEFI forum).  Here are some of my unsorted thoughts on the issue:

- Translation code is driver specific, so it should live as part of,
or in the vicinity of, the driver it works with
- My guess is that The Future(tm) will probably bring more methods of
describing machine configuration, not less;  It is worth debating now
about how to have multiple decoders for a single device driver.
- Devices on non-discoverable busses appear in both desktop and
embedded machines.  (sensors anyone?)  This is not just an embedded
issue.
- driver authors will probably implement only the decode methods that
they actually need.  It is likely that different people will develop
additional decoders.  These will need to co-exist peacefully.
- Some things are just hard and just require machine specific setup
code.  Things like weird CS selections on SPI busses, or clock
routing.  Decoding to pdata won't always be feasible and sometime
machine specific hooks must be used.  Need a method for machine setup
code to provide pdata.
- Binding algorithms are problematic.  Naming convention in the data
source won't always match Linux internal kernel naming so there must
be some logic for matching to the correct drivers.  Currently, an
exceptions table is used for i2c and spi busses (drivers/of/base.c:
of_modalias_table).  There aren't many entries in there now, but I'm
not sure it is a scalable solution in the long term.

And some possible approaches:
1) One option is to link a list of per-device decoder methods into the
kernel so that generic bus discovery code and call the correct pdata
decoder for each device when it is discovered.  Doing this ensures
that pdata is available before the driver's probe method is called and
completely isolates the driver code from the decode method.  However,
it also means that the entire list of decoders must be statically
linked into the kernel, and it is of no use at all to out-of-tree
drivers because it provides no method of linking in additional decode
hooks.  Many drivers used to do this in arch/powerpc, but we moved
away from it for the problems listed above.
2) It could be handled with wrapper drivers which have their own
struct device and get bound to data elements within the Device Tree or
other data source.  The wrapper driver could generate the pdata and
register a child platform device which gets bound to the generic
driver.  Doing it this way lets a decode method live in a module.
This works well for things which are currently struct platform_device,
and ensures that all data is available at driver probe time, but
doesn't fit well into the structure of other bus types (SPI, I2C,
MDIO, etc) without creating an indirection layer for decoding on each
bus.  It also means that for every real device, 2 struct device get
registered; one to bind against the decoder, and one to bind against
the real driver.  Maybe this isn't a significant memory consumption;
but it doesn't *feel* right to me.
3) The decoders could be linked into the drivers themselves.  The
mmc_spi driver uses this approach, though it is a bit crude, and the
mmc_spi_get_pdata routine must be modified for each.  I've been
thinking about the possibility of have a decoder function list
attached to the driver and use a common helper function to walk the
list until one of them is able to provide valid pdata.  This would
keep the decode method with the device driver (where it belongs
IMNSHO), but minimize the impact on the core of the driver as a whole
(only a function would be added).  But, this is still impact on the
driver which there may be resistance to.
4) write separate probe() routines for each type of discovery (static
pdata, device tree, etc).  Solves same problems as 3, but I think
results in more code and possibly a bunch of #ifdef'ry
5) other options I haven't thought of? ....

All of this options listed above have been talked about and
implemented to a lesser or greater degree without really coming to
much of a conclusion on how it should be approached and what the
impact on device drivers will be.  It is worth some debate.

> Now if flattened device tree could help us out with BIOS, ACPI, EFI a=
nd
> the other myriad boot and identification standards that seem designed=
 to
> hide system information rather than reveal it, then we might be all
> ears ...

:-)

Interesting, but probably not much help here.  This would just be
translating (and imperfectly at that) from one machine representation
to another without a whole lot of benefit.  It is conceivable that
data sourced from multiple locations (probing, ACPI, EFI, and known
quirks) could be all funneled into a single FDT image and then that
data used for creating and registering device structures, but I don't
really see any benefit here.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
