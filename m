Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157EEC433F5
	for <linux-arch@archiver.kernel.org>; Mon, 25 Oct 2021 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E900A60FDC
	for <linux-arch@archiver.kernel.org>; Mon, 25 Oct 2021 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhJYU6A (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:58:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56310 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhJYU5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 16:57:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:46434)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf706-00AmGX-0a; Mon, 25 Oct 2021 14:55:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39982 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf704-00CQtV-7C; Mon, 25 Oct 2021 14:55:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-5-ebiederm@xmission.com>
        <alpine.DEB.2.21.2110240622100.45807@angie.orcam.me.uk>
Date:   Mon, 25 Oct 2021 15:55:13 -0500
In-Reply-To: <alpine.DEB.2.21.2110240622100.45807@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Sun, 24 Oct 2021 06:24:17 +0200 (CEST)")
Message-ID: <87y26gx1se.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mf704-00CQtV-7C;;;mid=<87y26gx1se.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+evW9omsIww1rKO9bifehdIM1qfwCNJao=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Maciej W. Rozycki" <macro@orcam.me.uk> writes:

> On Wed, 20 Oct 2021, Eric W. Biederman wrote:
>
>> When an instruction to save or restore a register from the stack fails
>> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
>> change was made to r2300_fpu.S[1] but it looks like it got lost with
>> the introduction of EX2[2].  This is also what the other implementation
>> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
>> what is needed for the callers to be able to handle the error.
>
>  Umm, right, good catch, thanks!  I think this ought to be backported.
>
> Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
>

I will add a CC stable.  So it can be backported after it is merged.

Eric
