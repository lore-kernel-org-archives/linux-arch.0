Return-Path: <SRS0=zClU=5C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58538 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQrc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2020 12:47:32 -0400
Date: Tue, 17 Mar 2020 16:47:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v14 06/10] landlock: Add syscall implementation
Message-ID: <20200317164709.GA23230@ZenIV.linux.org.uk>
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224160215.4136-7-mic@digikod.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, x86@kernel.org
Message-ID: <20200317164709.YTtf8tNJIx5W0M7wvbRgjxM8y7pJZUhy4i3ku3-fsqk@z>

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
