From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Date: Wed, 18 Mar 2020 10:44:16 +0100
Message-ID: <CAK8P3a2fzFdXoMKz_-Bryq0HUar=Tgs7SwJL4JFw2_KjzpOPdg@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
 <CAK8P3a0+uBsurfQ4smjPDGkJQSkMe-TxJ4cWR_EZXgDR4-bAWQ@mail.gmail.com> <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:50683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgCRJof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 05:44:35 -0400
In-Reply-To: <MW2PR2101MB1052281E5B197F2AA8E4D622D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@>

On Wed, Mar 18, 2020 at 1:18 AM Michael Kelley <mikelley@microsoft.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:30 AM
> >
> > As you are effectively adding a new clocksource driver here, please move the
> > code to drivers/clocksource and send the patch to the respective maintainers
> > (added to Cc here), splitting it out from the rest of the patch.
> >
> > You should also describe why your platform doesn't just use the normal
> > architected timer interface.
> >
> > > +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
> >
> > This looks like it registers a driver for the same device as the normal
> > arch timer. Won't that clash?
>
> There is a Hyper-V clocksource driver in drivers/clocksource/hyperv_timer.c.
> It is architecture independent and works for both x86 and ARM64.
>
> The requirement here is really for a place to hang the general Hyper-V
> initialization code.   On the x86 side, there's infrastructure already in place
> to do hypervisor initialization, but nothing corresponding on the ARM64 side.
> The TIMER_ACPI_DECLARE hook is admittedly a temporary approach, and I'm
> happy to hear if someone has a better way to handle this.
>
> FWIW, Hyper-V doesn't currently virtualize the ARM arch counter/timer for
> guest VMs.  The Hyper-V synthetic counter/timer in the Hyper-V clocksource
> driver is used on both ARM64 and x86.  But this Hyper-V init code doesn't actually
> touch the GTDT device, so it won't interfere with the ARM arch counter/timer
> when a future Hyper-V version does virtualize it.

I don't have a good idea to solve it, just a few more thoughts:

- if your platform does not actually provide the generic timer, then the
  ACPI tables should not list one either. Instead, create a separate
  description for your custom timer, and have that added to the ACPI
  spec.

- To treat the timer more like a normal driver, better have the
   TIMER_ACPI_DECLARE() function live only in the driver itself,
   and use an early initcall (arch_initcall, subsys_initcall, etc)
   it initialize the rest as late as you can.

- Some of the other code added to arch/arm64/ might be able to
  live in drivers/virt/hyperv in order to be shared between x86 and
  arm64. (No idea how much of it there is).

       Arnd
