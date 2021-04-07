Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ED4C433ED
	for <linux-arch@archiver.kernel.org>; Wed,  7 Apr 2021 14:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5293161260
	for <linux-arch@archiver.kernel.org>; Wed,  7 Apr 2021 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352918AbhDGOae (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhDGOad (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 10:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11C6360FE9;
        Wed,  7 Apr 2021 14:30:22 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:30:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/20] kbuild: arm64: use common install script
Message-ID: <20210407143020.GB21451@arm.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-10-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:08AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for arm65, no changes
> needed so convert the arm64 boot Makefile to call it instead of the
> arm64-only version of the file and remove the now unused file.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Assuming that it does the same thing (it seems to from a quick look):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
