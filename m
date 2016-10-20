From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kconfig.h: remove config_enabled() macro
Date: Thu, 20 Oct 2016 21:06:49 +0900
Message-ID: <CAK7LNATp2vta0_Qzcs-TuXAX8jQejZyLXiqKKvfi8M=NLtxgAA@mail.gmail.com>
References: <1476616078-32252-1-git-send-email-yamada.masahiro@socionext.com> <1476957892.28989.24.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476957892.28989.24.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Thomas Garnier <thgarnie@google.com>
List-Id: linux-arch.vger.kernel.org

Hi Paul,



2016-10-20 19:04 GMT+09:00 Paul Bolle <pebolle@tiscali.nl>:
> Masahiro,
>
> A few comments regarding, I guess, future work.
>
> On Sun, 2016-10-16 at 20:07 +0900, Masahiro Yamada wrote:
>> The use of config_enabled() is ambiguous.  For config options,
>> IS_ENABLED(), IS_REACHABLE(), etc. will make intention clearer.
>> Sometimes config_enabled() has been used for non-config options
>> because it is useful to check whether the given symbol is defined
>> or not.
>>
>> I have been tackling on deprecating config_enabled(), and now is the
>> time to finish this work.
>>
>> Some new users have appeared for v4.9-rc1, but it is trivial to
>> replace them:
>>
>>  - arch/x86/mm/kaslr.c
>>   replace config_enabled() with IS_ENABLED() because
>>   CONFIG_X86_ESPFIX64 and CONFIG_EFI are boolean.
>>
>>  - include/asm-generic/export.h
>>   replace config_enabled() with __is_defined().
>>
>> Then, config_enabled() can be removed now.
>>
>> Going forward, please use IS_ENABLED(), IS_REACHABLE(), etc. for
>> config options, and __is_defined() for non-config symbols.
>
> There are about a dozen instances of IS_ENABLED() that target something
> other than a kconfig macros. Are you planning to convert those to
> __is_defined() too?

I did not notice that, but looks like there are some to be checked.


$ git grep '[^A-Za-z0-9_]IS_ENABLED([^C]'
arch/arc/include/asm/setup.h:#define IS_USED_CFG(cfg)
IS_USED_RUN(IS_ENABLED(cfg))
arch/arm64/include/asm/alternative.h:   __ALTERNATIVE_CFG(oldinstr,
newinstr, feature, IS_ENABLED(cfg))
arch/arm64/include/asm/alternative.h:   alternative_insn insn1, insn2,
cap, IS_ENABLED(cfg)
drivers/crypto/sahara.c:        if (!IS_ENABLED(DEBUG))
drivers/crypto/sahara.c:        if (!IS_ENABLED(DEBUG))
drivers/crypto/sahara.c:        if (!IS_ENABLED(DEBUG))
drivers/gpu/drm/exynos/exynos_drm_drv.c:#define DRV_PTR(drv, cond)
(IS_ENABLED(cond) ? &drv : NULL)
include/asm-generic/vmlinux.lds.h:#define OF_TABLE(cfg, name)
__OF_TABLE(IS_ENABLED(cfg), name)
include/linux/init.h:   int var = IS_ENABLED(config);
                 \
include/linux/kconfig.h: * This is similar to IS_ENABLED(), but
returns false when invoked from
include/linux/kconfig.h:#define IS_ENABLED(option)
__or(IS_BUILTIN(option), IS_MODULE(option))
kernel/locking/locktorture.c:int torture_runnable = IS_ENABLED(MODULE);
kernel/rcu/rcuperf.c:static int perf_runnable = IS_ENABLED(MODULE);
kernel/rcu/rcutorture.c:static int torture_runnable = IS_ENABLED(MODULE);
scripts/checkpatch.pl:                           "Prefer
IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n"
scripts/checkpatch.pl:                          $fixed[$fixlinenr] =
"\+#if IS_ENABLED($config)";





>> --- a/include/linux/kconfig.h
>> +++ b/include/linux/kconfig.h
>> @@ -31,7 +31,6 @@
>>   * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
>>   * the last step cherry picks the 2nd arg, we get a zero.
>>   */
>> -#define config_enabled(cfg)          ___is_defined(cfg)
>
> Is there a reason to keep using the double underscore prefix?



I followed the suggestion in the following message:

https://lkml.org/lkml/2016/6/6/944



>>  #define __is_defined(x)                      ___is_defined(x)
>>  #define ___is_defined(val)           ____is_defined(__ARG_PLACEHOLDER_##val)
>>  #define ____is_defined(arg1_or_junk) __take_second_arg(arg1_or_junk 1, 0)
>
> __is_defined() is now meant to be used generally, and not just on
> kconfig macros. Can it be moved into another header?



Currently, __is_defined() is only used in two places:

include/linux/export.h
include/asm-generic/export.h

Even if we fix something like IS_ENABLED(DEBUG),
we do not have many for now,
but perhaps will it be used more widely in the future?


If so, do we need to add  IS_DEFINED() or is_defined()?

in include/linux/kconfig.h ?  or include/linux/kernel.h ?




-- 
Best Regards
Masahiro Yamada
