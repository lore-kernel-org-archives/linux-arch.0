From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 2/2] powerpc: Only support DYNAMIC_FTRACE not static
Date: Mon, 19 Mar 2018 12:08:10 +1100
Message-ID: <87efkghnyd.fsf@concordia.ellerman.id.au>
References: <20180316134633.10584-1-mpe@ellerman.id.au> <20180316134633.10584-2-mpe@ellerman.id.au> <20180316104248.6aa11792@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316104248.6aa11792@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 17 Mar 2018 00:46:33 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> We've had dynamic ftrace support for over 9 years since Steve first
>> wrote it, all the distros use dynamic, and static is basically
>> untested these days, so drop support for static ftrace.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/Kconfig                           |  1 +
>>  arch/powerpc/include/asm/ftrace.h              |  4 +---
>>  arch/powerpc/include/asm/module.h              |  5 -----
>>  arch/powerpc/kernel/trace/ftrace.c             |  2 --
>>  arch/powerpc/kernel/trace/ftrace_32.S          | 20 ------------------
>>  arch/powerpc/kernel/trace/ftrace_64.S          | 29 --------------------------
>>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  3 ---
>>  arch/powerpc/kernel/trace/ftrace_64_pg.S       |  2 --
>>  8 files changed, 2 insertions(+), 64 deletions(-)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 73ce5dd07642..23a325df784a 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -189,6 +189,7 @@ config PPC
>>  	select HAVE_DEBUG_STACKOVERFLOW
>>  	select HAVE_DMA_API_DEBUG
>>  	select HAVE_DYNAMIC_FTRACE
>> +	select HAVE_DYNAMIC_FTRACE_ONLY
>
> I still think adding:
>
> 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
>
> is the better approach.

OK. As I said in my other reply it's a bit fragile, but it does work.

I'll do a version for powerpc using the above approach.

> But I'm all for this patch. I've debated doing the same thing for x86,
> but the only reason I have not, was because it's the only way I test
> the !DYNAMIC_FTRACE code. I've broken the static function tracing
> several times and only find out during my test suite that still tests
> that case. But yeah, it would be nice to just nuke static function
> tracing for all archs. Perhaps after we finish removing unused archs,
> that may be the way to go forward.

Yeah I did look and we still have some arches that support ftrace but
not dynamic ftrace, but there's not many.

cheers
