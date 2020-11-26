Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EFC63777
	for <linux-arch@archiver.kernel.org>; Thu, 26 Nov 2020 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8113E20B80
	for <linux-arch@archiver.kernel.org>; Thu, 26 Nov 2020 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bi1HMyEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgKZMMT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgKZMMR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:12:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC9C0617A7;
        Thu, 26 Nov 2020 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xt7yY/NU1cK34Ft0Kx73Y+tQyAWICtvPntKx9VSUTiM=; b=Bi1HMyEqJ70r9J5WDjCmkKXFTV
        opSsVHG/d6CBnX1VExcNgk6V0ChPO0Hq1Ld/J39P27UEh3VYKprp7JEl9v9zn2diwr/nBJyEJmpjT
        SOCdftZlFqDmh+44+c0sl0rhaBIKe4garZ4XRNowN4Wjlg+Kkg/0O9A8aO2iH//m850h/7PuRSkCw
        c7clCcg7tzQjBY9V2vJT42tuV022Lmc4br7gAPLsijTNXXfQs1xgguSVGLXrsVdMroKZ6goX3ozvO
        rEupq7Df8EloralzC86uMLxPn4RhKtFdq9BeuDElMSzIax+yTukw3TONgTZcvlAxunpWXia9XMP18
        TvzDoD0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG7c-0006M2-T5; Thu, 26 Nov 2020 12:11:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2880E30705A;
        Thu, 26 Nov 2020 13:11:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E527E200D4EF3; Thu, 26 Nov 2020 13:11:33 +0100 (CET)
Message-ID: <20201126120114.071913521@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 Nov 2020 13:01:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org
Subject: [PATCH v2 0/6] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

These patches provide generic infrastructure to determine TLB page size from
page table entries alone. Perf will use this (for either data or code address)
to aid in profiling TLB issues.

While most architectures only have page table aligned large pages, some
(notably ARM64, Sparc64 and Power) provide non page table aligned large pages
and need to provide their own implementation of these functions.

I've provided (completely untested) implementations for ARM64, Sparc64 and
Power/8xxx (it looks like I'm still missing Power/Book3s64/hash support).

Changes since -v1:

 - Changed wording to reflect these are page-table sizes; actual TLB sizes
   might vary.
 - added Power/8xx

Barring any objections I'll queue these in tip/perf/core, as these patches fix
the code that's currently in there.


