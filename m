Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42351 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755030Ab2DNDGh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Apr 2012 23:06:37 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so2824036lah.19
        for <linux-arch@vger.kernel.org>; Fri, 13 Apr 2012 20:06:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1204141143001.29389@tundra.namei.org>
References: <1334267284-19166-1-git-send-email-wad@chromium.org>
	<alpine.LRH.2.02.1204141143001.29389@tundra.namei.org>
Date: Fri, 13 Apr 2012 22:06:31 -0500
Message-ID: <CABqD9hahg_KJHTFnRCDpUFaa4TZjy_2EvVOqtd89NvTnr8UkSw@mail.gmail.com>
Subject: Re: [PATCH v18 01/15] Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve
 from granting privs
From: Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org, Andy Lutomirski <luto@amacapital.net>
Message-ID: <20120414030631.LtOgyDrn957VTPgqdmvVgb8Mlo0ZQfaP9HsrTtBk7w0@z>

On Fri, Apr 13, 2012 at 8:45 PM, James Morris <jmorris@namei.org> wrote:
> I applied the patchset to:
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
>
> Please test, and make any further updates against that branch.

Great! I will most certainly do that.

Thanks!
will
