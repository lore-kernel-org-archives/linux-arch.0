From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read notrace
Date: Fri, 16 Sep 2016 18:08:24 +0800
Message-ID: <CAG2=9p-iVgt1e3FyBOg8AkbzeY5Z5=JMHjpayaFPAPhvsFAQKA@mail.gmail.com>
References: <1473497134-27807-1-git-send-email-zhang.chunyan@linaro.org>
 <CAG2=9p-v53OJovx4f=YsHD71vNz4EksJ_7tKfzMZeaK3qYxuog@mail.gmail.com> <20160916095309.GM3380@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36355 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbcIPKI0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2016 06:08:26 -0400
Received: by mail-wm0-f51.google.com with SMTP id b187so28362343wme.1
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2016 03:08:25 -0700 (PDT)
In-Reply-To: <20160916095309.GM3380@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>

On 16 September 2016 at 17:53, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Sep 16, 2016 at 04:42:44PM +0800, Chunyan Zhang wrote:
>> Hi Will and Steven,
>>
>> May I have a review or an acked-by from you on this patch so that Arnd
>> can pick it up.
>>
>> I have tested this patch on arm qemu, I'm sure it can solve the
>> problem described in commit message.
>
> It looks fine to me; we took your equivalent patch for arm64 already, so:

Yeah, I saw that.

>
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,
Chunyan

>
> Will
>
>> On 10 September 2016 at 16:45, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>> > When debug preempt or preempt tracer is enabled, preempt_count_add/sub()
>> > can be traced by function and function graph tracing, and
>> > preempt_disable/enable() would call preempt_count_add/sub(), so
>> > we should use preempt_disable/enable_notrace in Ftrace subsystem.
>> >
>> > The function this_cpu_read() started being used by function graph tracing
>> > after the commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the
>> > bitmap like events do"), so it has to use preempt_disable/enable_notrace
>> > instead now.
>> >
>> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> > ---
>> >  include/asm-generic/percpu.h | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
>> > index 4d9f233..70fefec 100644
>> > --- a/include/asm-generic/percpu.h
>> > +++ b/include/asm-generic/percpu.h
>> > @@ -108,9 +108,9 @@ do {                                                                        \
>> >  #define this_cpu_generic_read(pcp)                                     \
>> >  ({                                                                     \
>> >         typeof(pcp) __ret;                                              \
>> > -       preempt_disable();                                              \
>> > +       preempt_disable_notrace();                                      \
>> >         __ret = *this_cpu_ptr(&(pcp));                                  \
>> > -       preempt_enable();                                               \
>> > +       preempt_enable_notrace();                                       \
>> >         __ret;                                                          \
>> >  })
>> >
>> > --
>> > 2.7.4
>> >
>>
