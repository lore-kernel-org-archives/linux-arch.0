Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B60C433DB
	for <linux-arch@archiver.kernel.org>; Thu,  4 Feb 2021 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA43A64E35
	for <linux-arch@archiver.kernel.org>; Thu,  4 Feb 2021 20:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhBDUa4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhBDUag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:30:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60FC0617A9
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:29:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx20so2497625pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MzlCpCkLmxVsznheZI3EKTdR1f5kwqDGSaj2tE3igtU=;
        b=Gvshsbpw/2T8JIx2xC/Yj1b2gosWPoRbQqc9xnkQx6kZGmYOkUDhIB27gDkHZnhhkP
         YdNd6b0Qa3SsOJVZqFNbXe8+62GV0NeDEla1b6JqwqrIG28L1AlU7jaybevMTho6JcaU
         mRQIoa+gy6PKrbFD08moLs/Jau2larhRyAN+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MzlCpCkLmxVsznheZI3EKTdR1f5kwqDGSaj2tE3igtU=;
        b=g3cgw1BRZHN4qlXX+QQN/2LlZ14qMmB+vBRXTjEPYULh6Xd6H+PiK/248D/S9NraXX
         qp5oNgh29too0Gi4Y8S8JbnRabhGmY7u+HNNvrIlEWYN6UjXPt+p2CrylR6aPV63WF97
         ULzYXqksv7GfCKe43TSWqHLMzp6KgF81cIeJQZgMLUyMjkIo3Pq65YpD4FQypLIeB+7C
         8v1U9WZaHq6MsFfVY8WyMIl64QibjR0zUUoi77wtV8x6BIm+PzROBQiCrcpkGiK0f+nY
         jj156OxdX0noV0gb6F7UtZjqIKfBGYLXiib95LGRviXDXUTf8EGNbjtS5mELNtquZzfP
         atMA==
X-Gm-Message-State: AOAM530pf67Cd7iPdyBcto9QJEMZAF9ZRkt23ZziAGwGIxuvm9iBVruf
        C4HAqpxzxAPYJZgYDFIAhEb5fQ==
X-Google-Smtp-Source: ABdhPJwZQMO8NMtHz9UcwGY1H2/3ntfrSkqcPsM14xB1bASd6IqHz3hxpya84TyWYDZMuPiE8WFqIA==
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr788298pjb.20.1612470598230;
        Thu, 04 Feb 2021 12:29:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm6846456pfr.78.2021.02.04.12.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:29:57 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:29:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 20/25] x86/cet/shstk: User-mode shadow stack support
Message-ID: <202102041229.237544D@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-21-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-21-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:42PM -0800, Yu-cheng Yu wrote:
> Introduce basic shadow stack enabling/disabling/allocation routines.
> A task's shadow stack is allocated from memory with VM_SHSTK flag and has
> a fixed size of min(RLIMIT_STACK, 4GB).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
