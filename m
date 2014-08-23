From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for remapping
 PCI I/O bus resources into CPU space
Date: Sat, 23 Aug 2014 11:57:06 -0500
Message-ID: <CAL_JsqLP3K1p3Q-B1rBtdRcRwpWJqCLQaML8uX0EXrX5GcO1CA@mail.gmail.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com> <CAL_JsqK6XiuS7OJ_2F16ySA8oj9AHqP0fAft21AOtJxXP2SqnQ@mail.gmail.com>
 <20140822124326.GL13147@bart.dudau.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140822124326.GL13147-hOhETlTuV5niMG9XS5x8Mg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>
Cc: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 22, 2014 at 7:43 AM, Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org> wrote:
> On Thu, Aug 21, 2014 at 11:16:16PM -0500, Rob Herring wrote:
>> On Tue, Aug 12, 2014 at 11:25 AM, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Introduce a default implementation for remapping PCI bus I/O resources
>> > onto the CPU address space. Architectures with special needs may
>> > provide their own version, but most should be able to use this one.
>> >
>> > Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> > Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> > Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
>>
>> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Thanks, Rob, much appreciated!
>
>>
>> However, I would like to see ARM pci_ioremap_io converted over to this function.
>
> Do you care if this is done as a separate patch?

Yes, that's fine hence the reviewed-by.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
