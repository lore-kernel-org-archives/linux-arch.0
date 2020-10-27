Return-Path: <SRS0=bmjM=EC=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62281C63777
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A26020657
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603811792;
	bh=KcMcjP39WQb3PP6WZMwWmoTo3qIlZlixFqdmI1nRxjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWVP1lTk58FXId2U8+6jopjPP/KFHy14HR0A7sPYyD6HR3PdhwTgNbKwTONdD9+jS
	 9HY1vKysQwVnl2yVeTdQBNh+LOoM5M04ocysDGfYCsCNP9blEoQph87QJYmRZ8ldLI
	 xRGthZpPkwiOJlaCZEtbMoiCn25GxMh4CISPGAjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1796265AbgJ0PQT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 27 Oct 2020 11:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1795066AbgJ0PPB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 11:15:01 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D95521D41;
        Tue, 27 Oct 2020 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603811701;
        bh=KcMcjP39WQb3PP6WZMwWmoTo3qIlZlixFqdmI1nRxjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lca6q57+3Tztb3zk1GZBAc7Igp4rDQBasPqGFInsMjLICkIsIDCfSUCR6LBML2n/Z
         m4j2cI6BoAL7HTxqr4vWM9XFxnGqcE7h48sykhRnlPDDdnmoEXRjrFo4RnCA8ebB//
         9/utw8+gxqTjkFlwU7jiwvGPU+y+WSP+X9hgG/JU=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        palmerdabbelt@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: mark __{get,put}_user_fn as __always_inline
Date:   Tue, 27 Oct 2020 16:14:53 +0100
Message-Id: <160381164874.4082358.6150613146628051056.b4-ty@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201027085017.3705228-1-hch@lst.de>
References: <20201027085017.3705228-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Tue, 27 Oct 2020 09:50:17 +0100, Christoph Hellwig wrote:
> Without the explicit __always_inline, some RISC-V configs place the
> functions out of line, triggering the BUILD_BUG_ON checks in the
> function.

Applied to asm-generic-fixes, thanks!

[1/1] asm-generic: mark __{get,put}_user_fn as __always_inline
      commit: 0bcd0a2be8c9ef39d84d167ff85359a49f7be175

       Arnd
