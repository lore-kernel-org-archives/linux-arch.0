From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2 1/2] gpio / CrystalCove: support virtual GPIO
Date: Fri, 26 Sep 2014 13:21:56 +0800
Message-ID: <5424F7F4.5040106@intel.com>
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com> <1410229968-11638-2-git-send-email-aaron.lu@intel.com> <CACRpkdaJjqs9WNcVvjsSWhzLD2QpcyR11MVm4xhm4GqB28eOCA@mail.gmail.com> <54238496.70505@intel.com> <20140925111555.GG1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140925111555.GG1786@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, =?windows-1252?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-arch.vger.kernel.org

On 09/25/2014 07:15 PM, Mika Westerberg wrote:
> On Thu, Sep 25, 2014 at 10:57:26AM +0800, Aaron Lu wrote:
>> The virtual GPIO introduced in ACPI table of Baytrail-T based system is
>> used to solve a problem under Windows. We do not have such problems
>> under Linux so we do not actually need them. But we have to tell GPIO
>> library that the Crystal Cove GPIO chip has this many GPIO pins or the
>> common GPIO handler will refuse any access to those high number GPIO
>> pins, which will resulted in a failure evaluation of every ACPI control
>> method that is used to turn on/off power resource and/or report sensor
>> temperatures.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for the review!

Regards,
Aaron

> 
> A minor nit, see below:
> 
>> ---
>> v2: remove the hunk to increase NR_GPIO to 512.
>>
>>  drivers/gpio/gpio-crystalcove.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
>> index e3712f0e51ab..186b76ef71a1 100644
>> --- a/drivers/gpio/gpio-crystalcove.c
>> +++ b/drivers/gpio/gpio-crystalcove.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/mfd/intel_soc_pmic.h>
>>  
>>  #define CRYSTALCOVE_GPIO_NUM	16
>> +#define CRYSTALCOVE_VGPIO_NUM	0x5e
> 
> I would rather see this spelled in decimal base.
> 

