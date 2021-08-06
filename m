Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5087AC4338F
	for <linux-arch@archiver.kernel.org>; Fri,  6 Aug 2021 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A42A611C5
	for <linux-arch@archiver.kernel.org>; Fri,  6 Aug 2021 16:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhHFQEr (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhHFQEq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Aug 2021 12:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6143761165;
        Fri,  6 Aug 2021 16:04:29 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        kernel-team@android.com, Jade Alglave <jade.alglave@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: (subset) [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Date:   Fri,  6 Aug 2021 17:04:27 +0100
Message-Id: <162826584979.7468.15328966135917852100.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806113109.2475-1-will@kernel.org>
References: <20210806113109.2475-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Aug 2021 12:31:03 +0100, Will Deacon wrote:
> While reviewing Shameer's reworked VMID allocator [1] and discussing
> with Marc, we spotted a race between TLB invalidation (which typically
> takes an ASID or VMID argument) and reallocation of ASID/VMID for the
> context being targetted.
> 
> The first patch spells out an example with try_to_unmap_one() in a
> comment, which Catalin has kindly modelled in TLA+ at [2].
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/4] arm64: mm: Fix TLBI vs ASID rollover
      https://git.kernel.org/arm64/c/5e10f9887ed8

-- 
Catalin

