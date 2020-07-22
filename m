From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 15/18] xtensa: propagate the calling conventions change
 down into csum_partial_copy_generic()
Date: Wed, 22 Jul 2020 01:56:33 -0700
Message-ID: <CAMo8BfJ7atdFKqkc7nTy5NGXpfAHLGSh95pmVsrZCOGFufw=Kg@mail.gmail.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-15-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVI4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 04:56:45 -0400
In-Reply-To: <20200721202549.4150745-15-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Jul 21, 2020 at 1:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> turn the exception handlers into returning 0.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/xtensa/include/asm/checksum.h | 20 +++---------
>  arch/xtensa/lib/checksum.S         | 67 +++++++++-----------------------------
>  2 files changed, 19 insertions(+), 68 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
