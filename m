From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 04/12] PCI: OF: Fix the conversion of IO ranges into IO resources.
Date: Thu, 21 Aug 2014 23:08:48 -0500
Message-ID: <CAL_JsqJm6qWNdrJ2F8xddFUj46y42n6hQVu1nkTaA-5Tbg--XQ@mail.gmail.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com> <1407860725-25202-5-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407860725-25202-5-git-send-email-Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 12, 2014 at 11:25 AM, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org> wrote:
> The ranges property for a host bridge controller in DT describes
> the mapping between the PCI bus address and the CPU physical address.
> The resources framework however expects that the IO resources start
> at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
> The conversion from pci ranges to resources failed to take that into account.
>
> In the process move the function into drivers/of/address.c as it now
> depends on pci_address_to_pio() code and make it return an error code.
>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Humm, this says I'm cc'ed, but I'm not which defeats the point of
recording the Cc's in the commit.

I still have the same concerns that this will break existing users.
Are you sure integrator is the only platform affected?

Rob

> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/of/address.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_address.h | 13 ++-----------
>  2 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 4dab700..3735ac7 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -906,3 +906,49 @@ bool of_dma_is_coherent(struct device_node *np)
>         return false;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> +
> +/*
> + * of_pci_range_to_resource - Create a resource from an of_pci_range
> + * @range:     the PCI range that describes the resource
> + * @np:                device node where the range belongs to
> + * @res:       pointer to a valid resource that will be updated to
> + *              reflect the values contained in the range.
> + *
> + * Returns EINVAL if the range cannot be converted to resource.
> + *
> + * Note that if the range is an IO range, the resource will be converted
> + * using pci_address_to_pio() which can fail if it is called too early or
> + * if the range cannot be matched to any host bridge IO space (our case here).
> + * To guard against that we try to register the IO range first.
> + * If that fails we know that pci_address_to_pio() will do too.
> + */
> +int of_pci_range_to_resource(struct of_pci_range *range,
> +       struct device_node *np, struct resource *res)
> +{
> +       int err;
> +       res->flags = range->flags;
> +       res->parent = res->child = res->sibling = NULL;
> +       res->name = np->full_name;
> +
> +       if (res->flags & IORESOURCE_IO) {
> +               unsigned long port = -1;
> +               err = pci_register_io_range(range->cpu_addr, range->size);
> +               if (err)
> +                       goto invalid_range;
> +               port = pci_address_to_pio(range->cpu_addr);
> +               if (port == (unsigned long)-1) {
> +                       err = -EINVAL;
> +                       goto invalid_range;
> +               }
> +               res->start = port;
> +       } else {
> +               res->start = range->cpu_addr;
> +       }
> +       res->end = res->start + range->size - 1;
> +       return 0;
> +
> +invalid_range:
> +       res->start = (resource_size_t)OF_BAD_ADDR;
> +       res->end = (resource_size_t)OF_BAD_ADDR;
> +       return err;
> +}
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 28e6836..6015f21 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -23,17 +23,8 @@ struct of_pci_range {
>  #define for_each_of_pci_range(parser, range) \
>         for (; of_pci_range_parser_one(parser, range);)
>
> -static inline void of_pci_range_to_resource(struct of_pci_range *range,
> -                                           struct device_node *np,
> -                                           struct resource *res)
> -{
> -       res->flags = range->flags;
> -       res->start = range->cpu_addr;
> -       res->end = range->cpu_addr + range->size - 1;
> -       res->parent = res->child = res->sibling = NULL;
> -       res->name = np->full_name;
> -}
> -
> +extern int of_pci_range_to_resource(struct of_pci_range *range,
> +               struct device_node *np, struct resource *res);
>  /* Translate a DMA address from device space to CPU space */
>  extern u64 of_translate_dma_address(struct device_node *dev,
>                                     const __be32 *in_addr);
> --
> 2.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
