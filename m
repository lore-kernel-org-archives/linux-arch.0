From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [RFA][PATCH 25/27] arm64, ftrace: Remove check of obsolete variable
 function_trace_stop
Date: Tue, 01 Jul 2014 20:33:07 +0900
Message-ID: <53B29C73.9090509@linaro.org>
References: <20140626165221.736847419@goodmis.org> <20140626165853.482575534@goodmis.org> <20140627124421.GP26276@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58062 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaGALdS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2014 07:33:18 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so10445675pad.21
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2014 04:33:17 -0700 (PDT)
In-Reply-To: <20140627124421.GP26276@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>

On 06/27/2014 09:44 PM, Will Deacon wrote:
> Hi Steve,
>
> On Thu, Jun 26, 2014 at 05:52:46PM +0100, Steven Rostedt wrote:
>> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
>>
>> Nothing sets function_trace_stop to disable function tracing anymore.
>> Remove the check for it in the arch code.
>>
>> arm64 was broken anyway, as it had an ifdef testing
>>   CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST which is only set if
>> the arch supports the code (which it obviously did not), and
>> it was testing a non existent ftrace_trace_stop instead of
>> function_trace_stop.
>
> Yeah, the current code is total crap. Well spotted.

Thank you for fixing my bug :)
I also exercised ftrace with sysfs interface, and it just works well.

-Takahiro AKASHI

>
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>>   arch/arm64/kernel/entry-ftrace.S | 5 -----
>>   1 file changed, 5 deletions(-)
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>
> I'm happy for you to take this via the ftrace tree, along with the rest of
> the series.
>
> I successfully ran the ftrace self tests with this applied (on top of
> "ftrace: Remove check for HAVE_FUNCTION_TRACE_MCOUNT_TEST"), but note
> that I don't have a platform with working suspend/resume right now.
>
> Cheers,
>
> Will
>
>> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
>> index b051871f2965..1b1e330e6849 100644
>> --- a/arch/arm64/kernel/entry-ftrace.S
>> +++ b/arch/arm64/kernel/entry-ftrace.S
>> @@ -96,11 +96,6 @@
>>    *     - ftrace_graph_caller to set up an exit hook
>>    */
>>   ENTRY(_mcount)
>> -#ifdef CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST
>> -	ldr	x0, =ftrace_trace_stop
>> -	ldr	x0, [x0]		// if ftrace_trace_stop
>> -	ret				//   return;
>> -#endif
>>   	mcount_enter
>>
>>   	ldr	x0, =ftrace_trace_function
>> --
>> 2.0.0
>>
>>
>>
