Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B068C433B4
	for <linux-arch@archiver.kernel.org>; Thu, 20 May 2021 05:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D130611AE
	for <linux-arch@archiver.kernel.org>; Thu, 20 May 2021 05:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETFVP (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 20 May 2021 01:21:15 -0400
Received: from verein.lst.de ([213.95.11.211]:40710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhETFVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 01:21:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6CAC67373; Thu, 20 May 2021 07:19:51 +0200 (CEST)
Date:   Thu, 20 May 2021 07:19:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [asm-generic:compat-alloc-user-space-9 6/41]
 net/ethtool/ioctl.c:815:9: error: implicit declaration of function
 'in_ia32_syscall'; did you mean 'in_compat_syscall'?
Message-ID: <20210520051951.GA21165@lst.de>
References: <202105200456.B8lcITGX-lkp@intel.com> <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 10:33:08PM +0200, Arnd Bergmann wrote:
>  static bool ethtool_translate_compat(void)
>  {
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>         /* On x86, translation is needed for i386 but not x32 */
>         return in_ia32_syscall();
>  #else

Please just use compat_need_64bit_alignment_fixup() instead.
