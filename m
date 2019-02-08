Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:48894 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBHVwp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Feb 2019 16:52:45 -0500
Date: Fri, 8 Feb 2019 22:52:32 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190208215232.GN674@zn.tnic>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
 <20190208164206-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208164206-mutt-send-email-mst@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190208215232.EqV5EiA5fnF7bsyq9Q4Jh9w5Qx8CGakUSrYSuE5IX5o@z>

On Fri, Feb 08, 2019 at 04:43:37PM -0500, Michael S. Tsirkin wrote:
> Coding style violation: if a linux/foo.h exists then it must
> be included in preference to asm/foo.h
> 
> And the specific issue is that a follow-up patch moves code from
> asm/mman.h to linux/mman.h so if any one was indirectly using
> this header it will now miss the symbols that are being moved.

Ok, so first of all, this should be your commit message - not what you
have there now.

Then, please send full patchsets to recipients - I have only this patch
in my mbox and have no clue what the whole patchset is addressing.

Further, do you want an ACK only or should I pick this up?

Finally, this whole file is going away:

https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com

so your patch might become obsolete by then. Depends on what goes first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
