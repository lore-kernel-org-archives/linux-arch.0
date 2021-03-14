Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1AEC433DB
	for <linux-arch@archiver.kernel.org>; Sun, 14 Mar 2021 20:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3DC64EBE
	for <linux-arch@archiver.kernel.org>; Sun, 14 Mar 2021 20:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhCNUhw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhCNUhw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 16:37:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B330C061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 13:37:52 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLXUb-00G7Ez-EQ; Sun, 14 Mar 2021 21:37:41 +0100
Message-ID: <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 21:37:40 +0100
In-Reply-To: <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 24c6596260de..5fb6a852d058 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -29,6 +29,10 @@ config UMMODE_LIB
>  	select UACCESS_MEMCPY
>  	select ARCH_THREAD_STACK_ALLOCATOR
>  	select ARCH_HAS_SYSCALL_WRAPPER
> +	select VFAT_FS
> +	select NLS_CODEPAGE_437
> +	select NLS_ISO8859_1
> +	select BTRFS_FS

That doesn't really seem to make sense - the sample might need it, but
generally LKL doesn't/shouldn't?

johannes

