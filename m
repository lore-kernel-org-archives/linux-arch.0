From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 0/4] Generalize fncpy availability
Date: Tue, 20 Jun 2017 10:03:53 -0700
Message-ID: <e4d75953-b12f-7157-d3a7-84a5f417cac9@gmail.com>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
 <c8b7789c-38fb-6793-050f-7c60ccb8ca17@broadcom.com>
 <20170620091025.GA26846@red-moon>
 <3834f2fa-5ac0-5b48-7c19-a1b68c1e9c65@gmail.com>
 <962aa9c2-05a2-e109-8126-7e18ef9b157b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <962aa9c2-05a2-e109-8126-7e18ef9b157b@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-arch.vger.kernel.org

On 06/20/2017 09:54 AM, Sudeep Holla wrote:
> 
> 
> On 20/06/17 17:20, Florian Fainelli wrote:
>> On 06/20/2017 02:10 AM, Lorenzo Pieralisi wrote:
>>> [+Sudeep]
>>>
>>> On Mon, Jun 19, 2017 at 10:32:38AM -0700, Florian Fainelli wrote:
>>>> On 06/19/2017 05:24 AM, Mark Rutland wrote:
>>>>> On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
>>>>>> Hi all,
>>>>>
>>>>> Hi Florian,
>>>>>
>>>>>> This patch series makes ARM's fncpy() implementation more generic (dropping the
>>>>>> Thumb-specifics) and available in an asm-generic header file.
>>>>>>
>>>>>> Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.
>>>>>>
>>>>>> Changes in v3 (thanks Doug!):
>>>>>> - correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
>>>>>> - utilize Kbuild to provide the fncpy.h header on ARM64
>>>>>>
>>>>>> Changes in v2:
>>>>>> - leave the ARM implementation where it is
>>>>>> - make the generic truly generic (no)
>>>>>>
>>>>>> This is helpful in making SoC-specific power management code become true drivers
>>>>>> that can be shared between different architectures.
>>>>>> Could you elaborate on what this is needed for?
>>>>
>>>> Several uses cases come to mind:
>>>>
>>>> - it could be used as a trampoline code prior to entering S2 for systems
>>>> that do not support PSCI 1.0
>>>
>>> I think S2 here means PM_SUSPEND_MEM. It is very wrong to manage power
>>> states through platform specific hooks on PSCI based systems, consider
>>> upgrading to PSCI 1.0 please (or implement PSCI CPU_SUSPEND power
>>> states that allow to achieve same power savings as PM_SUSPEND_MEM
>>> by just entering suspend-to-idle).
>>
>> S2 is PM_SUSPEND_STANDBY and S3 is PM_SUSPEND_MEM, at least that how I
>> read it. I would rather we update to PSCI 1.0 (at least) to properly
>> support SYSTEM_SUSPEND rather than retrofitting a system-wide suspend
>> state into CPU_SUSPEND since that seems wrong.
>>
> 
> This has been discussed multiple times in the past. No one has come back
> with strong reason to add that to the PSCI SYSTEM_SUSPEND API.
> 
> Care to explain the difference between PM_SUSPEND_STANDBY and S3 is
> PM_SUSPEND_MEM on your platform. And why it can't be achieved with
> suspend-to-idle ?

S2 preserves the ON/OFF island power and allows wake logic to wake the
system (infrared, GPIOs, Wake-on-LAN/WLAN, etc.) whereas S3 allows
powering off the ON/OFF island entirely, and allows for a lower power
consumption, with a subset of the wake peripherals to actually wake the
system. S5 is also implemented although its use case is narrower (soft-off).

The higher latency involved in S3 entry/exit is totally accepted due to
the higher power savings that it yields.

> 
> You can always report any issue with PSCI specification at
> errata@arm.com as mentioned in the document.

I just did because there are a few other things missing.
-- 
Florian
