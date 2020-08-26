Return-Path: <SRS0=Iq1u=CE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A42C433E3
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F4C2078D
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZPZU (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgHZPZQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 11:25:16 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507272075E;
        Wed, 26 Aug 2020 15:25:15 +0000 (UTC)
Date:   Wed, 26 Aug 2020 16:25:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/23] arm64: use asm-generic/mmu_context.h for no-op
 implementations
Message-ID: <20200826152510.GB24545@gaia>
References: <20200826145249.745432-1-npiggin@gmail.com>
 <20200826145249.745432-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826145249.745432-6-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 12:52:31AM +1000, Nicholas Piggin wrote:
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
