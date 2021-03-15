Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E00FC433E6
	for <linux-arch@archiver.kernel.org>; Mon, 15 Mar 2021 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3FC64F4A
	for <linux-arch@archiver.kernel.org>; Mon, 15 Mar 2021 19:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhCOTOd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhCOTOE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Mar 2021 15:14:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 542F764E6B;
        Mon, 15 Mar 2021 19:14:02 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexey Klimov <aklimov@redhat.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: (subset) [PATCH 0/2] arch: enable GENERIC_FIND_FIRST_BIT for MIPS and ARM64
Date:   Mon, 15 Mar 2021 19:14:00 +0000
Message-Id: <161583561181.30130.15256425173316985861.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210225135700.1381396-1-yury.norov@gmail.com>
References: <20210225135700.1381396-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Feb 2021 05:56:58 -0800, Yury Norov wrote:
> MIPS and ARM64 don't implement find_first_{zero}_bit in arch code and
> don't enable it in config. It leads to using find_next_bit() which is
> less efficient:
> 
> It's beneficial to enable GENERIC_FIND_FIRST_BIT as this functionality
> is not new at all and well-tested. It provides more optimized code and
> saves .text memory:
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] ARM64: enable GENERIC_FIND_FIRST_BIT
      https://git.kernel.org/arm64/c/98c5ec77c7c5

-- 
Catalin

