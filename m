From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] compat: sync compat_stats with statfs.
Date: Thu, 20 Oct 2011 00:28:42 +0200
Message-ID: <1435724.hJQAMQ2ynm@wuerfel>
References: <m1r52b4ajh.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50841 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab1JUQxr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2011 12:53:47 -0400
In-Reply-To: <m1r52b4ajh.fsf@fess.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kyle McMartin <kyle@mcmartin.ca>

On Monday 17 October 2011 13:40:02 Eric W. Biederman wrote:
> This was found by inspection while tracking a similar
> bug in compat_statfs64, that has been fixed in mainline
> since decemeber.
> 
> - This fixes a bug where not all of the f_spare fields
>   were cleared on mips and s390.
> - Add the f_flags field to struct compat_statfs
> - Copy f_flags to userspace in case someone cares.
> - Use __clear_user to copy the f_spare field to userspace
>   to ensure that all of the elements of f_spare are cleared.
>   On some architectures f_spare is has 5 ints and on some
>   architectures f_spare only has 4 ints.  Which makes
>   the previous technique of clearing each int individually
>   broken.
> 
> I don't expect anyone actually uses the old statfs system
> call anymore but if they do let them benefit from having
> the compat and the native version working the same.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Apparently, this could have been worse on tile, which has
#define compat_statfs statfs, so that the old
"__put_user(0, &ubuf->f_spare[4]))" was writing beyond the
end of struct statfs. Fortunately, this never gets called
on tile, which only provides compat_sys_statfs64 to user space,
not compat_sys_statfs.

	Arnd
