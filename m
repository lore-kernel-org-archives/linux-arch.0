Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:6365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264206AbUEDCi6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2004 22:38:58 -0400
Date: Mon, 3 May 2004 19:38:35 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-Id: <20040503193835.72c62ad8.akpm@osdl.org>
In-Reply-To: <200405031741.52504.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:
>
> The idea I had for preventing the same bug from happening
>  in the future is to provoke a compile error for modules using
>  'static DEFINE_PER_CPU', see patch below.

It's not a big success with CONFIG_SMP=n.

kernel/fork.c:55: warning: return-type defaults to `int'
kernel/fork.c: In function `__PER_CPU_NOSTATIC':
kernel/fork.c:55: parameter `per_cpu__process_counts' is initialized
kernel/fork.c:57: parameter `tasklist_lock' is initialized
kernel/fork.c:57: alignment may not be specified for `tasklist_lock'
kernel/fork.c:57: section attribute not allowed for `tasklist_lock'
kernel/fork.c:59: storage class specified for parameter `__crc_tasklist_lock'
kernel/fork.c:59: weak declaration of `__crc_tasklist_lock' must be public
kernel/fork.c:59: storage class specified for parameter `__kcrctab_tasklist_lock'
kernel/fork.c:59: parameter `__kcrctab_tasklist_lock' is initialized
kernel/fork.c:59: section attribute not allowed for `__kcrctab_tasklist_lock'
kernel/fork.c:59: storage class specified for parameter `__kstrtab_tasklist_lock'
kernel/fork.c:59: parameter `__kstrtab_tasklist_lock' is initialized
kernel/fork.c:59: section attribute not allowed for `__kstrtab_tasklist_lock'
kernel/fork.c:59: storage class specified for parameter `__ksymtab_tasklist_lock'
kernel/fork.c:59: parameter `__ksymtab_tasklist_lock' is initialized
kernel/fork.c:59: section attribute not allowed for `__ksymtab_tasklist_lock'
kernel/fork.c:62: parse error before `{'
kernel/fork.c:55: parm types given both in parmlist and separately
