Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A53D1CA8;
	Wed, 18 Mar 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834716; cv=none; b=INjF64VyceDJtCrYYzUQJvodjZbwk+5gfQL8LsAslGdrS3aJR5PGwZ+GzdLvgxJFmOl8Yt0oUk1Z/rwrH2DX5KZ6CW980FeNWkQcT5rpAL8W6tj5rhxwke731ESnLQYiWlTZcD8zd5qfDMYLZzZD4f6cd1MXUjdmuWp7Od59cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834716; c=relaxed/simple;
	bh=NdvYSfGJA3TaQt+fA44orlNXTsVGaF7BQFG0Ch+sVP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHDrj5cYu8+b1uWWv4IM1/quEv3aX9G5aGuxjQlyP6W21JmPlo/n5UWFO+c9x8oPNEWFX32MLfF+W+uxt4ZhbPRTa1AEinAUA7YlV2/dSfM6FYMVp/cUR959IWGZNYPCt9ENXsjHXBBGWmgb+4S5I/P9SeDeKEMP7X10k9yF/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JhQ+cmB5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JhQ+cmB5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XsXlEQr1q7kaSib/qBKH1VAa8U1xAnF1cwUdbfssMpw=; b=JhQ+cmB5U5Bo4sqJHXaHxh5K30
	qsRu64UMEWVEQUPtbKg2j1GcYYkzFegZVNIwM4UcHmF0ZNSoAl6GvcEO6boch0Rlb/DAgqkFxhdcF
	VzUDTGFp82ZwKfmoVnMBDALRFb63hCWK/X162ONh6imlORUilou3erYJueXXjnTlgwrkYBaFY0Ug8
	axFhd0FI97tvxf8ND0SXcGxm/00hqgBb2xFNf1ZPyVomlG63Y0eb3zjGYTe0/1Pn96V+XOw62XH0T
	OU1PynNmpsh4HzQ7VTLrpak7oqCdGGgFBF6T73PqjNGLBXpJexbbCsw2l4pKW11/u7X2UN0l83sgO
	RAovC8mA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2pR1-0000000B7JZ-1WlA;
	Wed, 18 Mar 2026 11:51:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0AF263007C4; Wed, 18 Mar 2026 12:51:34 +0100 (CET)
Date: Wed, 18 Mar 2026 12:51:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
Message-ID: <20260318115134.GA3738786@noisy.programming.kicks-ass.net>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
 <20260317113025.GG2872@noisy.programming.kicks-ass.net>
 <CADSE00Jy=G7HhRkb7vmFSuGFmvpGGt1TQ2NA+7XGLZ4b=g3rxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSE00Jy=G7HhRkb7vmFSuGFmvpGGt1TQ2NA+7XGLZ4b=g3rxQ@mail.gmail.com>

On Wed, Mar 18, 2026 at 10:25:00AM +0100, Albert Esteve wrote:

> So back to my test on this. Alessandro detailed two strategies in the
> last version, one of them (storing the function name in `struct
> bug_entry`) was already used and discarded in older iterations of this
> series. So let's focus on the other strategy, using 'kallsyms`. Let's
> assume we still store the function name when registering a new symbol
> to suppress. Otherwise, we might need to check address ranges to
> ensure bugaddr is within the function's scope, which sounds trickier?

> With `kallsyms` we can infer the originating functionid. But this
> approach works unreliably with compiler-induced transformations (e.g.,
> inlining, cloning, code fragmentation). And we still cannot prevent
> all output. 

> Additionally, we would need to prevent prints in
> `warn_slowpath_fmt()`. There may be other `printk`s embedded in the
> macros, but let's focus on suppressing all warnings as a best effort.
> It would already improve the quality of life for testers.

warn_slowpath_fmt() should be completely unused on x86, s390 and
possibly others. But sure.

> Considering these remaining issues, I managed to create a centralised
> proposal. Please find the main changes at the bottom of this message.
> 
> But again, even with these, the solution remains unreliable. We can
> mitigate this by registering the test name on the suppression list (at
> least, I can make the new test in this series pass with that). Not
> ideal, but we could mention it in the documentation. Something like
> "Suppression is matched by the function where the warning is reported.
> If the warning is triggered from a helper (or the compiler inlines it
> into the test), that function name may differ. In that case, register
> and start suppression for both the test and the helper so the test
> passes regardless of inlining."
> 
> Would that be a more acceptable solution? Is there a better option I
> am not seeing?

Yes, definitely. This is the sort of thing I was aiming for.

Other option would be the __FILE__ and __LINE__ data, you can match
uniquely against that and not worry about the compiler transforms.
Perhaps less user friendly as a function identifier, but meh, this isn't
aimed at users anyway, but kernel devs.

The kunit userspace could even scrape the __FILE__ and __LINE__ from the
kernel it was compiled against if it so wants. It should be simple
enough to write a tool that takes the source and a function name and
outputs the relevant __FILE__ and __LINE__ thingies. All you need is a
very rudimentary C parser and we've got a ton of those around.

> diff --git a/kernel/panic.c b/kernel/panic.c
> index c78600212b6c1..3cb004a7803f4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -39,6 +39,7 @@
>  #include <linux/sys_info.h>
>  #include <trace/events/error_report.h>
>  #include <asm/sections.h>
> +#include <kunit/bug.h>
> 
>  #define PANIC_TIMER_STEP 100
>  #define PANIC_BLINK_SPD 18
> @@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void
> *caller, unsigned taint,
>  void warn_slowpath_fmt(const char *file, int line, unsigned taint,
>                        const char *fmt, ...)
>  {
> -       bool rcu = warn_rcu_enter();
> +       bool rcu;
>         struct warn_args args;
> 
> +       if (__kunit_is_suppressed_warning_at((unsigned long)__builtin_return_address(0)))
> +               return;
> +
> +       rcu = warn_rcu_enter();
> +
>         pr_warn(CUT_HERE);
> 
>         if (!fmt) {
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 623c467a8b76c..e90b038d9225e 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -48,6 +48,7 @@
>  #include <linux/rculist.h>
>  #include <linux/ftrace.h>
>  #include <linux/context_tracking.h>
> +#include <kunit/bug.h>
> 
>  extern struct bug_entry __start___bug_table[], __stop___bug_table[];
> 
> @@ -223,6 +224,9 @@ static enum bug_trap_type __report_bug(struct
> bug_entry *bug, unsigned long buga
>         no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
>         has_args = bug->flags & BUGFLAG_ARGS;
> 
> +       if (warning && __kunit_is_suppressed_warning_at(bugaddr))
> +               return BUG_TRAP_TYPE_WARN;
> +

I suppose there's a question here if a suppressed warn counts towards
the once logic below.

>         if (warning && once) {
>                 if (done)
>                         return BUG_TRAP_TYPE_WARN;
> 
> diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> index 9c2c4ee013d92..13ffddb044636 100644
> --- a/lib/kunit/bug.c
> +++ b/lib/kunit/bug.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/instrumentation.h>
>  #include <linux/jump_label.h>
> +#include <linux/kallsyms.h>
>  #include <linux/rculist.h>
>  #include <linux/string.h>
> 
> @@ -68,4 +69,16 @@ noinstr bool __kunit_is_suppressed_warning(const
> char *function)
>  }
>  EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning);
> 
> +bool __kunit_is_suppressed_warning_at(unsigned long addr)
> +{
> +       char buf[KSYM_SYMBOL_LEN];
> +
> +       if (!static_branch_unlikely(&kunit_suppress_warnings_key))
> +               return false;

At this point you don't need this to be a static_branch either, both
callers are already in warn slowpaths and nobody cares.

> +       if (sprint_symbol_no_offset(buf, addr) <= 0)
> +               return false;
> +       return __kunit_check_suppress(buf);
> +}
> +EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning_at);

I don't think you need this export, both callers are definitely
in-kernel.
