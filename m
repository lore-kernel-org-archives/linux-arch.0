From: Paul Gortmaker <paul.gortmaker@gmail.com>
Subject: Re: [PATCH 68/73] drivers/cpufreq: delete non-required instances of <linux/init.h>
Date: Wed, 22 Jan 2014 04:17:59 -0500
Message-ID: <CAP=VYLodPTc4Cum+bqwA927g11-BNOtSo=fs_UKt+jFEc3ABKw@mail.gmail.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-69-git-send-email-paul.gortmaker@windriver.com>
	<CAKohpo=oWrX2SF5GWYoGzC+cuZeOx_wappTFfOy9vCpBush+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=oWrX2SF5GWYoGzC+cuZeOx_wappTFfOy9vCpBush+BQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 1/21/14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22 January 2014 02:53, Paul Gortmaker <paul.gortmaker@windriver.com>
> wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one driver to the next.
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: cpufreq@vger.kernel.org
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/cpufreq/omap-cpufreq.c    | 1 -
>>  drivers/cpufreq/powernow-k8.c     | 1 -
>>  drivers/cpufreq/s3c2412-cpufreq.c | 1 -
>>  drivers/cpufreq/s3c2440-cpufreq.c | 1 -
>>  drivers/cpufreq/spear-cpufreq.c   | 1 -
>>  drivers/cpufreq/speedstep-lib.c   | 1 -
>>  6 files changed, 6 deletions(-)
>
> We have discussed this in past where I pointed out this file is required
> by stuff like module_init, what happened to that query ?

Patch 31/73 relocates module_init and similar macros to
module.h so that is no longer an implicit dependency.

https://lkml.org/lkml/2014/1/21/488

Thanks,
Paul
--

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
