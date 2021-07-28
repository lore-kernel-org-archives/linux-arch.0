Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BEAC4338F
	for <linux-arch@archiver.kernel.org>; Wed, 28 Jul 2021 15:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AAF60E09
	for <linux-arch@archiver.kernel.org>; Wed, 28 Jul 2021 15:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhG1P2l (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236793AbhG1P2l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 11:28:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED58260F91;
        Wed, 28 Jul 2021 15:28:37 +0000 (UTC)
Date:   Wed, 28 Jul 2021 11:28:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] kallsyms: Rename is_kernel() and
 is_kernel_text()
Message-ID: <20210728112836.289865f5@oasis.local.home>
In-Reply-To: <20210728081320.20394-6-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
        <20210728081320.20394-6-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 28 Jul 2021 16:13:18 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> The is_kernel[_text]() function check the address whether or not
> in kernel[_text] ranges, also they will check the address whether
> or not in gate area, so use better name.

Do you know what a gate area is?

Because I believe gate area is kernel text, so the rename just makes it
redundant and more confusing.

-- Steve
