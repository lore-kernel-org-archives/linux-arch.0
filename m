Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F06EC04A6A
	for <linux-arch@archiver.kernel.org>; Fri, 21 Jul 2023 10:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGUKOv (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 21 Jul 2023 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGUKOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 06:14:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEA7F2D58;
        Fri, 21 Jul 2023 03:14:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60992F4;
        Fri, 21 Jul 2023 03:15:28 -0700 (PDT)
Received: from [10.57.64.194] (unknown [10.57.64.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D5473F738;
        Fri, 21 Jul 2023 03:14:44 -0700 (PDT)
Message-ID: <acb25476-f5d1-3dfd-8e76-1a582b63dada@arm.com>
Date:   Fri, 21 Jul 2023 11:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-2-willy@infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230710204339.3554919-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/07/2023 21:43, Matthew Wilcox (Oracle) wrote:
> Determine if a value lies within a range more efficiently (subtraction +
> comparison vs two comparisons and an AND).  It also has useful (under
> some circumstances) behaviour if the range exceeds the maximum value of
> the type.

Sorry it's taken me a while to looking at this.

I'm getting a lot of warnings about in_range() being redefined when building
arm64 (defconfig-ish) with this patch set on top of v6.5-rc2.

Looks like there are multiple existing implementations.

Thanks,
Ryan

