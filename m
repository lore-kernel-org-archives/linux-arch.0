From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v5 1/6] asm-generic/bug.h: declare struct pt_regs; before
 function prototype
Date: Mon, 12 Jun 2017 15:13:54 +0100
Message-ID: <20489607-25ef-1cbc-3679-6d4c7253514b@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
 <20170525120316.24473-2-abbotti@mev.co.uk>
 <20170608100731.43ee0323@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.iad3a.emailsrvr.com ([173.203.187.104]:60042 "EHLO
        smtp104.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752004AbdFLON6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Jun 2017 10:13:58 -0400
In-Reply-To: <20170608100731.43ee0323@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On 08/06/17 15:07, Steven Rostedt wrote:
> On Thu, 25 May 2017 13:03:11 +0100
> Ian Abbott <abbotti@mev.co.uk> wrote:
>
>> The declaration of `__warn()` has `struct pt_regs *regs` as one of its
>> parameters.  This can result in compiler warnings if `struct regs` is
>> not already declared.  Add an empty declaration of `struct pt_regs` to
>> avoid the warnings.
>>
>
> Not sure if this has been pulled already or not, but I have a small nit.

It's already in linux-next master.

>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>> ---
>> v3: Actually, there was no v1 or v2.  I called this v3 to match the
>> series.
>> v4: Corrected 'Acked-by:' line in patch description.
>> v5: Added Acked-by for Michal Nazarewicz.
>> ---
>>  include/asm-generic/bug.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index d6f4aed479a1..87191357d303 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -97,6 +97,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>>
>>  /* used internally by panic.c */
>>  struct warn_args;
>> +struct pt_regs;
>
> Probably be better to move pt_regs above the comment. For one, it is
> used before warn_args in the function below. Two, it's not defined
> internally by panic.c like warn_args is.

Alternatively, the comment could be placed on the same line as `struct 
warn_args;`.  I don't think it's a big enough of a deal to patch it for 
the sake of it, tbh.

>
> -- Steve
>
>
>>
>>  void __warn(const char *file, int line, void *caller, unsigned taint,
>>  	    struct pt_regs *regs, struct warn_args *args);
>


-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
