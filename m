Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9158AC49EA5
	for <linux-arch@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D6561606
	for <linux-arch@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhFZKlT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 26 Jun 2021 06:41:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhFZKlQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2P2tvPz9sxS; Sat, 26 Jun 2021 20:38:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, dja@axtens.net
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oliver O'Halloran <oohall@gmail.com>
In-Reply-To: <cover.1618828806.git.christophe.leroy@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 0/4] Convert powerpc to GENERIC_PTDUMP
Message-Id: <162470383963.3589875.4353977558954497976.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 19 Apr 2021 10:47:24 +0000 (UTC), Christophe Leroy wrote:
> This series converts powerpc to generic PTDUMP.
> 
> For that, we first need to add missing hugepd support
> to pagewalk and ptdump.
> 
> v2:
> - Reworked the pagewalk modification to add locking and check ops->pte_entry
> - Modified powerpc early IO mapping to have gaps between mappings
> - Removed the logic that checked for contiguous physical memory
> - Removed the articial level calculation in ptdump_pte_entry(), level 4 is ok for all.
> - Removed page_size argument to note_page()
> 
> [...]

Patches 2 and 4 pplied to powerpc/next.

[2/4] powerpc/mm: Leave a gap between early allocated IO areas
      https://git.kernel.org/powerpc/c/57307f1b6edd781fba2bf9f7ec5f4d17a881ea54
[3/4] powerpc/mm: Properly coalesce pages in ptdump
      https://git.kernel.org/powerpc/c/6ca6512c716afd6e37281372c4c35aa6afd71d10

cheers
