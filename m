From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Wed, 25 Nov 2015 10:54:08 -0800
Message-ID: <CAPcyv4ieSjx=ROm2t6ABXmgP-YEOq7MZFCMoyiMU02x49BXN9w@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
	<20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
	<20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
	<CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
	<20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
	<CAPcyv4jtWocaoocfzvpHgR=0mg0GPo7-nBrzkARQpTz6=oAupg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35602 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbKYSyK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2015 13:54:10 -0500
Received: by wmuu63 with SMTP id u63so150068902wmu.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2015 10:54:08 -0800 (PST)
In-Reply-To: <CAPcyv4jtWocaoocfzvpHgR=0mg0GPo7-nBrzkARQpTz6=oAupg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 24, 2015 at 5:28 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Nov 24, 2015 at 4:47 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Tue, 24 Nov 2015 16:34:19 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> > IOW, a very good description of the problem-being-solved would help out
>>> > a lot here...
>>>
>>> I'll fold the eventual result of this discussion into the changelog if
>>> I can convince you it's worth moving forward.
>>
>> I'm easily convinced ;) Please let's get all the info into the right
>> place, make sure it answers the thus-far-asked questions (at least) and
>> we'll take it from there.
>>
>> And please do have a think about switching as much as possible over to
>> runtime-configurability.  Because "please echo foo > /proc" is a heck
>> of a lot nicer than "please reboot with iomem=" which is a heck of a lot
>> nicer than "please ask vendor for a new kernel".
>
> Actually, we already have runtime configuration.  For example, if you
> want to muck with pmem via /dev/mem, just do this first:
>
>     echo namespace0.0 > /sys/bus/nd/drivers/nd_pmem/unbind

Here's the summary of the thread that I will add to the changelog:

---

In general if a device driver is busily using a memory region it
already informs other parts of the kernel to not touch it via
request_mem_region().  /dev/mem should honor the same safety
restriction by default.  Debugging a device driver from userspace
becomes more
difficult with this enabled.  Any application using /dev/mem or mmap
of sysfs pci resources will now need to perform the extra step of
either:

1/ Disabling the driver, for example:

  echo <device id> > /dev/bus/<parent bus>/drivers/<driver name>/unbind

2/ Rebooting with "iomem=relaxed" on the command line

3/ Recompiling with CONFIG_IO_STRICT_DEVMEM=n

Traditional users of /dev/mem like dosemu are unaffected because the
first 1MB of memory is not subject to the IO_STRICT_DEVMEM
restriction.
Legacy X configurations use /dev/mem to talk to graphics hardware, but
that functionality has since moved to kernel graphics drivers.
