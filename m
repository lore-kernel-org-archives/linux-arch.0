From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 10/28] x86/asm/entry: annotate interrupt symbols
 properly
Date: Mon, 19 Aug 2019 16:56:52 +0200
Message-ID: <20190819145652.GC4522@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-11-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-11-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:36PM +0200, Jiri Slaby wrote:
> * annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
>   and SYM_CODE_END -- these are not C-like functions, so we have to
>   annotate them using CODE.
> * use SYM_INNER_LABEL* for labels being in the middle of other functions
> 
> [v4] alignments preserved
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/entry_32.S | 28 ++++++++++++++--------------
>  arch/x86/entry/entry_64.S | 13 ++++++-------
>  2 files changed, 20 insertions(+), 21 deletions(-)

Here again some of the symbols are used only in a single complilation
unit and thus made local symbols by prepending their name with ".L" so
that they don't pollute the symbol table. Pls do that for all symbols
you're touching, while you're at it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
