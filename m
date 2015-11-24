From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] Kbuild: disable 'maybe-uninitialized' warning for
 CONFIG_PROFILE_ALL_BRANCHES
Date: Tue, 24 Nov 2015 13:07:22 +0100
Message-ID: <565452FA.6010603@suse.com>
References: <3799453.oCg1CdOrtm@wuerfel> <565439FB.6050800@suse.com>
 <20825812.L9y0yMCgts@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20825812.L9y0yMCgts@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 2015-11-24 11:42, Arnd Bergmann wrote:
> On Tuesday 24 November 2015 11:20:43 Michal Marek wrote:
>>> diff --git a/Makefile b/Makefile
>>> index 5e01a416c6e4..f8b921658f29 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -626,7 +626,11 @@ KBUILD_CFLAGS    += $(call cc-option,-fno-delete-null-pointer-checks,)
>>>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>>>  KBUILD_CFLAGS        += -Os $(call cc-disable-warning,maybe-uninitialized,)
>>>  else
>>> -KBUILD_CFLAGS        += -O2
>>> +ifdef CONFIG_PROFILE_ALL_BRANCHES
>>> +KBUILD_CFLAGS        += -O2 $(call cc-disable-warning,maybe-uninitialized,)
>>> +else
>>> +KBUILD_CFLAGS   += -O2
>>> +endif
>>
>> Does it only happen with -O2? Normally, we would add it outside the
>> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.
>>
> 
> We already disable the warning for -Os builds based on a patch we merged
> a while ago. It seems easier to add it to the block we already have.

I'm blind, sorry.

Michal
