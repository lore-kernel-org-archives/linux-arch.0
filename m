Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56373 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbaIZFWo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Sep 2014 01:22:44 -0400
Message-ID: <5424F80D.9070400@intel.com>
Date: Fri, 26 Sep 2014 13:22:21 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] gpio / CrystalCove: support virtual GPIO
References: <1410229968-11638-1-git-send-email-aaron.lu@intel.com>	<1410229968-11638-2-git-send-email-aaron.lu@intel.com>	<CACRpkdaJjqs9WNcVvjsSWhzLD2QpcyR11MVm4xhm4GqB28eOCA@mail.gmail.com>	<54238496.70505@intel.com> <CACRpkdYeOfsx-PpEKaJY14sUqQ2VRiNmXnn_m-mrMzpBtcuBpg@mail.gmail.com>
In-Reply-To: <CACRpkdYeOfsx-PpEKaJY14sUqQ2VRiNmXnn_m-mrMzpBtcuBpg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Lejun Zhu <lejun.zhu@intel.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>, =?windows-1252?Q?Dani?= =?windows-1252?Q?el_Gl=F6ckner?= <dg@emlix.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <20140926052221.rZHvtYAvc7zYmeqc4yaW4J1AVO60yU0dBmnUbuBB030@z>

On 09/25/2014 09:16 PM, Linus Walleij wrote:
> On Thu, Sep 25, 2014 at 4:57 AM, Aaron Lu <aaron.lu@intel.com> wrote:
> 
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
>> ---
>> v2: remove the hunk to increase NR_GPIO to 512.
> 
> Patch applied with Mika's ACK, also renumbered 0x5e to 94.

Thanks for taking care of this.

Regards,
Aaron

> 
> Yours,
> Linus Walleij
> 

