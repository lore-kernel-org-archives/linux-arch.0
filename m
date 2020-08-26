Return-Path: <SRS0=Iq1u=CE=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A5C433DF
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D721420838
	for <linux-arch@archiver.kernel.org>; Wed, 26 Aug 2020 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgHZKCL (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgHZKCL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 06:02:11 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE522067C;
        Wed, 26 Aug 2020 10:02:08 +0000 (UTC)
Date:   Wed, 26 Aug 2020 11:02:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 07/12] arm64: inline huge vmap supported functions
Message-ID: <20200826100205.GA6712@gaia>
References: <20200825145753.529284-1-npiggin@gmail.com>
 <20200825145753.529284-8-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825145753.529284-8-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 12:57:48AM +1000, Nicholas Piggin wrote:
> This allows unsupported levels to be constant folded away, and so
> p4d_free_pud_page can be removed because it's no longer linked to.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> Ack or objection if this goes via the -mm tree?

No objections.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
