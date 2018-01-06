From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 12/18] Thermal/int340x: prevent bounds-check bypass via
 speculative execution
Date: Fri, 5 Jan 2018 17:57:18 -0800
Message-ID: <CAPcyv4iNJrcKBiN+3=ZZ1MHU1PYbt4rLDLgWZY5Kc+O8regDYw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520105920.32271.1091443154687576996.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1515203635.26317.78.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:43616 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753494AbeAFB5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jan 2018 20:57:19 -0500
Received: by mail-oi0-f52.google.com with SMTP id f69so4242838oig.10
        for <linux-arch@vger.kernel.org>; Fri, 05 Jan 2018 17:57:19 -0800 (PST)
In-Reply-To: <1515203635.26317.78.camel@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Fri, Jan 5, 2018 at 5:53 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2018-01-05 at 17:10 -0800, Dan Williams wrote:
>> Static analysis reports that 'trip' may be a user controlled value
>> that
>> is used as a data dependency to read '*temp' from the 'd->aux_trips'
>> array.  In order to avoid potential leaks of kernel memory values,
>> block
>> speculative execution of the instruction stream that could issue
>> reads
>> based on an invalid value of '*temp'.
>
> Not against the change as this is in a very slow path. But the trip is
> not an arbitrary value which user can enter.
>
> This trip value is the one of the sysfs attribute in thermal zone. For
> example
>
> # cd /sys/class/thermal/thermal_zone1
> # ls trip_point_?_temp
> trip_point_0_temp  trip_point_1_temp  trip_point_2_temp  trip_point_3_t
> emp  trip_point_4_temp  trip_point_5_temp  trip_point_6_temp
>
> Here the "trip" is one of the above trip_point_*_temp. So in this case
> it can be from 0 to 6 as user can't do
> # cat trip_point_7_temp
> as there is no sysfs attribute for trip_point_7_temp.
>
> The actual "trip" was obtained in thermal core via
>
>       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
>                 return -EINVAL;
>
> Thanks,
> Srinivas

Ah, great, thanks. So do we even need the bounds check at that point?
