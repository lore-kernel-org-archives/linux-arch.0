From: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
Subject: Re: [RFC PATCH v14 06/10] landlock: Add syscall implementation
Date: Tue, 17 Mar 2020 16:47:09 +0000
Message-ID: <20200317164709.GA23230@ZenIV.linux.org.uk>
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-7-mic@digikod.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200224160215.4136-7-mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jann-XZ1E9jl8jIdeoWH0uzbU5w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TasMV2rI37PzA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 24, 2020 at 05:02:11PM +0100, Mickaël Salaün wrote:

> +static int get_path_from_fd(u64 fd, struct path *path)

> +	/*
> +	 * Only allows O_PATH FD: enable to restrict ambiant (FS) accesses
> +	 * without requiring to open and risk leaking or misuing a FD.  Accept
> +	 * removed, but still open directory (S_DEAD).
> +	 */
> +	if (!(f.file->f_mode & FMODE_PATH) || !f.file->f_path.mnt ||
					      ^^^^^^^^^^^^^^^^^^^
Could you explain what that one had been be about?  The underlined
subexpression is always false; was that supposed to check some
condition and if so, which one?
