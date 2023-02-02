Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6AC61DA4
	for <linux-arch@archiver.kernel.org>; Thu,  2 Feb 2023 09:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBBJsK (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBBJsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 04:48:09 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 01:47:32 PST
Received: from smtp-1.orcon.net.nz (smtp-1.orcon.net.nz [60.234.4.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E5712D3;
        Thu,  2 Feb 2023 01:47:32 -0800 (PST)
Received: from [121.99.247.178] (port=6284 helo=creeky)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1pNVMe-0004r5-9i; Thu, 02 Feb 2023 21:54:40 +1300
Date:   Thu, 2 Feb 2023 21:54:35 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9t6Swqt+A9noVIf@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9te+4n4ajSF++Ex@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9te+4n4ajSF++Ex@ZenIV>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 06:58:03AM +0000, Al Viro wrote:
> Other bugs in the same area:
> 	* we ought to compare address with VMALLOC_START,
> not TASK_SIZE.
> 	* we ought to do that *before* checking for
> kernel threads/pagefault_disable() being in effect.
> 
> Wait a minute - pgd_present() on alpha has become constant 1
> since a73c948952cc "alpha: use pgtable-nopud instead of 4level-fixup"
> 
> So that thing had been completely broken for 3 years and nobody
> had noticed.  

I have never noticed because I haven't been able to run a 5.9 or
newer kernel on Alpha reliably so have been running a 5.8 kernel
for quite some time.  Bad commit is about
25788738eb9ce46fe6a0fd84a3ceef5c795d41f0 but bisection proved very
difficult because the bug might only show up once per day (memory
corruption in user space causing gcc in big long builds to ICE
reporting corrupted structures, or similar) and so could never be
entirely sure a kernel marked as good was truly good in bisection
and went wrong a number of times.  There is a good possibility the bad
commit is one of facdaa917c4d5a376d or 25788738eb9ce46fe6.

Cheers,
Michael.
