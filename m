Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD41C433F5
	for <linux-arch@archiver.kernel.org>; Wed,  9 Feb 2022 13:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiBINwm (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiBINwl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 08:52:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AEBC0613C9;
        Wed,  9 Feb 2022 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4AwAOdiimuM8LCPGyBK9kL00PYvIbKDoBbeNE/uXYaE=; b=a0ibs99rAy7oyzveBal5JOgEpM
        DPyGwdueLJttzaONr9vFYdMHPynSGQH971va+G73Jo0umPvkgkdoYslMURpVMTVeTfKhA0e//lnhW
        E8Si+rXuNuiR0UgodlzfcilnDIEgg3aCEV7nyLElQPsOqJcWZw7rjUJhP1y3GKA3hBSDF52fQbYi5
        EeICfHPJUW6Twm87sU0p+k/yjC/QA0l8qUp+ZnYZq76Y/l2IBFZBQqOSAhZUMpn+GrqYOabz/vteu
        ZROSTTAg0HJO8Ox5EzgbrW7C8FhMGY5I4AunqiNmubDxQfXUuYH1nDaU706x6nBbKmQn+NVSyt6w0
        CS1bOo7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHnOh-000ErQ-EM; Wed, 09 Feb 2022 13:52:39 +0000
Date:   Wed, 9 Feb 2022 05:52:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, ebiederm@xmission.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgPHJy9NDVFr5s6w@infradead.org>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 09, 2022 at 02:50:32PM +0100, Michal Simek wrote:
> I can't see any issue with the patch when I run it on real HW.
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> 
> Christoph: Is there any recommended test suite which I should run?

No.  For architectures that already didn't use set_fs internally
there is nothing specific to test.  Running some perf or backtrace
tests might be useful to check if the non-faulting kernel helpers
work properly.
