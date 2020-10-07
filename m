Return-Path: <SRS0=FP76=DO=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A663C47095
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51A7214DB
	for <linux-arch@archiver.kernel.org>; Wed,  7 Oct 2020 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJGPWZ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPWZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:22:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA15C061755
        for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2020 08:22:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQBGl-000zMC-KF; Wed, 07 Oct 2020 17:22:19 +0200
Message-ID: <255740d56676f005fc01e1a76959fef80ad68ef5.camel@sipsolutions.net>
Subject: Re: [RFC v7 04/21] um: host: implement os_initcalls and os_exitcalls
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, Octavian Purdila <tavi@cs.pub.ro>,
        retrage01@gmail.com
Date:   Wed, 07 Oct 2020 17:22:18 +0200
In-Reply-To: <d3bfb0e0e4300bb5191ae51918dd0795de343dc2.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
         <d3bfb0e0e4300bb5191ae51918dd0795de343dc2.1601960644.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:

> Note that this patch should be merged with "um: move arch/um/os-Linux
> dir to tools/um" but for now it is separate to make the review easier.

Not a fan of that, I must say ...

> +extern void (*__start_os_exitcalls)(void);
> +extern void (*__stop_os_exitcalls)(void);
> +
> +void os_exitcalls(void)
> +{
> +	exitcall_t *call;
> +
> +	call = &__stop_os_exitcalls;
> +	while (--call >= &__start_os_exitcalls)
> +		(*call)();

You should check for and skip NULL pointers, there always are alignment
issues with automatic section filling like this, more so with clang than
gcc.

> +}
> +
> +extern int (*__start_os_initcalls)(void);
> +extern int (*__stop_os_initcalls)(void);
> +
> +int os_initcalls(void)
> +{
> +	initcall_t *call;
> +
> +	call = &__stop_os_initcalls;
> +	while (--call >= &__start_os_initcalls)
> +		(*call)();

Same here.

johannes

