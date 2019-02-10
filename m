From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Date: Sat, 9 Feb 2019 19:20:48 -0500
Message-ID: <20190209191723-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
 <20190208154239.GI674@zn.tnic>
 <20190208164206-mutt-send-email-mst@kernel.org>
 <20190208215232.GN674@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208215232.GN674@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 08, 2019 at 10:52:32PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 04:43:37PM -0500, Michael S. Tsirkin wrote:
> > Coding style violation: if a linux/foo.h exists then it must
> > be included in preference to asm/foo.h
> > 
> > And the specific issue is that a follow-up patch moves code from
> > asm/mman.h to linux/mman.h so if any one was indirectly using
> > this header it will now miss the symbols that are being moved.
> 
> Ok, so first of all, this should be your commit message - not what you
> have there now.
> 
> Then, please send full patchsets to recipients - I have only this patch
> in my mbox and have no clue what the whole patchset is addressing.

I can copy you on all patches, sure.

> Further, do you want an ACK only or should I pick this up?


If you can pick it up then great.

> Finally, this whole file is going away:
> 
> https://lkml.kernel.org/r/7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com
> 
> so your patch might become obsolete by then. Depends on what goes first.
> 
> Thx.


> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
