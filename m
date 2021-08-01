Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C28CC4338F
	for <linux-arch@archiver.kernel.org>; Sun,  1 Aug 2021 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D72260F70
	for <linux-arch@archiver.kernel.org>; Sun,  1 Aug 2021 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHAVkb (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 1 Aug 2021 17:40:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:44069 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhHAVkb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Aug 2021 17:40:31 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 171LWnvj015149;
        Sun, 1 Aug 2021 16:32:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 171LWlIp015148;
        Sun, 1 Aug 2021 16:32:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 1 Aug 2021 16:32:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <20210801213247.GM1583@gate.crashing.org>
References: <20210801201336.2224111-1-adobriyan@gmail.com> <20210801201336.2224111-3-adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801201336.2224111-3-adobriyan@gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> In theory, it enables "leakage" of userspace headers into kernel which
> may present licensing problem.

> -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> +NOSTDINC_FLAGS += -nostdinc

This is removing the compiler's own include files.  These are required
for all kinds of basic features, and required to be compliant to the C
standard at all.  These are not "userspace headers", that is what
-nostdinc takes care of already.

In the case of GCC all these headers are GPL-with-runtime-exception, so
claiming this can cause licensing problems is fearmongering.

I strongly advise against doing this.


Segher
