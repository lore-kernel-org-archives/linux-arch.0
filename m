From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC patch 06/15] LTTng build
Date: Fri, 17 Oct 2008 17:10:24 +0900 (JST)
Message-ID: <20081017170830.E22D.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20081016232729.699004293@polymtl.ca> <20081016234656.385520321@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:48327 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYJQIK2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Oct 2008 04:10:28 -0400
In-Reply-To: <20081016234656.385520321@polymtl.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: kosaki.motohiro@jp.fujitsu.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "William L. Irwin" <wli@holomorphy.com>

Hi

just nit

> Index: linux-2.6-lttng/Makefile
> ===================================================================
> --- linux-2.6-lttng.orig/Makefile	2008-10-16 18:16:33.000000000 -0400
> +++ linux-2.6-lttng/Makefile	2008-10-16 18:16:38.000000000 -0400
> @@ -619,7 +619,7 @@ export mod_strip_cmd
>  
>  
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
>  
>  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \

This patch depend on 07/15. it seems wrong patch order.
Then it cause following build error.


~/linux/linux-2.6.27-lttng% make
make
make[1]: `include/asm-ia64/nr-irqs.h' is up to date.
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
scripts/Makefile.build:41: /mnt/sdb1/kosaki/linux/linux-2.6.27-lttng/ltt/Makefile: No such file or directory
make[1]: *** No rule to make target `/mnt/sdb1/kosaki/linux/linux-2.6.27-lttng/ltt/Makefile'.  Stop.
make: *** [ltt] Error 2
