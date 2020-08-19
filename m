Return-Path: <SRS0=n/+H=B5=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3961C433DF
	for <linux-arch@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C4F20882
	for <linux-arch@archiver.kernel.org>; Wed, 19 Aug 2020 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHSPF0 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:05:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52586 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgHSPFY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 11:05:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8PeB-008bgu-Nh; Wed, 19 Aug 2020 09:05:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8Pdz-0002ES-Gb; Wed, 19 Aug 2020 09:04:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Matthew Wilcox <willy@infradead.org>, peterz@infradead.org,
        Christoph Hewllig <hch@infradead.org>,
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
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
        <20200818174447.GV17456@casper.infradead.org>
        <20200819074340.GW2674@hirez.programming.kicks-ass.net>
        <20200819084556.im5zfpm2iquzvzws@wittgenstein>
        <20200819111851.GY17456@casper.infradead.org>
        <87a6yq222c.fsf@x220.int.ebiederm.org>
        <20200819134629.mvd4nupme7q2hmtz@wittgenstein>
Date:   Wed, 19 Aug 2020 10:01:16 -0500
In-Reply-To: <20200819134629.mvd4nupme7q2hmtz@wittgenstein> (Christian
        Brauner's message of "Wed, 19 Aug 2020 15:46:29 +0200")
Message-ID: <87mu2qznlv.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8Pdz-0002ES-Gb;;;mid=<87mu2qznlv.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7Z/n5uynSvWoygLfaQ9ENNpj25p3/XJs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Wed, Aug 19, 2020 at 08:32:59AM -0500, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Aug 19, 2020 at 10:45:56AM +0200, Christian Brauner wrote:
>> >> On Wed, Aug 19, 2020 at 09:43:40AM +0200, peterz@infradead.org wrote:
>> >> > On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
>> >> > > On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
>> >> > > > The only remaining function callable outside of kernel/fork.c is
>> >> > > > _do_fork(). It doesn't really follow the naming of kernel-internal
>> >> > > > syscall helpers as Christoph righly pointed out. Switch all callers and
>> >> > > > references to kernel_clone() and remove _do_fork() once and for all.
>> >> > > 
>> >> > > My only concern is around return type.  long, int, pid_t ... can we
>> >> > > choose one and stick to it?  pid_t is probably the right return type
>> >> > > within the kernel, despite the return type of clone3().  It'll save us
>> >> > > some work if we ever go through the hassle of growing pid_t beyond 31-bit.
>> >> > 
>> >> > We have at least the futex ABI restricting PID space to 30 bits.
>> >> 
>> >> Ok, looking into kernel/futex.c I see 
>> >> 
>> >> pid_t pid = uval & FUTEX_TID_MASK;
>> >> 
>> >> which is probably what this referes to and /proc/sys/kernel/threads-max
>> >> is restricted to FUTEX_TID_MASK.
>> >> 
>> >> Afaict, that doesn't block switching kernel_clone() to return pid_t. It
>> >> can't create anything > FUTEX_TID_MASK anyway without yelling EAGAIN at
>> >> userspace. But it means that _if_ we were to change the size of pid_t
>> >> we'd likely need a new futex API. 
>> >
>> > Yes, there would be a lot of work to do to increase the size of pid_t.
>> > I'd just like to not do anything to make that harder _now_.  Stick to
>> > using pid_t within the kernel.
>> 
>> Just so people are aware.  If you look in include/linux/threads.h you
>> can see that the maximum value of PID_MAX_LIMIT limits pids to 22 bits.
>> 
>> Further the design decisions of pids keeps us densly using pids.  So I
>> expect it will be a while before we even come close to using 30 bits of
>> pid space.
>
> Also because it's simply annoying to have to type really large pid
> numbers on the shell. Yes yes, that's a very privileged
> developer-centric complaint but it matters when you have to do a quick
> kill -9. Chromebook users obviously won't care about how large their
> pids are for sure.

Actually that is one of the reasons (possibly the primary reason) that
we have chosen to keep pid numbers dense.

There may be fewer users of unix shells then their used to be, and we
may now have pidfds.  But until people stop using pids in shells it is a
very valid reason to keep them densly packed.

> Tbf, related to discussions last year, systemd now actually raises the
> default limit from ~33000 to 4194304. Which seems like an ok compromise.

Intereseting.  I had not heard of that.  That seems a strange choice
for systemd rather than a system administrator to make.  Of course any
design decision that requires manual intervention to get large systems
to work is probably a bad one. 

Eric
