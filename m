Return-Path: <SRS0=YYpG=B4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1269C433E1
	for <linux-arch@archiver.kernel.org>; Tue, 18 Aug 2020 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E5420786
	for <linux-arch@archiver.kernel.org>; Tue, 18 Aug 2020 17:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHRR56 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:57:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53273 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRR55 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 13:57:57 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k85rt-0005EW-F5; Tue, 18 Aug 2020 17:57:53 +0000
Date:   Tue, 18 Aug 2020 19:57:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Message-ID: <20200818175751.xg726hgyirbt354d@wittgenstein>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818174447.GV17456@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> > The only remaining function callable outside of kernel/fork.c is
> > _do_fork(). It doesn't really follow the naming of kernel-internal
> > syscall helpers as Christoph righly pointed out. Switch all callers and
> > references to kernel_clone() and remove _do_fork() once and for all.
> 
> My only concern is around return type.  long, int, pid_t ... can we
> choose one and stick to it?  pid_t is probably the right return type
> within the kernel, despite the return type of clone3().  It'll save us
> some work if we ever go through the hassle of growing pid_t beyond 31-bit.

It should be safe to switch kernel_clone() to return pid_t. (Afair, the
syscall wrappers all have "long" as return type. (I think Linus provided
some more details on that in another mail. Also see
include/linux/syscalls.h. So the return type for clone3() is really
somewhat a userspace thing, I think.)

I wonder whether I should take the opportunity and switch the advertised
flag arguments for the legacy clone() syscalls and kernel_thread() from
unsigned long to unsigned int so we can get rid of the lower
		.flags		= (lower_32_bits(clone_flags) & ~CSIGNAL),
calls I added to fix sign extension issues glibc ran into...

Christian
