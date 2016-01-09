From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v6] fs: clear file privilege bits when mmap writing
Date: Sat, 9 Jan 2016 04:28:39 +0000
Message-ID: <20160109042839.GA864@ZenIV.linux.org.uk>
References: <20160108232727.GA23490@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20160108232727.GA23490@www.outflux.net>
Sender: owner-linux-mm@kvack.org
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jan Kara <jack@suse.cz>, yalin wang <yalin.wang2010@gmail.com>, Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kern, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 08, 2016 at 03:27:27PM -0800, Kees Cook wrote:

> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index e063effe0cc1..096c4b3afe6a 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
>  
> +#ifndef O_REMOVEPRIV
> +#define O_REMOVEPRIV	040000000
> +#endif

Hmm...  Is that value always available?  AFAICS, parisc has already grabbed
it (for __O_TMPFILE).  On sparc it's taken by __O_SYNC, on alpha - O_PATH...
There's a reason why those definitions are not unconditional; some targets
have ABI shared with a preexisting Unix variant on the architecture in
question.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
