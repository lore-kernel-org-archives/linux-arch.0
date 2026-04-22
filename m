Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08713D3333;
	Wed, 22 Apr 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860472; cv=none; b=boVZ+xr93PtLyN0yUBy0+qffqIdqbWS+b9ovZjZRb9kMbxa+Q9p5WNsSS5vx8w8ZPuUAj7WOhjWSip/r/+/u4+RuCCsTXxZiPG85eyPw7h/9z+0enn5dSITguR/u/U5INeM+sVtvKJ0hJzBfbWFM2/Bc6ejkIK713P3YbmHiuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860472; c=relaxed/simple;
	bh=qqUVT6BWMeJOLKSW8OeZFvZ8iEZSNs4YHjncwKP+1P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as3ByUXg4GPHhUu0K43uhSeCe9KlrLbqtx7QRRoOOibsxABu8D1JDjs7VHfVo28kDxe5bePCFP5+oRP3pB/AF851mCev9sUwPedtYqF/fbGl1N5rEgAm2s9FXxGz9PUJDY0uzmTGgw1sUJs+aC0FilGs8ZVR5plYpMD0b3HjeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=gsUgZr/Z; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=ePdyU/uo; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="gsUgZr/Z";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="ePdyU/uo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860456;
	bh=qqUVT6BWMeJOLKSW8OeZFvZ8iEZSNs4YHjncwKP+1P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gsUgZr/ZVJXGVS2kFMUT/+XmtKq9l8Sj/DLrvhkQaTgw8l+DpQlVYrPGT8fOJRtM5
	 jeTetBig2nph4GcP5/E8nPnd70wcpk2mmBW2AvgMRXgPRCNI9sy9PXOpSD1Yxbw96C
	 zssFWk0Pb1OUymr9oD2Vuqe9jnNt2Uq4GYAvXk9KMX6Z1rRbIXVsKBKXatUZ05ME+A
	 LjF5UZvXW8RNyjweia8ON1vSiWW/X9AlPsSinfJwf/W8asYncCkBPvAl3EZTX+vAbh
	 vIPvYGUr2JKYNe5rCnlRe/ckyFnFSUedaoK9+N+JerJ1kATy08S1wi6zfl/EqQR/L0
	 diKUYRQmUHoXgYeSzpTmwKbA81de4K9lXUV00FZ795oW3J+W2+JwhCAU+NPb+zQGco
	 o0KHSdaAgVZY4cAr3guBtM/oVxJboeugcEgJNW5XCtgEa1+1jIczGzvlQ2f3nK/BZv
	 LgGNcyJ2IZUdzxecc3hXa8Sgq0ufnN/oitqEkjMoi0F4RX8fY4YkYoO4Ivy7wNzhBS
	 zmxaCFPz4T3hd8+n2+5NGlB+1i6odSrzkf1h+qlKpf5SkuvMC3F0fUBJ+QcozeD57g
	 BV1mjpJHEiVbSH87rl9venauQ4O42pSUEkOgTND4FQGa4yTKuV7sr+Ge8R8rIa8LBp
	 YQnipzoOoBQY3jpk84PhFiG8=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 97E4C1E8D99; Wed, 22 Apr 2026 20:20:56 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860395;
	bh=qqUVT6BWMeJOLKSW8OeZFvZ8iEZSNs4YHjncwKP+1P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ePdyU/uoqAbyV/Ukf18jTGxY5JHtigoAd6KaYX4PXqOa89tNKaloSR1EB6/TTdNvo
	 FWWzgHGyuFYD8yq108WdcQmqF0yJqJf36RRRRqHWqnQHhB1+/NT1DRaSHaTaJQy5MT
	 9+tu2jsBmguDardjdnk/45BtQp4ryAVI581cDbHYbXAMwRE6bCCZx8FcmAXe/QXvDc
	 cr1v+uTu7BzA+mBA8ym7L5a88ZSuMk8/zHKwI7C4EYjyqKMBam7kPs16zfn8W6jMna
	 qPuVONPhwrpBJF6k7tEorTt4luRf47VhNUSmt9StgX3BEVStZD8OeZ7+Z3P+aJhKXT
	 Ie46YFHDTh/lZjyKZFb6KKbmFFzgetNL+z8qmYH+8KxfOiZXNQOHG1cJ1N+FYSys46
	 CQjADusjDh3IUNmWL5SYkCZ1KsHEu25YDNnIbyZgwIzZyKMUNGCHPcuiPbVtsu9XBz
	 xX+5VWLYoSXvFOio59Iuzxrm5M3uvj0+Za3rn2rFDN7pAi0UbKX2xjVVfUTQMCNcCd
	 qa3snJQw3W0Yh74NeFS6VLRDVJs1Fno0eXns7c/0vUlqL7lgVKM4ppwphroQQLQ0pB
	 RN9LLev5+NAOuXqqn1uvEhJsx7kiR92n7/pvUTRD1KmeCKre35DB+3RoNf0BEzPVVF
	 Wy40YQMTKOuK7BBwl1M9eWoE=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 0FED31E8D87;
	Wed, 22 Apr 2026 20:19:55 +0800 (AWST)
Message-ID: <c71899ce-95a5-419b-8e83-9146ff9c7b7f@davidgow.net>
Date: Wed, 22 Apr 2026 20:19:52 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org,
 Alessandro Carminati <acarmina@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks very much for keeping this series alive! I'm very much in favour 
of it, and I think the overall design is good. Lots of more detailed 
nitpicks below, though.

Le 20/04/2026 à 8:28 PM, Albert Esteve a écrit :
> From: Alessandro Carminati <acarmina@redhat.com>
> 
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons:
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>    investigated and has to be marked to be ignored, for example by
>    adjusting filter scripts. Such filters are ad hoc because there is
>    no real standard format for warnings. On top of that, such filter
>    scripts would require constant maintenance.
> 
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multiple
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum.

It sounds from the description here that suppressing "specific 
backtraces" means that we're matching on the _contents_ of the stack 
trace. This sort-of does that implicitly by checking they're in the same 
kthread, but I think the fact that it's matching based on kthread should 
be explicit in the commit message, like it is in the documentation.

> 
> Implementation details:
> Suppression is checked at two points in the warning path:
> - In warn_slowpath_fmt(), the check runs before any output, fully
>    suppressing both message and backtrace.
> - In __report_bug(), the check runs before __warn() is called,
>    suppressing the backtrace and stack dump. Note that on this path,
>    the WARN() format message may still appear in the kernel log since
>    __warn_printk() runs before the trap that enters __report_bug().

Would it make sense to output a 'backtrace suppressed due to running 
test' message in this latter case, so we don't just end up with the 
WARN() format message by itself? (My gut feeling is 'no, it isn't worth 
it', but it's food for thought.)

> 
> A helper function, `__kunit_is_suppressed_warning()`, walks an
> RCU-protected list of active suppressions, matching by current task.
> The suppression state is tied to the KUnit test lifecycle via
> kunit_add_action(), ensuring automatic cleanup at test exit.
> 
> The list of suppressed warnings is protected with RCU to allow
> concurrent read access without locks.
> 
> The implementation is deliberately simple and avoids architecture-specific
> optimizations to preserve portability.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   include/kunit/bug.h  | 56 +++++++++++++++++++++++++++++++++++
>   include/kunit/test.h |  1 +
>   kernel/panic.c       |  8 ++++-
>   lib/bug.c            |  8 +++++
>   lib/kunit/Kconfig    |  9 ++++++
>   lib/kunit/Makefile   |  6 ++--
>   lib/kunit/bug.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 169 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kunit/bug.h b/include/kunit/bug.h
> new file mode 100644
> index 0000000000000..e52c9d21d9fe6
> --- /dev/null
> +++ b/include/kunit/bug.h

It's a bit confusing to name this bug.h when we have the (admittedly 
terribly-named) test-bug.h header already. I'm pretty tempted to rename 
the latter to something like 'hooks.h', as that's really what it's for, 
and having a separate bug.h would be an incentive to do so, though, sit 
it's not a big problem.

I do think that it'd be reasonable to include the backtrace suppression 
tuff in the same file, though, if you'd rather. The 
__kunit_is_suppressed_warning() stuff in particular fits the category of 
"code called to change behaviour based on whether or not a test is 
running", which is generally what the hooks are for. (And, if you'd 
rather, there's a bunch of existing hooks and hook infrastructure you 
could use.)

> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit helpers for backtrace suppression
> + *
> + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#ifndef _KUNIT_BUG_H
> +#define _KUNIT_BUG_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/kconfig.h>
> +
> +struct kunit;
> +
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +
> +#include <linux/types.h>
> +
> +struct task_struct;
> +
> +struct __suppressed_warning {
> +	struct list_head node;
> +	struct task_struct *task;
> +	int counter;
> +};
> +
> +struct __suppressed_warning *
> +__kunit_start_suppress_warning(struct kunit *test);
> +void __kunit_end_suppress_warning(struct kunit *test,
> +				  struct __suppressed_warning *warning);
> +int __kunit_suppressed_warning_count(struct __suppressed_warning *warning);
> +bool __kunit_is_suppressed_warning(void);
> +
> +#define KUNIT_START_SUPPRESSED_WARNING(test) \
> +	struct __suppressed_warning *__kunit_suppress =	\
> +		__kunit_start_suppress_warning(test)
> +
> +#define KUNIT_END_SUPPRESSED_WARNING(test) \
> +	__kunit_end_suppress_warning(test, __kunit_suppress)
> +
> +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> +	__kunit_suppressed_warning_count(__kunit_suppress)

Using a local variable (__kunit_suppress) here means that all of the 
above macros must live in the same function. This is probably okay for 
most use-cases, but more complicated tests may have to structure things 
carefully. It also prevents there from being multiple START/END pairs in 
the same function, and the KUNIT_SUPPRESSED_WARNING_COUNT() macro from 
appearing before _START().

It also makes it less obvious that this cleans up nicely if the test 
exits uncleanly, as the variable will have gone out-of-scope. (But given 
we're just storing a pointer to heap-allocated memory, and 
kunit_add_action() is used, it should be okay.)

One other option would be to allocate the suppression as a named 
resource, which could then be retrieved from anywhere within the test 
with kunit_find_named_resource(). (Though handling nested suppressions 
gets a little more complicated here.)

Or you could make the struct __suppressed_warning pointer returned 
explicitly user-visible, and let the user pass it around (though that 
seems more work).


> +
> +#else /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +
> +#define KUNIT_START_SUPPRESSED_WARNING(test)
> +#define KUNIT_END_SUPPRESSED_WARNING(test)
> +#define KUNIT_SUPPRESSED_WARNING_COUNT() 0
> +static inline bool __kunit_is_suppressed_warning(void) { return false; }
> +
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> +#endif /* __ASSEMBLY__ */
> +#endif /* _KUNIT_BUG_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9cd1594ab697d..4ec07b3fa0204 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -10,6 +10,7 @@
>   #define _KUNIT_TEST_H
>   
>   #include <kunit/assert.h>
> +#include <kunit/bug.h>
>   #include <kunit/try-catch.h>
>   
>   #include <linux/args.h>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index c78600212b6c1..d7a7a679f56c4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -39,6 +39,7 @@
>   #include <linux/sys_info.h>
>   #include <trace/events/error_report.h>
>   #include <asm/sections.h>
> +#include <kunit/bug.h>
>   
>   #define PANIC_TIMER_STEP 100
>   #define PANIC_BLINK_SPD 18
> @@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>   void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>   		       const char *fmt, ...)
>   {
> -	bool rcu = warn_rcu_enter();
> +	bool rcu;
>   	struct warn_args args;
>   
> +	if (__kunit_is_suppressed_warning())
> +		return;
> +
> +	rcu = warn_rcu_enter();
> +
>   	pr_warn(CUT_HERE);
>   
>   	if (!fmt) {
> diff --git a/lib/bug.c b/lib/bug.c
> index 623c467a8b76c..606205c8c302f 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -48,6 +48,7 @@
>   #include <linux/rculist.h>
>   #include <linux/ftrace.h>
>   #include <linux/context_tracking.h>
> +#include <kunit/bug.h>
>   
>   extern struct bug_entry __start___bug_table[], __stop___bug_table[];
>   
> @@ -223,6 +224,13 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>   	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
>   	has_args = bug->flags & BUGFLAG_ARGS;
>   
> +	/*
> +	 * Before the once logic so suppressed warnings do not consume
> +	 * the single-fire budget of WARN_ON_ONCE().
> +	 */
> +	if (warning && __kunit_is_suppressed_warning())
> +		return BUG_TRAP_TYPE_WARN;
> +

While any competant optimiser should get rid of this entirely, it might 
be clearer to anyone reading it that this disappears if we just put it 
behind an #ifdef?

>   	if (warning && once) {
>   		if (done)
>   			return BUG_TRAP_TYPE_WARN;
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 498cc51e493dc..57527418fcf09 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -15,6 +15,15 @@ menuconfig KUNIT
>   
>   if KUNIT
>   
> +config KUNIT_SUPPRESS_BACKTRACE
> +	bool "KUnit - Enable backtrace suppression"
> +	default y
> +	help
> +	  Enable backtrace suppression for KUnit. If enabled, backtraces
> +	  generated intentionally by KUnit tests are suppressed. Disable
> +	  to reduce kernel image size if image size is more important than
> +	  suppression of backtraces generated by KUnit tests.
> +
>   config KUNIT_DEBUGFS
>   	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_ALL_TESTS
>   	default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 656f1fa35abcc..fe177ff3ebdef 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -16,8 +16,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>   kunit-objs +=				debugfs.o
>   endif
>   
> -# KUnit 'hooks' are built-in even when KUnit is built as a module.
> -obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
> +# KUnit 'hooks' and bug handling are built-in even when KUnit is built
> +# as a module.
> +obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o \
> +					bug.o

Is there any reason we couldn't implement this on top of the hooks 
mechanism? Then we could include the bug suppression code in the 
kunit.ko module (albeit, with fewer possibilities for the compiler to 
optimise things, as they'd have to go through an indirect pointer).


>   
>   obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>   obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
> diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> new file mode 100644
> index 0000000000000..356c8a5928828
> --- /dev/null
> +++ b/lib/kunit/bug.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit helpers for backtrace suppression
> + *
> + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#include <kunit/bug.h>
> +#include <kunit/resource.h>
> +#include <linux/export.h>
> +#include <linux/rculist.h>
> +#include <linux/sched.h>
> +
> +#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
> +
> +static LIST_HEAD(suppressed_warnings);
> +
> +static void __kunit_suppress_warning_remove(struct __suppressed_warning *warning)
> +{
> +	list_del_rcu(&warning->node);
> +	synchronize_rcu(); /* Wait for readers to finish */
> +}
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(__kunit_suppress_warning_cleanup,
> +			    __kunit_suppress_warning_remove,
> +			    struct __suppressed_warning *);
> +
> +struct __suppressed_warning *
> +__kunit_start_suppress_warning(struct kunit *test)
> +{
> +	struct __suppressed_warning *warning;
> +	int ret;
> +
> +	warning = kunit_kzalloc(test, sizeof(*warning), GFP_KERNEL);
> +	if (!warning)
> +		return NULL;
> +
> +	warning->task = current;
> +	list_add_rcu(&warning->node, &suppressed_warnings);
> +
> +	ret = kunit_add_action_or_reset(test,
> +					__kunit_suppress_warning_cleanup,
> +					warning);
> +	if (ret)
> +		return NULL;
> +
> +	return warning;
> +}
> +EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
> +
> +void __kunit_end_suppress_warning(struct kunit *test,
> +				  struct __suppressed_warning *warning)
> +{
> +	if (!warning)
> +		return;
> +	kunit_release_action(test, __kunit_suppress_warning_cleanup, warning);
> +}
> +EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
> +
> +int __kunit_suppressed_warning_count(struct __suppressed_warning *warning)
> +{
> +	return warning ? warning->counter : 0;
> +}
> +EXPORT_SYMBOL_GPL(__kunit_suppressed_warning_count);
> +
> +bool __kunit_is_suppressed_warning(void)
> +{
> +	struct __suppressed_warning *warning;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> +		if (warning->task == current) {
> +			warning->counter++;
> +			rcu_read_unlock();
> +			return true;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return false;
> +}

Note to self: this is _not_ exported, as bug.c is being built-in 
regardless of whether or not KUnit is a module. If we used the hook 
system, it could live in kunit.ko, and would be manually exported by 
kunit_install_hooks()

> +
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> 


Thanks again,
-- David
