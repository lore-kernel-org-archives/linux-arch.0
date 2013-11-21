From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Thu, 21 Nov 2013 11:38:26 -0600
Message-ID: <CAL_JsqJVteJuaD0PRMHSR9cVcMJTSNj4wXtYiftG=-pYSR9vsQ@mail.gmail.com>
References: <5283A000.8090007@gmail.com>
	<1384859554-27268-1-git-send-email-geert@linux-m68k.org>
	<20131121122148.1B43DC40A2C@trevor.secretlab.ca>
	<CAMuHMdXfsB_Ewz9sUPZaAjFaQGTGeqMiD8mJ0tCoH1uFLYGoxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXfsB_Ewz9sUPZaAjFaQGTGeqMiD8mJ0tCoH1uFLYGoxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 7:42 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Thu, Nov 21, 2013 at 1:21 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>>  bool __init early_init_dt_scan(void *params)
>>>  {
>>> -     if (!params)
>>> -             return false;
>>> -
>>>       /* Setup flat device-tree pointer */
>>>       initial_boot_params = params;
>>>
>>> -     /* check device tree validity */
>>> -     if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
>>> -             initial_boot_params = NULL;
>>> -             return false;
>>> +     /* check passed device tree validity */
>>> +     if (initial_boot_params &&
>>> +         be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
>>> +             pr_info("FDT at %p\n", initial_boot_params);
>>> +             goto found;
>>> +     }
>>> +
>>> +     /* check built-in device tree validity */
>>> +     initial_boot_params = &__dtb_start;
>>> +     if (__dtb_end != (void *)&__dtb_start &&
>>> +         be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
>>> +             pr_info("Compiled-in FDT at %p\n", initial_boot_params);
>>> +             goto found;
>>
>> __dtb_start is in an init section which is discarded after initcalls.
>> For this to work, the dtb needs to be copied into a region of allocated
>
> My changes don't change the current behavior much: currently
> early_init_dt_scan() is already called with &__dtb_start in several places.
> If this is broken, it's already broken.

Agreed. The early scan is already done in the init section.

>> memory. The dtb section can also potentially contain multiple .dtb
>> blobs. In the use case that you care about you are probably only
>
> Multiple dtb blobs are currently handled in platform-specific code, which
> passes the right dtb to early_init_dt_scan().
>

Agreed. Arches can still do however complicated dtb search they want.
This handles the common, default case.

>> thinking about one, but it is entirely possible for device drivers to
>> have a dtb linked in which may break this if it gets linked in a
>> different order. The specific example I'm thinking about is I want to
>> have the DT selftest code load an overlay to get testcase data from a
>> dtb blob.
>>
>> The other concern I have here is that I don't really want this to be the
>> default on a lot of platforms. ARM and PowerPC for instance should only
>> get the default dtb from the boot wrapper. It needs to be configurable
>> in some way.
>
> On ARM and PowerPC, the section is empty, hence &__dbt_start ==
> &__dtb_end.

The build rules for built-in dtbs are architecture specific already,
so I don't see a need to make this code configurable at this point.

I really don't like saying one arch can have built-in dtb and another
one can't. Either we allow it or we don't. If this is a bad feature,
then why did we let multiple arches implement it.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
