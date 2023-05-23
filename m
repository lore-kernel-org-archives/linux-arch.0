Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F32EC7EE23
	for <linux-arch@archiver.kernel.org>; Tue, 23 May 2023 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjEWJme (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 23 May 2023 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjEWJmd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 05:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDD130;
        Tue, 23 May 2023 02:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81D2462E24;
        Tue, 23 May 2023 09:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E6C433EF;
        Tue, 23 May 2023 09:42:29 +0000 (UTC)
Date:   Tue, 23 May 2023 10:42:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/7] arm64: Update Documentation/arm references
Message-ID: <ZGyKgvDfl4mree82@arm.com>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-4-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519164607.38845-4-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023 at 10:46:03AM -0600, Jonathan Corbet wrote:
> The Arm documentation has moved to Documentation/arch/arm; update
> references under arch/arm64 to match.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
