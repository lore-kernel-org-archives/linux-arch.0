From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Tue, 24 Nov 2015 16:34:19 -0800
Message-ID: <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
	<20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
	<20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38395 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbbKYAeV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 19:34:21 -0500
Received: by wmec201 with SMTP id c201so49428773wme.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2015 16:34:20 -0800 (PST)
In-Reply-To: <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 24, 2015 at 2:25 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 23 Nov 2015 16:06:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
>> This effectively promotes IORESOURCE_BUSY to IORESOURCE_EXCLUSIVE
>> semantics by default.  If userspace really believes it is safe to access
>> the memory region it can also perform the extra step of disabling an
>> active driver.  This protects device address ranges with read side
>> effects and otherwise directs userspace to use the driver.
>
> I don't think I'm sufficiently understanding what this is all needed
> for, sorry.  A better changelog would help: what's wrong with the
> current code, how you propose it be changed, how the kernel's
> externally-visible behaviour is altered, etc.
>

I should have duplicated the Kconfig description for IO_STRICT_DEVMEM
in the changelog, but the justification is simply that if the kernel
has a driver busily using a memory range, userspace needs to assert it
knows it is safe to access that range by disabling the driver.  This
makes the kernel safer by default.

> Please pay particular attention to the back-compatibility issues which
> will be encountered when people enable these options.

It certainly diminishes debug capabilities, mmap of sysfs pci
resources will also fail while a driver is active.  The only general
purpose application I know that uses /dev/mem is dosemu.  It should
continue to work fine as x86 "devmem_is_allowed()" permits access from
0-to-1MB by default.  The other stated user of /dev/mem legacy X
drivers.  With the prevalence of kernel modesetting in graphics
drivers I don't know how much of a concern this is anymore.

> Perhaps when all that material is described, I'll understand why the
> heck we're doing this with a build-time switch rather than a runtime
> one...

We have the "iomem=" kernel parameter.  I think it makes sense to have
that setting be configurable at runtime to augment this build time
decision.

>> Persistent memory presents a large "mistake surface" to /dev/mem as now
>> accidental writes can corrupt a filesystem.
>
> Is that the motivation?  root can come in and accidentally alter
> persistent memory contents?  If so,
>
> - why do we care?  There are all sorts of ways in which root can muck
>   up the persistent memory, starting with dd(1).  What's special about
>   /dev/mem?

dd through /dev/pmem and the driver will do all the proper flushing
and syncing to make the writes durable on media.  /dev/mem knows none
of those semantics.  /dev/pmem as a block device responds to O_EXCL
and prevents other attempts to open the device.

> - why is the patch mucking with access to PCI and BIOS space?  Is the
>   persistent memory even mappable in those regions?  Or is the concern
>   that userspace can access control registers associated with the
>   persistent memory?  What is the problem scenario?

It seems to me that letting /dev/mem do arbitrary access to any region
of memory is a dangerous capability for a production environment.
Drivers assume that request_mem_region() tells other parts of the
kernel to not touch their memory.  Having the option to extend that
protection to /dev/mem by default seemed a reasonable idea.

Of course, all of this assumes that you think it is worthwhile to have
some protections and safety measures even for root.

> IOW, a very good description of the problem-being-solved would help out
> a lot here...

I'll fold the eventual result of this discussion into the changelog if
I can convince you it's worth moving forward.

I also have the option of just tagging the pmem regions as
IORESOURCE_EXCLUSIVE, but I decided against that because I think our
current definition of STRICT_DEVMEM leaves a big hole if the goal is
"/dev/mem access is safe by default".
