Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47067 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKST1i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2019 14:27:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so25887855qtp.13
        for <linux-arch@vger.kernel.org>; Tue, 19 Nov 2019 11:27:38 -0800 (PST)
Message-ID: <1574191653.9585.6.camel@lca.pw>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
From: Qian Cai <cai@lca.pw>
Date: Tue, 19 Nov 2019 14:27:33 -0500
In-Reply-To: <20191114180303.66955-2-elver@google.com>
References: <20191114180303.66955-1-elver@google.com>
         <20191114180303.66955-2-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, edumazet@google.com, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191119192733.hDvtQCkZrWYIoxwShWsfcwByARTRQ6UP4USt7v0LZaA@z>

On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:

> +menuconfig KCSAN
> +	bool "KCSAN: watchpoint-based dynamic data race detector"
> +	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE

"!KASAN" makes me sorrow. What's problem of those two?

> +	default n
> +	help
> +	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
> +	  uses a watchpoint-based sampling approach to detect races. See
> +	  <file:Documentation/dev-tools/kcsan.rst> for more details.
> +
