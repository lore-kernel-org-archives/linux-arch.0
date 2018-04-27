From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/7] kprobes: Make blacklist root user read only
Date: Fri, 27 Apr 2018 09:04:12 +0200
Message-ID: <20180427070412.utb5e53zbnajcfv2@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481120919.22588.16126591608892708741.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152481120919.22588.16126591608892708741.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the blacklist file indicates a sensitive address
> information to reader, it should be restricted to the
> root user.
> 
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ea619021d901..51096eece801 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
>  	if (!file)
>  		goto error;
>  
> -	file = debugfs_create_file("blacklist", 0444, dir, NULL,
> +	file = debugfs_create_file("blacklist", 0400, dir, NULL,
>  				&debugfs_kprobe_blacklist_ops);
>  	if (!file)
>  		goto error;

Note that in a typical Linux distro debugfs is already root-only:

  fomalhaut:~> ls -ld /sys/kernel/debug
  drwx------ 28 root root 0 Apr 23 08:55 /sys/kernel/debug

but this change might make sense if debugfs is mounted in some other fashion.

But the patch looks incomplete, 'blacklist' is not the only word-readable file in 
the kprobes hierarchy. The kprobes directory itself, and the 'list' file is 
readable as well:

  [root@fomalhaut ~]# ls -ld /sys/kernel/debug/kprobes
  drwxr-xr-x 2 root root 0 Apr 23 08:55 /sys/kernel/debug/kprobes

  [root@fomalhaut ~]# ls -l /sys/kernel/debug/kprobes/

  -r--r--r-- 1 root root 0 Apr 23 08:55 blacklist
  -rw------- 1 root root 0 Apr 23 08:55 enabled
  -r--r--r-- 1 root root 0 Apr 23 08:55 list

So not just the blacklist should be 400 but 'list' as well, and the main kprobes 
directory as well.

Thanks,

	Ingo
