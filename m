From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] Kbuild: disable 'maybe-uninitialized' warning for
 CONFIG_PROFILE_ALL_BRANCHES
Date: Tue, 24 Nov 2015 11:20:43 +0100
Message-ID: <565439FB.6050800@suse.com>
References: <3799453.oCg1CdOrtm@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37945 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbbKXKUp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Nov 2015 05:20:45 -0500
In-Reply-To: <3799453.oCg1CdOrtm@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015-11-23 17:26, Arnd Bergmann wrote:
> These are all false positives that either rob someone's time when trying
> to figure out whether they are real, or they get people to send wrong
> patches to shut up the warnings.
[...]
> diff --git a/Makefile b/Makefile
> index 5e01a416c6e4..f8b921658f29 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,11 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
>  else
> -KBUILD_CFLAGS	+= -O2
> +ifdef CONFIG_PROFILE_ALL_BRANCHES
> +KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
> +else
> +KBUILD_CFLAGS   += -O2
> +endif

Does it only happen with -O2? Normally, we would add it outside the
ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.

Michal
