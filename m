Return-Path: <SRS0=FP76=DO=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98DC41604
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ABB214DB
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJGPYc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPY1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:24:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCFC061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:24:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBIg-000zPr-8r; Wed, 07 Oct 2020 17:24:18 +0200
Message-ID: <5caf34d16a0f2816b47cd8712ca7d59e9733a815.camel@sipsolutions.net>
Subject: Re: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:24:17 +0200
In-Reply-To: <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This commit fixes numbers of warning messages about leaked CONFIG
> options.

No it doesn't ... it suppresses them, not a fan at all.

> nommu mode of UML requires copies of kernel headers to offer
> syscall-like API for the library users.  Thus, the warnings are to be
> avoided to function this exposure of API.

I don't see that here, so maybe make that part of the patch where it
actually happens, with a big comment, and maybe only when actually
building for NOMMU/LKL?

johannes


