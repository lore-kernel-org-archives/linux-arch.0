From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5] fs: clear file privilege bits when mmap writing
Date: Thu, 7 Jan 2016 16:30:33 -0800
Message-ID: <CALCETrUMOPC_--4G59DTxS70FxE-hSBPrdvzjS+2xV8ywvx_Cg@mail.gmail.com>
References: <20151210223314.GA14512@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36067 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcAHAay (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2016 19:30:54 -0500
Received: by mail-ob0-f178.google.com with SMTP id ba1so341685190obb.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Jan 2016 16:30:53 -0800 (PST)
In-Reply-To: <20151210223314.GA14512@www.outflux.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, yalin wang <yalin.wang2010@gmail.com>, Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@linux-foundation.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>

On Thu, Dec 10, 2015 at 2:33 PM, Kees Cook <keescook@chromium.org> wrote:
> Instead, detect the need to clear the bits during the page fault, and
> actually remove the bits during final fput. Since the file was open for
> writing, it wouldn't have been possible to execute it yet.

This is cute but mysterious.  Could you add a comment?

>
> +       /*
> +        * XXX: While avoiding mmap_sem, we've already been written to.
> +        * We must ignore the return value, since we can't reject the
> +        * write.
> +        */

e.g. here?
