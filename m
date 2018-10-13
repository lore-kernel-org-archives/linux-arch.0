Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48114 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMPlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2018 11:41:39 -0400
Date: Sat, 13 Oct 2018 09:05:11 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v3 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181013080511.GT32577@ZenIV.linux.org.uk>
References: <20181009070230.12884-1-cyphar@cyphar.com>
 <20181009070230.12884-2-cyphar@cyphar.com>
 <20181013073319.GS32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013073319.GS32577@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, dev@opencontainers.org, containers@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20181013080511.hBLINUiFv77obzorE5OKJza0-mBY51Y5kI04FmjoYp4@z>

On Sat, Oct 13, 2018 at 08:33:19AM +0100, Al Viro wrote:

> Pardon me, but... huh?  The reason for your two calls of dirfd_path_init() is,
> AFAICS, the combination of absolute pathname with both LOOKUP_XDEV and
> LOOKUP_BENEATH at the same time.  That combination is treated as if the pathname
> had been relative.  Note that LOOKUP_BENEATH alone is ignored for absolute ones
> (and with a good reason - it's a no-op on path_init() level in that case).
> 
> What the hell?  It complicates your code and doesn't seem to provide any benefits
> whatsoever -- you could bloody well have passed the relative pathname to start with.
> 
> IDGI...  Without that kludge it becomes simply "do as we currently do for absolute
> pathnames, call dirfd_path_init() for relative ones".  And I would argue that
> taking LOOKUP_BENEATH handling out of dirfd_path_init() into path_init() (relative)
> case would be a good idea.
> 
> As it is, the logics is very hard to follow.

	... and it fails on LOOKUP_BENEATH anyway.  Egads...  So that's for your
LOOKUP_CHROOT ;-/  IMO that's awful, especially with the way you've spread those
LOOKUP_CHROOT cases between these two.

	Why not simply have O_THISROOT pick root by dirfd and call file_open_root()?
And if something wants it for stat(), etc. just have them use it combined with
O_PATH and pass the result to ...at()...
