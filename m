Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D9C433DB
	for <linux-arch@archiver.kernel.org>; Wed, 23 Dec 2020 06:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E68F207BC
	for <linux-arch@archiver.kernel.org>; Wed, 23 Dec 2020 06:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLWG42 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 23 Dec 2020 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLWG42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 01:56:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B13C0613D3
        for <linux-arch@vger.kernel.org>; Tue, 22 Dec 2020 22:55:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o19so37808841lfo.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Dec 2020 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZrzhSr/pdKYEZLCm/lYn281E5FTFj+lBXgzuYqewis=;
        b=nUiKhlODqvOOJyPNarx/Nboy2R+vlNQKWf2xevquzD2q9ylevyGtjrnYv73ZgaKGCl
         AhgxNvlObBaRR6giZMiP9DG25vWreYD/plnVWYqnGexQPZCI/Ny/i8DcpmFWmujU4+x4
         dQ0dOkYZhLM9RFfp+uMm5Xv5nG23kXo+gRCH+Tr+Fr90EKuF12OAdXtu+lsCMhyAj0Dm
         mF7Ph7YEzlls+FiS2B/dAqbwVMR+uuTt2fJ4GJH3035s3I2mWJ3oNkLsZHgD9FqEP9Dm
         UZYWri/e6+oeKz0nLPKlMleF3U/zdQkZHqaXHjHk+CmLG785I/7iSP24lFFpI9WRPmSD
         vdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZrzhSr/pdKYEZLCm/lYn281E5FTFj+lBXgzuYqewis=;
        b=i94EGB1fzn7wD97wx6vjuU2Fr4PRsf1Mf10J0JJGmbJmdqttZ8148O/+5qXuoH6JOL
         J3RNkSxNHJBOSxJMsMpepkTLcbe0Jbfo6oiiu2IhcYgelJbHnGQbkbssSQQDfSJ1VhyZ
         FX9Qp2jFyaSdL/+nMipb41I9SMUVq1ms4CDMR2lXkWEP6Y6/GN3V7i60EaBM2UeyqxoW
         SFG8GKzBFNHC2U33UzLNTBy4FlRH7pmYmr9mG0esaMAaiJRpU6/ElJ9cgP6F3VKaBKpH
         Neh8ryKi/H9380eAFGbLeFxQ2uTfu/jQ/P/tH0dJt/5Sr0X0cyWMpkSWecoVgk1d3VKo
         dUuw==
X-Gm-Message-State: AOAM532YAtSqHOjGcOmG7p0aaZWOqH6+xLYvsrwNxwiw5pdFD58H5R8r
        Qw2k0UobmzrybYf/fmAzqBZ6qKqhN5w05xEU1r5zNw==
X-Google-Smtp-Source: ABdhPJzUibak7saO69q2IER/bv8m/ek3L5xMqti48cwKFVaG0wWfgD/FVu6xgRAegVLz7MKomb65av51F9mk94AENWY=
X-Received: by 2002:a19:c8cc:: with SMTP id y195mr10145396lff.352.1608706546238;
 Tue, 22 Dec 2020 22:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20201223015312.4882-1-chang.seok.bae@intel.com> <20201223015312.4882-4-chang.seok.bae@intel.com>
In-Reply-To: <20201223015312.4882-4-chang.seok.bae@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 23 Dec 2020 07:55:20 +0100
Message-ID: <CAG48ez1yZBYPXvqxW8k7uH+jAFkkLK1KNijgPPw+Kp-8gnp-sQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha@sourceware.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 23, 2020 at 2:57 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> The kernel pushes data on the userspace stack when entering a signal. If
> using a sigaltstack(), the kernel precisely knows the user stack size.
>
> When the kernel knows that the user stack is too small, avoid the overflow
> and do an immediate SIGSEGV instead.
>
> This overflow is known to occur on systems with large XSAVE state. The
> effort to increase the size typically used for altstacks reduces the
> frequency of these overflows, but this approach is still useful for legacy
> binaries.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Jann Horn <jannh@google.com>
