Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51023 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbaBXICn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2014 03:02:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and family
Date: Mon, 24 Feb 2014 09:02:35 +0100
References: <20140222192325.GA12587@thin>
In-Reply-To: <20140222192325.GA12587@thin>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201402240902.35977.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20140224080235.yd3wZtpy7YQrPQV-WuPnjnFJBATKmdguJpoG3JSViN0@z>

On Saturday 22 February 2014, Josh Triplett wrote:
> When !CONFIG_BUG, WARN_ON and family become simple passthroughs of their
> condition argument; however, WARN_ON_ONCE and family still have
> conditions and a boolean to detect one-time invocation, even though the
> warning they'd emit doesn't exist.  Make the existing definitions
> conditional on CONFIG_BUG, and map them all to the passthrough WARN_ON
> when !CONFIG_BUG.
> 
> This saves 4.4k on a minimized configuration (smaller than
> allnoconfig), and 20.6k with defconfig plus CONFIG_BUG=n.

This looks good, but it reminds me of a patch that I did a while ago
and that got lost while I was on leave:

> +#else /* !CONFIG_BUG */
> +#ifndef HAVE_ARCH_BUG
> +#define BUG() do {} while(0)
> +#endif
> +
> +#ifndef HAVE_ARCH_BUG_ON
> +#define BUG_ON(condition) do { if (condition) ; } while(0)
> +#endif

I've done some analysis of this before[1] and came to the conclusion that
this definition (which I realize you are not changing) is bad.

For one thing, it will cause lots of gcc warnings about code that
should have been unreachable being compiled. It also causes
misoptimizations for code that should be detected as unused or
(worse) lets us run into undefined behavior if we ever get into
the BUG() case.

This means we actually want BUG() to end with __builtin_unreachable()
as in the CONFIG_BUG=y case, and also ensure it actually is
unreachable. As I have shown in [1], the there is a small overhead
of doing this in terms of code size.

> +#ifndef HAVE_ARCH_WARN_ON
> +#define WARN_ON(condition) ({						\
> +	int __ret_warn_on = !!(condition);				\
> +	unlikely(__ret_warn_on);					\
> +})
> +#endif
> +
> +#ifndef WARN
> +#define WARN(condition, format...) ({					\
> +	int __ret_warn_on = !!(condition);				\
> +	unlikely(__ret_warn_on);					\
> +})
> +#endif


FWIW, there is an easy extension to this to get rid of some "unused variable"
warnings, but using the format string in an unreachable part of the macro,
as I did in my patch (but didn't explain there):

@@ -125,6 +126,8 @@ extern void warn_slowpath_null(const char *file, const int line);
 #ifndef WARN
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
+	if (0 && (__ret_warn_on))					\
+		printk(format);						\
 	unlikely(__ret_warn_on);					\
 })
 #endif


	Arnd

[1] http://lkml.org/lkml/2013/7/12/121
