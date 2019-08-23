Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:16402 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfHWO1C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 10:27:02 -0400
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
Date: Fri, 23 Aug 2019 16:26:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 20190819234111.9019-8-keescook@chromium.org
Cc: Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190823142659.9F-KtwOXswPwSJU_LChgXXu8Cqh8BU91w2-8tgwWmLE@z>



Le 23/08/2019 à 00:56, Andrew Morton a écrit :
> On Tue, 20 Aug 2019 09:47:55 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
>> Reply-To: 20190819234111.9019-8-keescook@chromium.org
> 
> Really?

That seems correct, that's the "[PATCH 7/7] bug: Move WARN_ON() "cut 
here" into exception handler" from the series at 
https://lkml.org/lkml/2019/8/19/1155


> 
>> Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler
> 
> It's strange to receive a standalone [7/7] patch.

Iaw the Reply_To, I understand it as an update of the 7th patch of the 
series.

> 
>> Date:   Tue, 20 Aug 2019 09:47:55 -0700
>> Sender: linux-kernel-owner@vger.kernel.org
>>
>> The original clean up of "cut here" missed the WARN_ON() case (that
>> does not have a printk message), which was fixed recently by adding
>> an explicit printk of "cut here". This had the downside of adding a
>> printk() to every WARN_ON() caller, which reduces the utility of using
>> an instruction exception to streamline the resulting code. By making
>> this a new BUGFLAG, all of these can be removed and "cut here" can be
>> handled by the exception handler.
>>
>> This was very pronounced on PowerPC, but the effect can be seen on
>> x86 as well. The resulting text size of a defconfig build shows some
>> small savings from this patch:
>>
>>     text    data     bss     dec     hex filename
>> 19691167        5134320 1646664 26472151        193eed7 vmlinux.before
>> 19676362        5134260 1663048 26473670        193f4c6 vmlinux.after
>>
>> This change also opens the door for creating something like BUG_MSG(),
>> where a custom printk() before issuing BUG(), without confusing the "cut
>> here" line.
> 
> I can't get this to apply to anything, so I guess that [1/7]-[6/7]
> mattered ;)

On my side it applies cleanly on top of patch 1-6 of the series.

Christophe


> 
>> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
> 
> I'm seeing double.
> 
>> Signed-off-by: Kees Cook <keescook@chromium.org>
