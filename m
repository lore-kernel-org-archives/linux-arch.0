Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A4C433EF
	for <linux-arch@archiver.kernel.org>; Mon, 14 Feb 2022 07:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiBNHud (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBNHuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 02:50:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F545AEE3;
        Sun, 13 Feb 2022 23:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:References;
        bh=jciESuD7KkzOvrqFddq5ei3J58DoUHqc9C5Rydzc4hg=; b=ErVgdFGCyNNxww5f7hf/07MEwA
        eO/VTA8rQ8dirRDJco/8BjyYJASyRoVeJc3JhpACcw2y9KulXRrMp4dG1qfeMn81z/J0ruwzdpfT9
        X2LL1vtZ4q38flprm7P8gEtPpEISjO7UMA3BywnfI/G466qY3gk9WMTF9Ilys74Sye2ZOKvPkoNlO
        1RtAHerqFSq5PFk+s78fw/rPdHBmahvBCzG+h36GLtTPENrZevdDgViDcnW3UVrn550LFwIf0FWgi
        5dSK4a6ZXKB/SWWt55zkB5pw0VckR7OX6kVs4mNd21LvQ0cnBSqomwZzh+2+Cm4EdbmmlmqsXhBBA
        lJrLrufg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJW7p-00DlZB-4w; Mon, 14 Feb 2022 07:50:21 +0000
Date:   Sun, 13 Feb 2022 23:50:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgoJvSFFTSb6apGl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I like the series a lot.

Superficial comments:

for nds32 is there any good reason why __get_user / __set_user check
the address limit directly?  Maybe we should unify this and make it work
like the other architectures.

With "uaccess: add generic __{get,put}_kernel_nofault" we should be able
to remove HAVE_GET_KERNEL_NOFAULT entirely and just check if the helpers
are already defined in linux/uaccess.h.

The new generic __access_ok, and the 3 fixed up version early on
have a whole lot of superflous braces.
