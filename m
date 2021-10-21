Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D17C433F5
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716A560F57
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhJUPOM (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:14:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56470 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhJUPOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 11:14:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:49138)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZjW-00HSiJ-PB; Thu, 21 Oct 2021 09:11:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51076 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZjV-00CXjS-FN; Thu, 21 Oct 2021 09:11:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-12-ebiederm@xmission.com>
        <YXFLFUjGsvdK13Sa@infradead.org>
Date:   Thu, 21 Oct 2021 10:11:46 -0500
In-Reply-To: <YXFLFUjGsvdK13Sa@infradead.org> (Christoph Hellwig's message of
        "Thu, 21 Oct 2021 04:12:21 -0700")
Message-ID: <87wnm6h0p9.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdZjV-00CXjS-FN;;;mid=<87wnm6h0p9.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19u0wOTfTJ+w+da1gXdYf5UxQQOSI4+4bY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 12/20] exit/kthread: Have kernel threads return instead of calling do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Oct 20, 2021 at 12:43:58PM -0500, Eric W. Biederman wrote:
>> In 2009 Oleg reworked[1] the kernel threads so that it is not
>> necessary to call do_exit if you are not using kthread_stop().  Remove
>> the explicit calls of do_exit and complete_and_exit (with a NULL
>> completion) that were previously necessary.
>
> With this we should also be able to drop the export for do_exit.

Good point.

After this set of changes I don't see any calls of do_exit in drivers
or other awkward places so that would make a good addition.

Eric

