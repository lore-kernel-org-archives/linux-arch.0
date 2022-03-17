Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A1BC433EF
	for <linux-arch@archiver.kernel.org>; Thu, 17 Mar 2022 09:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiCQJsG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiCQJsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 05:48:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31C1D7D95;
        Thu, 17 Mar 2022 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qA6MENEtbOnKxLxQVOH0ud0BbLlTVGZKx9qSfsjh7M=; b=gkygt28PPeixJWqoCdDEjatxVm
        EB4DflH8ok/qCvuqnejlHsxty4rwOyj9OSE49mLDz2vhgxO62t4tGyg6YrefluQiwtrsuO/bnKLFv
        ir1Z5YuDFUXMn1l2bA9ibju+jHG2AiJHVAN9/mbiZEwN0+61eOkcI9Hbm50HVuRT+aTvY+K4sWbWo
        gHi9ySkYyAvzIp+7diY5expc5fDs+ThTsnMlyRx7+PzgvAvSyXBCXQjOmKs2bVQ1/xmJr4LofnL1F
        HbT5ALLebqxJ3wUy2TgdgTt+o562eCoPFfB/1XEnk3ZSJfnG8BvhUQC2aaC/boNo18l2PUX4axprz
        cshy4y1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUmiG-006qcM-TH; Thu, 17 Mar 2022 09:46:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 525613001EA;
        Thu, 17 Mar 2022 10:46:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42268201CD1C3; Thu, 17 Mar 2022 10:46:32 +0100 (CET)
Date:   Thu, 17 Mar 2022 10:46:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mingo@redhat.com, Will Deacon <will@kernel.org>,
        longman@redhat.com, boqun.feng@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] openrisc: Move to ticket-spinlock
Message-ID: <YjMDeKw/3qxclCJf@hirez.programming.kicks-ass.net>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316232600.20419-4-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> We have no indications that openrisc meets the qspinlock requirements,
> so move to ticket-spinlock as that is more likey to be correct.
> 

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

