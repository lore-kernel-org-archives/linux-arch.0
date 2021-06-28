Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A055C49EA3
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161106144E
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhF1QXG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 28 Jun 2021 12:23:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44410 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhF1QXG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 12:23:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxtzw-005KQR-Lg; Mon, 28 Jun 2021 10:20:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35662 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxtzu-00FZAh-9G; Mon, 28 Jun 2021 10:20:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
        <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk>
        <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
        <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
Date:   Mon, 28 Jun 2021 11:20:03 -0500
In-Reply-To: <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
        (Geert Uytterhoeven's message of "Mon, 28 Jun 2021 09:31:36 +0200")
Message-ID: <87pmw6yn9o.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lxtzu-00FZAh-9G;;;mid=<87pmw6yn9o.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RdRCKClJS+touOsX/B9XRKKgr5ULM6Cg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/9] Refactoring exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Michael,
>
> On Mon, Jun 28, 2021 at 1:00 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> On 28/06/21 10:13 am, Al Viro wrote:
>> > On Thu, Jun 24, 2021 at 10:45:23PM +0000, Al Viro wrote:
>> >
>> >> 13) there's bdflush(1, whatever), which is equivalent to exit(0).
>> >> IMO it's long past the time to simply remove the sucker.
>> > Incidentally, calling that from ptraced process on alpha leads to
>> > the same headache for tracer.  _If_ we leave it around, this is
>> > another candidate for "hit yourself with that special signal" -
>> > both alpha and m68k have that syscall, and IMO adding an asm
>> > wrapper for that one is over the top.
>> >
>> > Said that, we really ought to bury that thing:
>> >
>> > commit 2f268ee88abb33968501a44368db55c63adaad40
>> > Author: Andrew Morton <akpm@digeo.com>
>> > Date:   Sat Dec 14 03:16:29 2002 -0800
>> >
>> >      [PATCH] deprecate use of bdflush()
>> >
>> >      Patch from Robert Love <rml@tech9.net>
>> >
>> >      We can never get rid of it if we do not deprecate it - so do so and
>> >      print a stern warning to those who still run bdflush daemons.
>> >
>> > Deprecated for 18.5 years by now - I seriously suspect that we have
>> > some contributors younger than that...
>>
>> Haven't found that warning in over 7 years' worth of console logs, and
>> I'm a good candidate for running the oldest userland in existence for m68k.
>>
>> Time to let it go.
>
> The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
> which is a very old ramdisk from right after the m68k a.out to ELF
> transition:
>
>     warning: process `update' used the obsolete bdflush system call
>     Fix your initscripts?
>
> I still boot it, once in a while.

The only thing left in bdflush is func == 1 calls do_exit(0);

Which is a hack introduced in 2.3.23 aka October of 1999 to force the
userspace process calling bdflush to exit, instead of repeatedly calling
sys_bdflush.

Can you try deleting that func == 1 call and seeing if your old ramdisk
works?

I suspect userspace used to get into a tight spin calling bdflush
func == 1, when that function stopped doing anything.  That was back in
1999 so we are probably safe with out it.

Eric
