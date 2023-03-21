Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38402C6FD1D
	for <linux-arch@archiver.kernel.org>; Tue, 21 Mar 2023 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCURPC (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCURO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 13:14:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0C12845;
        Tue, 21 Mar 2023 10:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C06FCB818FC;
        Tue, 21 Mar 2023 17:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345B8C433EF;
        Tue, 21 Mar 2023 17:13:44 +0000 (UTC)
Date:   Tue, 21 Mar 2023 17:13:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [PATCH v2 2/4] lib: test clear_user()
Message-ID: <ZBnlxb2eU4xzCRC8@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122514.1743889-3-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 12:25:12PM +0000, Mark Rutland wrote:
> +static void assert_clear_valid(struct kunit *test,
> +			       const struct usercopy_params *params,
> +			       const char *dst, long dst_offset,
> +			       unsigned long ret)
> +{
> +	const unsigned long size = params->size;
> +	const unsigned long offset = params->offset;

Nit: long offset.

Otherwise,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
