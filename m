Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB6FC43331
	for <linux-arch@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4205164F9A
	for <linux-arch@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCLCqE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhCLCpx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 21:45:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156DC061762
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:52 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id w34so13847220pga.8
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fac5qEwtGUhYp0i9UgwCZogHJ9c5ndld0feZGyCBugw=;
        b=Yf1jNw5HL2aTwVR53Xw1DAzotE73G/J5yX4CJQJM+XgSnLG8J+vcgPlTdkWIsbuxH6
         QLetB8TZJzSr1rGbx8bLv9sUGwRivp/1eoW5SZQo+X5smcoP6bJxSpB38YAMtOOcS0+B
         DCLkvZloqcKPnWQPN8dAzDhjkMWed0N6lx+N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fac5qEwtGUhYp0i9UgwCZogHJ9c5ndld0feZGyCBugw=;
        b=G0zy0Gt2UQZ0KGmGRb6PVHao+E0e53A3xN7UJbcOmksdJbPGl9W5sTvDD2P9cogx2C
         LORDoaqeSUpIronTjt52hv258gVnAVCG5Bma0W73J1ZGus3AXZop4TKwVimQu5IJHBPK
         BpZQRTUO/GbHc8TuJ8FLWxf0uscam8vFE63Zs1bgXcCsZ311nKJss0ZiPVcRcMCIf3vP
         9JjKH1f0JudBAB6jUl3El8VTP88pPdO5dPOXlZXLMXa+jTCrJkQePpYVa5Q5BHZFM77q
         bGR15O8qkmTK9Ou/+N8a3AbvEEGqtXHApE1tPw+8jraA8hKEMRQsUF5HFFFAwyBKYC0t
         pcHg==
X-Gm-Message-State: AOAM5313NKCtncv6wp8WMSAe5A5jYVt80mZnIf+IP1WxzXORVypAIvSX
        VAf+8H1wC1V56wANTTCkX2RbsQ==
X-Google-Smtp-Source: ABdhPJwkatQTgQrGNraBkT/X2lsgOwTQFo5tDOWcr2Yd9maNZVjYw6Sy3JQXdf01TBLr7xwbPU4otA==
X-Received: by 2002:a62:35c2:0:b029:1f1:3a8b:83d5 with SMTP id c185-20020a6235c20000b02901f13a8b83d5mr10327491pfa.29.1615517152536;
        Thu, 11 Mar 2021 18:45:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n184sm3522810pfd.205.2021.03.11.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] psci: use __pa_function for cpu_resume
Message-ID: <202103111845.6E00D2E@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:13PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function pointers with
> jump table addresses, which results in __pa_symbol returning the
> physical address of the jump table entry. As the jump table contains
> an immediate jump to an EL1 virtual address, this typically won't
> work as intended. Use __pa_function instead to get the address to
> cpu_resume.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
