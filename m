Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A876C433F5
	for <linux-arch@archiver.kernel.org>; Fri,  4 Feb 2022 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiBDOzC (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:55:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51108 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDOzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Feb 2022 09:55:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5A26115F
        for <linux-arch@vger.kernel.org>; Fri,  4 Feb 2022 14:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E653C004E1;
        Fri,  4 Feb 2022 14:54:59 +0000 (UTC)
Date:   Fri, 4 Feb 2022 14:54:55 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 4/4] elf: Remove has_interp property from
 arch_parse_elf_property()
Message-ID: <Yf0+P+1lAVdMI8rw@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220124150704.2559523-5-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150704.2559523-5-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 03:07:04PM +0000, Mark Brown wrote:
> Since all current users of arch_parse_elf_property() are able to treat the
> interpreter and main executable orthogonaly the has_interp argument is now
> redundant so remove it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-By: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
