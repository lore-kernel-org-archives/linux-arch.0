Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BBC433ED
	for <linux-arch@archiver.kernel.org>; Mon, 19 Apr 2021 04:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D927560241
	for <linux-arch@archiver.kernel.org>; Mon, 19 Apr 2021 04:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhDSEHU (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 19 Apr 2021 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbhDSEFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Apr 2021 00:05:32 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B5C061760;
        Sun, 18 Apr 2021 21:05:00 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVr5w9cz9vH8; Mon, 19 Apr 2021 14:04:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Stable <stable@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20200917135437.1238787-1-Tony.Ambardar@gmail.com>
References: <20200917000757.1232850-1-Tony.Ambardar@gmail.com> <20200917135437.1238787-1-Tony.Ambardar@gmail.com>
Subject: Re: [PATCH v3] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
Message-Id: <161880480720.1398509.14927712402293166726.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 17 Sep 2020 06:54:37 -0700, Tony Ambardar wrote:
> A few archs like powerpc have different errno.h values for macros
> EDEADLOCK and EDEADLK. In code including both libc and linux versions of
> errno.h, this can result in multiple definitions of EDEADLOCK in the
> include chain. Definitions to the same value (e.g. seen with mips) do
> not raise warnings, but on powerpc there are redefinitions changing the
> value, which raise warnings and errors (if using "-Werror").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: fix EDEADLOCK redefinition error in uapi/asm/errno.h
      https://git.kernel.org/powerpc/c/7de21e679e6a789f3729e8402bc440b623a28eae

cheers
