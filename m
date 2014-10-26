From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] all arches, signal: Move restart_block to struct
 task_struct
Date: Sun, 26 Oct 2014 17:18:19 +0000
Message-ID: <20141026171819.GQ7996@ZenIV.linux.org.uk>
References: <90d5683679179df27ffeef18c3e1010ed4e72695.1414342681.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42687 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaJZRSZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 Oct 2014 13:18:25 -0400
Content-Disposition: inline
In-Reply-To: <90d5683679179df27ffeef18c3e1010ed4e72695.1414342681.git.luto@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com

On Sun, Oct 26, 2014 at 10:02:16AM -0700, Andy Lutomirski wrote:
> If an attacker can cause a controlled kernel stack overflow,
> overwriting the restart block is a very juicy exploit target.
> Moving the restart block to struct task_struct prevents this type of
> exploit.

The hell it does.  In a _lot_ of cases current is current_thread_info()->task,
which makes your variant just as vulnerable, in addition to being (slightly)
more costly.
