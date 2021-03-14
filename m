Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17041C433DB
	for <linux-arch@archiver.kernel.org>; Sun, 14 Mar 2021 16:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D411B64DE1
	for <linux-arch@archiver.kernel.org>; Sun, 14 Mar 2021 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhCNQx2 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhCNQxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 12:53:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBFFC061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 09:53:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLTzC-00G3IQ-MV; Sun, 14 Mar 2021 17:53:02 +0100
Message-ID: <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 17:53:01 +0100
In-Reply-To: <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> 
> +#else
> +
> +#include <asm-generic/nommu_context.h>
> +
> +extern void force_flush_all(void);
> 
nit: no need for "extern"

> +#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
> +#include <asm-generic/page.h>
> +
> +#define __va_space (8*1024*1024)
> +
> +#ifndef __ASSEMBLY__
> +#include <mem.h>

Is that <shared/mem.h>? I think we should start including only with that
prefix.

> +
> +void *uml_kmalloc(int size, int flags)
> +{
> +	return kmalloc(size, flags);
> +}

That could probably still be shared?

> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_rw(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_nx(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int set_memory_x(unsigned long addr, int numpages)
> +{
> +	return -EOPNOTSUPP;
> +}

UML for now no longer has these either.

johannes

