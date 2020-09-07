Return-Path: <SRS0=71DO=CQ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9938C433E2
	for <linux-arch@archiver.kernel.org>; Mon,  7 Sep 2020 05:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5ED20838
	for <linux-arch@archiver.kernel.org>; Mon,  7 Sep 2020 05:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kc3xXJaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIGF6h (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 7 Sep 2020 01:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIGF6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED4C061573;
        Sun,  6 Sep 2020 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ngzswZtKXcd2zI4NzevNwUNXyZikinlURXNEXQYjmEA=; b=kc3xXJaL3wBgnsWsgdPkruCI4F
        5Bzt1jtrfRYSHnPUcOwtvUy4kW423EybGBpNesUtDCFWtY1gAlWT4phrHv7ZDpNQNVk4bwLVVpUwO
        EmQ+ygOWaxa1Uj3YpdfYLi9XrBgOcxdDXrmp0Ue1A2MGcwbiu2xsxDE2AtuMWffHOywtHal95rVoh
        o1OAOUQCml2MxRcbNl3u6X0ayMOrmd5KW9KYeaDhQpobGN8S5pTDazQzDxZ9hL3OIKW4rBZ4Zb+Pl
        PH44NUkMafM4iy/q7+ny8koTmnwj40z3KKmSJbVPeWaWAVWmMCa8zaLibo0BZ0hr9HRIE97Np7/ux
        iWDqAMhA==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAc-00034K-P9; Mon, 07 Sep 2020 05:58:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: remove set_fs for riscv v2
Date:   Mon,  7 Sep 2020 07:58:17 +0200
Message-Id: <20200907055825.1917151-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

this series converts riscv to the new set_fs less world and is on top of this
branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs

The first four patches are general improvements and enablement for all nommu
ports, and might make sense to merge through the above base branch.

Changes since v1:
 - implement __get_user_fn and __put_user_fn for the UACCESS_MEMCPY case
   and remove the small constant size optimizations in raw_copy_from_user
   and raw_copy_to_user
 - reshuffle the patch order a little

Diffstat
 arch/riscv/Kconfig                   |    2 
 arch/riscv/include/asm/thread_info.h |    6 -
 arch/riscv/include/asm/uaccess.h     |  177 +++++++++++++++++------------------
 arch/riscv/kernel/process.c          |    1 
 arch/riscv/lib/Makefile              |    2 
 include/asm-generic/uaccess.h        |  109 +++++++++++++--------
 include/linux/uaccess.h              |    4 
 7 files changed, 166 insertions(+), 135 deletions(-)
