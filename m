From: Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Thu, 15 Jun 2017 10:14:51 -0500
Message-ID: <544e2cef-4581-f6a0-2a0e-3d9c3da472f9@oracle.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
 <20170602201500.urllmug33bjtuzen@redhat.com>
 <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
 <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
 <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
 <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
 <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
 <20170612204156.ov7ka2765t4gdakl@redhat.com>
 <20170614021118.4bbfd00f@roar.ozlabs.ibm.com>
 <20170614140937.qrkajknqxldwdkv2@redhat.com>
 <fc41c166-7db1-79d2-da01-cbcb412952c9@oracle.com>
 <20170615130401.033a39dd@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25256 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdFOPPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 11:15:03 -0400
In-Reply-To: <20170615130401.033a39dd@roar.ozlabs.ibm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Nick,

On 6/14/2017 10:04 PM, Nicholas Piggin wrote:
> On Wed, 14 Jun 2017 21:16:04 -0500
> Babu Moger <babu.moger@oracle.com> wrote:
>
>> Hi Don,
>>
>> On 6/14/2017 9:09 AM, Don Zickus wrote:
>>> On Wed, Jun 14, 2017 at 02:11:18AM +1000, Nicholas Piggin wrote:
>>>>> Yeah, if you wouldn't mind.  Sorry for dragging this out, but I feel like we
>>>>> are getting close to have this defined properly which would allow us to
>>>>> split the code up correctly in the future.
>>>> How's this for a replacement patch 3? I think the Kconfig works out much
>>>> better now.
>>> Hi Nick,
>>>
>>> I think you made this much clearer, thank you!  I am good with this.
>>>
>>>
>>> Hi Babu,
>>>
>>> Can you give this patchset (and particularly this version of patch 3) a try
>>> on sparc to make sure we didn't break anything?  I believe this should
>>> resolve the start nmi watchdog on boot issue you noticed.  Thanks!
>> There is still one problem with the patch.
>>
>> # cat /proc/sys/kernel/watchdog
>> 1
>> # cat /proc/sys/kernel/nmi_watchdog
>> 0
>>
>> Problem is setting the initial value for  "nmi_watchdog"
>>
>> We need something(or similar) patch on top to address this.
>> ============================================
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 5397c63..0105856 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -34,9 +34,13 @@
>>
>>    int __read_mostly nmi_watchdog_enabled;
>>
>> -#ifdef CONFIG_HARDLOCKUP_DETECTOR
>> +#if defined(CONFIG_HARDLOCKUP_DETECTOR) ||
>> defined(CONFIG_HAVE_NMI_WATCHDOG)
>>    unsigned long __read_mostly watchdog_enabled =
>> SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
>> +#else
>> +unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
>> +#endif
>>
>> +#ifdef CONFIG_HARDLOCKUP_DETECTOR
>>    /* boot commands */
>>    /*
>>     * Should we panic when a soft-lockup or hard-lockup occurs:
>> @@ -69,9 +73,6 @@ static int __init hardlockup_panic_setup(char *str)
>>           return 1;
>>    }
>>    __setup("nmi_watchdog=", hardlockup_panic_setup);
>> -
>> -#else
>> -unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
>>    #endif
>>
>>    #ifdef CONFIG_SOFTLOCKUP_DETECTOR
> Hmm, I guess I missed this because sparc parses nmi_watchdog=, but it
> also relies on the watchdog_enabled value.
>
> I guess I can fold your incremental patch in. I hope we could get
  Sure. Please go ahead.
> sparc quickly to adopt the complate HAVE_HARDLOCKUP_DETECTOR_ARCH soon
> afterwards though, so we only have 2 cases -- complete hardlockup
Sure. Sounds good. Will look at it later.
> detector, or the very bare minimum NMI_WATCHDOG.
>
> Thanks,
> Nick
