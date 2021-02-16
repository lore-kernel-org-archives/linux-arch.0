Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F54BC433DB
	for <linux-arch@archiver.kernel.org>; Tue, 16 Feb 2021 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5064E0F
	for <linux-arch@archiver.kernel.org>; Tue, 16 Feb 2021 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBPR5b (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhBPR50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2021 12:57:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AB3C0613D6
        for <linux-arch@vger.kernel.org>; Tue, 16 Feb 2021 09:56:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j19so17244424lfr.12
        for <linux-arch@vger.kernel.org>; Tue, 16 Feb 2021 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sB0GNU2NK22ymf4WR/Z3NGO8dPeB6xu5QjQGtDipdYg=;
        b=HeWFqx35KDD6di4h49i+CZJ1MoRmUxZQvvS9mHzFdoVMb4N5qKkqW4szZJnu6x//3k
         5OvKdKRP69NRL0qvu+Zdyg0uLmSgk8XXA813RidddooTJHRR8A/U95cEIWzN8qkue0pk
         MECQDpLW9QqkXSCqB/k4mEiJaY16bg3dn3WK6/OvSOXKP3NG1yc0cJhYggTHIrrNUqwo
         8X24ShJQU0J6sKwzNjXRoVMYUDewyN/u/ri8YspcMsQ6vyF2zg7Lja5DFXLNEvo+5U7y
         S2Uoa4LdGOBjg8+LW2CO9S306tt3eF9KaLlhnVbypERWZC1mk+jUNa8bQwK5rohESe9i
         pI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sB0GNU2NK22ymf4WR/Z3NGO8dPeB6xu5QjQGtDipdYg=;
        b=UuDKqp55jQWaTFIx3pp0M0PeUG1aZihec2qNOnTnpGmPcjPFtFGjy/J2nFR4Ico0oc
         hhkVIbN18IrdJb2RjmHXpbpmsG4pp0XHY5SaXpLRPMLlJQkdYl0YZK22J11p7/OGQq2W
         VKRAtWW8INFUDDFkpKxQ74u9ng+zMkiV2yxihkw/Fhe76EKaueyiz+BxAycMetG8AvCP
         +cToSMowt+wC+TwhxcORyIs6wKw8jaIutOK8juXz6riIPUOvFLdhXaQocNJsSuo/ljQX
         p4bGnhm8I9Dis7Mg4jqKSWCSFEwNIDWcGF5PYNFQxqlVwzPFdRa+G/DLVPxdPPAFi837
         g3SA==
X-Gm-Message-State: AOAM533ureLz1fVulqEhKLH/tWgz3tvq+sRR4OeJ6dabYy28/rnMvOgC
        mIS+6JPW8acPilCGeMzS7HE6fYsQO84+cvjPI0xX5w==
X-Google-Smtp-Source: ABdhPJwn31TSYs/0OA4XZrRaZd+s0VSHEF9NBGej8B0mRnrxI+16aTu69fq+6Z6wgQZzmaDZvMFPwrzKhtlcBtn2kRs=
X-Received: by 2002:a05:6512:2e3:: with SMTP id m3mr12641403lfq.547.1613498203806;
 Tue, 16 Feb 2021 09:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20210216085442.2967-1-alobakin@pm.me>
In-Reply-To: <20210216085442.2967-1-alobakin@pm.me>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Feb 2021 09:56:32 -0800
Message-ID: <CAKwvOdnBgpRff6wa8u1_ogCm_pRey5d_Yro4UCa_O_=tib0FHQ@mail.gmail.com>
Subject: Re: [PATCH mips-next] vmlinux.lds.h: catch more UBSAN symbols into .data
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 16, 2021 at 12:55 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> LKP triggered lots of LD orphan warnings [0]:

Thanks for the patch, just some questions.

With which linker?  Was there a particular config from the bot's
report that triggered this?

>
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data299' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data299'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data183' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data183'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type3' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type3'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type2' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type2'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type0' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type0'
>
> [...]
>
> Seems like "unnamed data" isn't the only type of symbols that UBSAN
> instrumentation can emit.
> Catch these into .data with the wildcard as well.
>
> [0] https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.com
>
> Fixes: f41b233de0ae ("vmlinux.lds.h: catch UBSAN's "unnamed data" into data")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index cc659e77fcb0..83537e5ee78f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -95,7 +95,7 @@
>   */
>  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$Lubsan_*

Are these sections only created when
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected?  (Same with
.data.$__unnamed_*)

>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
>  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
>  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> --
> 2.30.1
>
>


-- 
Thanks,
~Nick Desaulniers
