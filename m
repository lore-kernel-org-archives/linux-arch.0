Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCEC48BE5
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44536023D
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 20:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhFPU2B (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhFPU2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 16:28:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA9C061574;
        Wed, 16 Jun 2021 13:25:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltc6R-0094hM-5b; Wed, 16 Jun 2021 20:25:35 +0000
Date:   Wed, 16 Jun 2021 20:25:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] alpha/ptrace: Add missing switch_stack frames
Message-ID: <YMpeP0CrRUVKIysE@zeniv-ca.linux.org.uk>
References: <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133>
 <87pmwlek8d.fsf_-_@disp2133>
 <87eed1ek31.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eed1ek31.fsf_-_@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 01:32:50PM -0500, Eric W. Biederman wrote:

> -.macro	fork_like name
> +.macro	allregs name
>  	.align	4
>  	.globl	alpha_\name
>  	.ent	alpha_\name
> +	.cfi_startproc
>  alpha_\name:
>  	.prologue 0
> -	bsr	$1, do_switch_stack
> +	SAVE_SWITCH_STACK
>  	jsr	$26, sys_\name
> -	ldq	$26, 56($sp)
> -	lda	$sp, SWITCH_STACK_SIZE($sp)
> +	RESTORE_SWITCH_STACK

	No.  You've just added one hell of an overhead to fork(2),
for no reason whatsoever.  sys_fork() et.al. does *NOT* modify the
callee-saved registers; it's plain C.  So this change is complete
BS.

> +allregs exit
> +allregs exit_group

	Details, please - what exactly makes exit(2) different from
e.g. open(2)?
