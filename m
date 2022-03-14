Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69EC433F5
	for <linux-arch@archiver.kernel.org>; Mon, 14 Mar 2022 08:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiCNI7H (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiCNI7G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2022 04:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0155B6
        for <linux-arch@vger.kernel.org>; Mon, 14 Mar 2022 01:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D661B61253
        for <linux-arch@vger.kernel.org>; Mon, 14 Mar 2022 08:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F155C340EC;
        Mon, 14 Mar 2022 08:57:53 +0000 (UTC)
Date:   Mon, 14 Mar 2022 08:57:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v11 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <Yi8DjeTU1xzX9iSv@arm.com>
References: <20220308132240.1697784-1-broonie@kernel.org>
 <20220308132240.1697784-3-broonie@kernel.org>
 <59fc8a58-5013-606b-f544-8277cda18e50@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59fc8a58-5013-606b-f544-8277cda18e50@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 08, 2022 at 12:01:17PM -0600, Jeremy Linton wrote:
> On 3/8/22 07:22, Mark Brown wrote:
> > Currently for dynamically linked ELF executables we only enable BTI for
> > the interpreter, expecting the interpreter to do this for the main
> > executable. This is a bit inconsistent since we do map main executable and
> > is causing issues with systemd's MemoryDenyWriteExecute feature which is
> > implemented using a seccomp filter which prevents setting PROT_EXEC on
> > already mapped memory and lacks the context to be able to detect that
> > memory is already mapped with PROT_EXEC.
> > 
> > Resolve this by adding a sysctl abi.bti_main which causes the kernel to
> > checking the BTI property for the main executable and enable BTI if it
> > is present when doing the initial mapping. This sysctl is disabled by
> > default.
> 
> This seems less than ideal, maybe the default can be flipped with a CONFIG
> option?

I'm not keen on config options changing the ABI. If there's a good
chance that this feature won't be turned on (via sysfs) in distros with
MDWE, I'd rather drop the whole series than maintain unused code in the
kernel.

(we can go back fixing this properly at the mprotect() level, as long as
systemd folk are willing to move away from eBPF for MDWE; happy to
provide kernel patches to start the discussion)

-- 
Catalin
