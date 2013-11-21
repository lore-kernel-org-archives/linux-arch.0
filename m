From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Thu, 21 Nov 2013 14:42:27 +0100
Message-ID: <CAMuHMdXfsB_Ewz9sUPZaAjFaQGTGeqMiD8mJ0tCoH1uFLYGoxw@mail.gmail.com>
References: <5283A000.8090007@gmail.com>
	<1384859554-27268-1-git-send-email-geert@linux-m68k.org>
	<20131121122148.1B43DC40A2C@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131121122148.1B43DC40A2C@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 1:21 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>  bool __init early_init_dt_scan(void *params)
>>  {
>> -     if (!params)
>> -             return false;
>> -
>>       /* Setup flat device-tree pointer */
>>       initial_boot_params = params;
>>
>> -     /* check device tree validity */
>> -     if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
>> -             initial_boot_params = NULL;
>> -             return false;
>> +     /* check passed device tree validity */
>> +     if (initial_boot_params &&
>> +         be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
>> +             pr_info("FDT at %p\n", initial_boot_params);
>> +             goto found;
>> +     }
>> +
>> +     /* check built-in device tree validity */
>> +     initial_boot_params = &__dtb_start;
>> +     if (__dtb_end != (void *)&__dtb_start &&
>> +         be32_to_cpu(initial_boot_params->magic) == OF_DT_HEADER) {
>> +             pr_info("Compiled-in FDT at %p\n", initial_boot_params);
>> +             goto found;
>
> __dtb_start is in an init section which is discarded after initcalls.
> For this to work, the dtb needs to be copied into a region of allocated

My changes don't change the current behavior much: currently
early_init_dt_scan() is already called with &__dtb_start in several places.
If this is broken, it's already broken.

> memory. The dtb section can also potentially contain multiple .dtb
> blobs. In the use case that you care about you are probably only

Multiple dtb blobs are currently handled in platform-specific code, which
passes the right dtb to early_init_dt_scan().

> thinking about one, but it is entirely possible for device drivers to
> have a dtb linked in which may break this if it gets linked in a
> different order. The specific example I'm thinking about is I want to
> have the DT selftest code load an overlay to get testcase data from a
> dtb blob.
>
> The other concern I have here is that I don't really want this to be the
> default on a lot of platforms. ARM and PowerPC for instance should only
> get the default dtb from the boot wrapper. It needs to be configurable
> in some way.

On ARM and PowerPC, the section is empty, hence &__dbt_start ==
&__dtb_end.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
