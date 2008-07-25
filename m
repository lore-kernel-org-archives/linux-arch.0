From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] flag parameters: fix compile error of sys_epoll_create1
Date: Fri, 25 Jul 2008 12:30:13 +0200
Message-ID: <20080725103012.GA11796@elte.hu>
References: <48898461.4070603@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:43399 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbYGYKa3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 06:30:29 -0400
Content-Disposition: inline
In-Reply-To: <48898461.4070603@cn.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wang Chen <wangchen@cn.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Davide Libenzi <davidel@xmailserver.org>, Ulrich Drepper <drepper@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


* Wang Chen <wangchen@cn.fujitsu.com> wrote:

>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      vmlinux
> arch/x86/kernel/built-in.o: In function `sys_call_table':
> (.rodata+0x8a4): undefined reference to `sys_epoll_create1'
> make: *** [vmlinux] Error 1

just ran into this too - 64-bit allnoconfig triggers it.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
