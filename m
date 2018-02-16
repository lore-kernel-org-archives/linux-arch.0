From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Fri, 16 Feb 2018 14:48:46 +0000
Message-ID: <fa1cadea-6127-2526-449c-3eed3d4c3041@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com>
 <CAHp75Ve7C4AJYK6AC=o-jzw6b2p8c8GBRd70Zjv+vYWbfytufg@mail.gmail.com>
 <adfa2009-476b-8c25-c661-b0eeb48a6c43@huawei.com>
 <CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com>
 <59e5293f-0ea5-12f4-27db-b13bbcf0918b@huawei.com>
 <CAHp75VeTQg+A9o5Ox-k_9Qx8=JPEnqg1taVjcd8Zd2rfj_TMog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VeTQg+A9o5Ox-k_9Qx8=JPEnqg1taVjcd8Zd2rfj_TMog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dann Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>, devic
List-Id: linux-arch.vger.kernel.org

On 16/02/2018 14:42, Andy Shevchenko wrote:
> On Thu, Feb 15, 2018 at 7:07 PM, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>> On 14/02/2018 16:16, Andy Shevchenko wrote:
>
>>>>>>>>> +       list_for_each_entry(rentry, &resource_list, node)
>>>>>>>>> +               resources[count++] = *rentry->res;
>>>>>
>>>>>>> It has similarities with acpi_create_platform_device().
>>>>>>> I guess we can utilize existing code.
>>>>
>>>>> For sure, this particular segment is effectively same as part of
>>>>> acpi_create_platform_device():
>>>
>>> Not the same, acpi_create_platform_device() does a bit more than
>>> copying the resources. If it indeed makes no hurt...
>>>
>>>>>         list_for_each_entry(rentry, &resource_list, node)
>>>>>             acpi_platform_fill_resource(adev, rentry->res,
>>>>>                             &resources[count++]);
>>>>> So is your idea to refactor this common segment into a helper function?
>>>
>>> ...I would go with helper.
>>>
>>
>> Hi Andy,
>>
>> Since the plan now is that this code is no longer going to be added to
>> drivers/acpi, but instead pushed to the LLDD, I am pondering whether we
>> should still factor out of this common code. Opinion?
>
> I would still go with a common helper. Though, as first step, we can
> make it lazy, i.e. put a comment in your code, like a todo notice (w/o
> TODO word :-) ) to consider a common helper.

Fine, I was also thinking that I don't want to do this now as it could 
make merging the patchset more complex. For now, the ACPI change I plan 
creates no dependencies.

Cheers,
John

>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
