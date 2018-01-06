From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 12/18] Thermal/int340x: prevent bounds-check bypass via
 speculative execution
Date: Sat, 06 Jan 2018 09:24:35 -0800
Message-ID: <1515259475.23948.15.camel@linux.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
         <151520105920.32271.1091443154687576996.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1515203635.26317.78.camel@linux.intel.com>
         <CAPcyv4iNJrcKBiN+3=ZZ1MHU1PYbt4rLDLgWZY5Kc+O8regDYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4iNJrcKBiN+3=ZZ1MHU1PYbt4rLDLgWZY5Kc+O8regDYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 2018-01-05 at 17:57 -0800, Dan Williams wrote:
> On Fri, Jan 5, 2018 at 5:53 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Fri, 2018-01-05 at 17:10 -0800, Dan Williams wrote:
> > > 
> > > Static analysis reports that 'trip' may be a user controlled
> > > value
> > > that
> > > is used as a data dependency to read '*temp' from the 'd-
> > > >aux_trips'
> > > array.  In order to avoid potential leaks of kernel memory
> > > values,
> > > block
> > > speculative execution of the instruction stream that could issue
> > > reads
> > > based on an invalid value of '*temp'.
> > Not against the change as this is in a very slow path. But the trip
> > is
> > not an arbitrary value which user can enter.
> > 
> > This trip value is the one of the sysfs attribute in thermal zone.
> > For
> > example
> > 
> > # cd /sys/class/thermal/thermal_zone1
> > # ls trip_point_?_temp
> > trip_point_0_temp  trip_point_1_temp  trip_point_2_temp  trip_point
> > _3_t
> > emp  trip_point_4_temp  trip_point_5_temp  trip_point_6_temp
> > 
> > Here the "trip" is one of the above trip_point_*_temp. So in this
> > case
> > it can be from 0 to 6 as user can't do
> > # cat trip_point_7_temp
> > as there is no sysfs attribute for trip_point_7_temp.
> > 
> > The actual "trip" was obtained in thermal core via
> > 
> >       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) !=
> > 1)
> >                 return -EINVAL;
> > 
> > Thanks,
> > Srinivas
> Ah, great, thanks. So do we even need the bounds check at that point?
We are not bound checking but the way we identify type of the trip.
Based on ACPI support we order trips:
- Aux trips max_count = aux_trip_nr
- One Critical trip
- One Hot trip
- One passive trip
- Rest all trips are active trips

So in the above example if d->aux_trip_nr is 1 then trip_point_0_temp
read/write is for aux trip. If d->aux_trip_nr is 0 then it can be any
other non aux trip.

BUT I am not still up to date with these attacks. Not sure about the
perimeter of user controlled value. It is a user controlled but limited
by the sysfs attributes. So I will test this patch and let you know if
there are any issues.

Thanks,
Srinivas
 
