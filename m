Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EDBC7EE23
	for <linux-arch@archiver.kernel.org>; Tue, 30 May 2023 12:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjE3MoP (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 30 May 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjE3MoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 08:44:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DF60116;
        Tue, 30 May 2023 05:43:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6470EC14;
        Tue, 30 May 2023 05:43:45 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310F33F67D;
        Tue, 30 May 2023 05:42:58 -0700 (PDT)
Date:   Tue, 30 May 2023 13:42:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
Message-ID: <ZHXvT86FN/7lx/fv@FVFF77S0Q05N>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
 <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
 <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
 <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Akira,

On Fri, May 26, 2023 at 07:27:56PM +0900, Akira Yokosawa wrote:
> I think adding "~" to the substitution pattern added in [1] as follows
> should do the trick (not well tested):
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 2486689ffc7b..eb70c1fd4e86 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -64,7 +64,7 @@ my $type_constant = '\b``([^\`]+)``\b';
>  my $type_constant2 = '\%([-_\w]+)';
>  my $type_func = '(\w+)\(\)';
>  my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> -my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
> +my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>  my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
>  my $type_env = '(\$\w+)';

Are you happy to send this as a patch?

I'd like to pick it into this series, so if you're happy to provide your
Signed-off-by tag here, I'm happy to go write the commit message and so on.

Thanks,
Mark.

> 
> Thoughts?
> 
>         Thanks, Akira
> 
> > 
> > 
> >> [1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")
> > 
> > thanks.
