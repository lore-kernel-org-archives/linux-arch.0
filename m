Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DA3B0AD6;
	Mon, 20 Apr 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696011; cv=none; b=EcJgAQOQksEZDNHj0n0pKHspuUzzCJ2ljksXnb9fdBixe6orfnpWYljpuy4akzx7u4uxOsMy+RDlDUvdcBgOF4f3rQovp8/beCj+X5Edb8zOgIzkOV9NpPbp4iTMlKkUm7rvks2VTwdkpGwyvVteLUZMjTEIkQvj19A2OLFQffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696011; c=relaxed/simple;
	bh=KeisURYvGj64s9kA7YoeUzcFL8D06xP+LWdVinVcLmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2AsashGmckRr6nliKH68gZgG/bmB7oHD50VHxF39TutqAuDYP9zHYdr0M07fqDjiX9r2MVbb457lwqZf9+LLNg0ModL/jJfunINLyLgki80B5j/ex2lZUk/oqzM7A3GoqF7x2GIjDICJlQhOgWEi78DjxTEmTlRCZgQ8Xkcmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ehYdEZXR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehYdEZXR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pGs/abDUFl+Xn8ohH5DgfcUY3QuLPfIW9B2LPcXATbw=; b=ehYdEZXRGArG1O+qe4e5vVUtg1
	ClPETC8QRVHzsdYZcpli9GQIk5UB+sHlvknF8KXUndqod0WqbILKT2PczaDMtsBy3dieWSvMJgUGe
	mVCc8YTbqxfO3xe8CgZ06FAptfAuvPZeBVRN8qP1LTXqK1d+cQHOBjD4oK1RjCOQcPHcZeBH+oh2S
	eIfwdvvgk0PYtdUnJyJfaTEW6WBWIS12xYURlJZbXSWRqLcO3KCs9M57umy0UsnL0h5kTmaWUnJuF
	LDBhrCsT8BLphpc2hk8or4hipZu0CKiNacyQ3WNrwX9Um4hyLDpVjrPjLBGQS8+kPc5htpryjkjqX
	+LWIK5wg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpmy-00000008CqD-340i;
	Mon, 20 Apr 2026 14:39:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 20861301BDE; Mon, 20 Apr 2026 16:39:51 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:39:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20260420143951.GJ3102624@noisy.programming.kicks-ass.net>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>

On Mon, Apr 20, 2026 at 02:28:03PM +0200, Albert Esteve wrote:
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
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
> 
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multiple
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum.
> 
> Implementation details:
> Suppression is checked at two points in the warning path:
> - In warn_slowpath_fmt(), the check runs before any output, fully
>   suppressing both message and backtrace.
> - In __report_bug(), the check runs before __warn() is called,
>   suppressing the backtrace and stack dump. Note that on this path,
>   the WARN() format message may still appear in the kernel log since
>   __warn_printk() runs before the trap that enters __report_bug().

This is for architectures that implement __WARN_FLAGS but not
__WARN_printf right? (which is arm64, loongarch, parisc, powerpc, riscv,
sh, afaict). ARM64 should eventually get __WARN_printf, but other than
that this should be fixable by moving __WARN_FLAGS() into
__warn_printk() or so. This is the only __warn_printk() user anyway.


> diff --git a/include/kunit/bug.h b/include/kunit/bug.h
> new file mode 100644
> index 0000000000000..e52c9d21d9fe6
> --- /dev/null
> +++ b/include/kunit/bug.h
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

We have __cleanup for this?

> +
> +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> +	__kunit_suppressed_warning_count(__kunit_suppress)
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

> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 656f1fa35abcc..fe177ff3ebdef 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -16,8 +16,10 @@ ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=				debugfs.o
>  endif
>  
> -# KUnit 'hooks' are built-in even when KUnit is built as a module.
> -obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
> +# KUnit 'hooks' and bug handling are built-in even when KUnit is built
> +# as a module.
> +obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o \
> +					bug.o
>  
>  obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>  obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
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

What if anything serializes this global list?

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
> +
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> 
> -- 
> 2.52.0
> 
