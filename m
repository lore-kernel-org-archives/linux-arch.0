Return-Path: <SRS0=FP76=DO=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6EEC4727E
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E061B215A4
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgJGPpf (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgJGPpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:45:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F52C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:45:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBd9-0010lY-9Q; Wed, 07 Oct 2020 17:45:27 +0200
Message-ID: <0563db2b81f44028515e19b8edeb50e1cf29d922.camel@sipsolutions.net>
Subject: Re: [RFC v7 09/21] um: nommu: host interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:45:26 +0200
In-Reply-To: <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This patch introduces the host operations that define the interface
> between the LKL and the host. These operations must be provided either
> by a host library or by the application itself.
> 

I kinda find patches like this very pointless ... you see nothing, and
can't really say anything. Maybe add the infra with the first user?

> +/* Defined in {posix,nt}-host.c */

That doesn't exist either yet ...

johannes

