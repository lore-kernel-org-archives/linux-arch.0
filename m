Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5AC48BE6
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D138C613BD
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 21:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhFPVEi (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhFPVEh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 17:04:37 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F87C061574;
        Wed, 16 Jun 2021 14:02:31 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltcfx-0095Fd-Qh; Wed, 16 Jun 2021 21:02:17 +0000
Date:   Wed, 16 Jun 2021 21:02:17 +0000
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
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
Message-ID: <YMpm2c2mHc/Lldhy@zeniv-ca.linux.org.uk>
References: <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133>
 <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133>
 <CAHk-=wiTEZN_3ipf51sh-csdusW4uGzAXq9m1JcMHu_c8OJ+pQ@mail.gmail.com>
 <CAHk-=whvNaYffE8Eaa4-jjYbF_r1u1sh5LF5zXFhdEP8hxySMQ@mail.gmail.com>
 <878s398r4g.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s398r4g.fsf@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 03:57:19PM -0500, Eric W. Biederman wrote:
 
> Do you know if struct switch_stack or pt_regs is ever exposeed to
> usespace?  They are both defined in arch/alpha/include/uapi/asm/ptrace.h
> which makes me think userspace must see those definitions somewhere.

	They are exposed, but why mess with those in the first
place?  thread_info->status is strictly thread-synchronous, so just
use it and be done with that...
