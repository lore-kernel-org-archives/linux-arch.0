Return-Path: <SRS0=eeVS=EJ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0418FC2D0A3
	for <linux-arch@archiver.kernel.org>; Tue,  3 Nov 2020 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04D122264
	for <linux-arch@archiver.kernel.org>; Tue,  3 Nov 2020 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tz2Yhfv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCIfl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCIfl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 03:35:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650BC0613D1;
        Tue,  3 Nov 2020 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0eIRPF1ESaGV3yiCnvAzM4yO3j7M3IOuEBg1csgujt4=; b=Tz2Yhfv/344RsiHOb8HxBaMlNl
        kOGsEjdZrvtCXbgMQADGPmx0nxNPRYeoy4Af7kIo7mjroBpSnS2pSzJN6HkEPsnqv/8g4KNYT2mKm
        95mueY13d8rpGlNe2N3Y+PMCKph9HPUURR2fucclpVnpOplkRaQN59D8jgP+BNBCpxHWyc8Ik3c8p
        9qHYy+5faBzAfQQ0hH4h9Qm5+QM6RxRVFyCwy/9B/tKJBm1w3CJwJATXu3R7mDfvR1JQfc7hWZ3r4
        bUYXorE4S/8icfzDu/qr4bWaqngGLOtTPlKxKYYLiX2cNkcXU0T87L53pcPvHz6vbXzu2aBU20MYE
        YMzVgWMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZrmv-0002av-88; Tue, 03 Nov 2020 08:35:33 +0000
Date:   Tue, 3 Nov 2020 08:35:33 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 1/4] kexec: simplify compat_sys_kexec_load
Message-ID: <20201103083533.GB9092@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102123151.2860165-2-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +	for (i=0; i < nr_segments; i++) {

Missing spaces around the "=".

> +SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> +		struct kexec_segment __user *, segments, unsigned long, flags)
> +{
> +	return kernel_kexec_load(entry, nr_segments, segments, flags);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>  		       compat_ulong_t, nr_segments,
>  		       struct compat_kexec_segment __user *, segments,
>  		       compat_ulong_t, flags)
>  {
> +	return kernel_kexec_load(entry, nr_segments,
> +				 (struct kexec_segment __user *)segments,
> +				 flags);
>  }

I don't think we need sys_compat_kexec_load at all now, all the syscall
tables can simply switch to sys_kexec_load for the compat case as well
now.
