From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Sat, 25 Jun 2011 12:04:49 +0200
Message-ID: <20110625100449.GA19097@elte.hu>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308987512-6583-1-git-send-email-jonas@southpole.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Bonn <jonas@southpole.se>
Cc: rusty@rustcorp.com.au, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org


* Jonas Bonn <jonas@southpole.se> wrote:

> +/* This configures the module loader code to use the default implementations
> + * for the architecture specific hooks.  Architectures should set a #define
> + * for each of the hooks that it needs to override.
> + */

please use the standard (multi-line) comment style:

  /*
   * Comment .....
   * ...... goes here.
   */

specified in Documentation/CodingStyle.

(there are similar problems elsewhere in the patch as well.)

Also, and more importantly, don't we generally do such things via 
__weak aliases, because the result looks cleaner and needs no changes 
for architectures beyond the removal of the generic functions? We 
have excluded broken toolchains that miscompile/mislink __weak IIRC 
so __weak ought to work.

Thanks,

	Ingo
