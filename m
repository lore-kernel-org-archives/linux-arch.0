Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9CC433EF
	for <linux-arch@archiver.kernel.org>; Fri,  7 Jan 2022 19:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiAGTBl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:01:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40118 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiAGTBk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 14:01:40 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:58856)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uUc-00HEXO-Sv; Fri, 07 Jan 2022 12:01:38 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:48588 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uUb-002BFF-JJ; Fri, 07 Jan 2022 12:01:38 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 5 Jan 2022 05:48:08 +0000")
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-3-ebiederm@xmission.com>
        <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 07 Jan 2022 12:59:33 -0600
Message-ID: <87tuefwewa.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5uUb-002BFF-JJ;;;mid=<87tuefwewa.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ylOQ812OzYa8pP/ypTCEqNmeufvP4Onc=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
>> -	/*
>> -	 * If do_exit is called because this processes oopsed, it's possible
>> -	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
>> -	 * continuing. Amongst other possible reasons, this is to prevent
>> -	 * mm_release()->clear_child_tid() from writing to a user-controlled
>> -	 * kernel address.
>> -	 */
>> -	force_uaccess_begin();
>
> Are you sure about that one?  It shouldn't matter, but... it's a potential
> change for do_exit() from a kernel thread.  As it is, we have that
> force_uaccess_begin() for exiting threads and for kernel ones it's not
> a no-op.  I'm not concerned about attempted userland access after that
> point for those, obviously, but I'm not sure you won't step into something
> subtle here.
>
> I would prefer to split that particular change off into a separate commit...

Thank you for catching that.  I was leaning too much on the description
in the comment of why force_uaccess_begin is there.

Catching up on the state of set_fs/get_fs removal it appears like a lot
of progress has been made and on a lot of architectures set_fs/get_fs is
just gone, and force_uaccess_begin is a noop.

On architectures that still have set_fs/get_fs it appears all of the old
warts are present and kernel threads still run with set_fs(KERNEL_DS).

Assuming it won't be too much longer before the rest of the arches have
set_fs/get_fs removed it looks like it makes sense to leave the
force_uaccess_begin where it is, and just let force_uaccess_begin be
removed when set_fs/get_fs are removed from the tree.

Christoph does it look like the set_fs/get_fs removal work is going
to stall indefinitely on some architectures?  If so I think we want to
find a way to get kernel threads to run with set_fs(USER_DS) on the
stalled architectures.  Otherwise I think we have a real hazard of
introducing bugs that will only show up on the stalled architectures.

I finally understand now why when I updated set_child_tid in the kthread
code early in fork why x86 was fine another architecture was not.

Eric
