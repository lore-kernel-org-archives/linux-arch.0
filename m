From: Borislav Petkov <bp@alien8.de>
Subject: Re: crash under qemu, bisected to f2a6a7050109 ("x86: Convert the
 rest of the code to support p4d_t")
Date: Fri, 31 Mar 2017 11:56:17 +0200
Message-ID: <20170331095617.5d5sxrk54uqzqfgf@pd.tnic>
References: <20170331070653.GA8716@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753338AbdCaJ4a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Mar 2017 05:56:30 -0400
Content-Disposition: inline
In-Reply-To: <20170331070653.GA8716@Red>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: kirill.shutemov@linux.intel.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, Mar 31, 2017 at 09:06:53AM +0200, Corentin Labbe wrote:
> hello
> 
> Since linux-next-20170329, my qemu virtual machine crash with:
> [    1.409213] Freeing unused kernel memory: 688K
> [    1.414790] Freeing unused kernel memory: 1920K
> [    1.415581] BUG: unable to handle kernel paging request at ffffc753f000f000
> [    1.416808] IP: ptdump_walk_pgd_level_core+0x2d1/0x430

https://lkml.kernel.org/r/20170328185522.5akqgfh4niqi3ptf@pd.tnic

Reportedly, latest tip/master should be fixed but I haven't tried it
yet.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
