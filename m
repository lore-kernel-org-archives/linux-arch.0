From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/13] UAPI header file split
Date: Mon, 23 Jul 2012 15:50:43 +0000
Message-ID: <201207231550.43775.arnd@arndb.de>
References: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab2GWPuy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jul 2012 11:50:54 -0400
In-Reply-To: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com

On Friday 20 July 2012, David Howells wrote:
>      (a) It reduces the size of the kernel-only headers and obviates the need
>          for __KERNEL__ conditionals in the remnant kernel-only headers.
> 
>      (b) In what we have today, there are complex interdependencies between
>          headers that are partly exported to user space, and we want to reduce
>          those interdependencies.
> 
>          It simplifies the problem space by splitting out the user headers as
>          they then only depend only on other user headers.
> 
>      This step makes it easier to follow through with the remaining steps as
>      the remnant kernel headers can be split up without regard as to whether
>      the UAPI will be broken.  Header files such as linux/sched.h can even
>      disappear entirely if that seems convenient.
> 
>      There is another potential benefit as well: it becomes easier to track
>      when the UAPI changes just from the filenames in the GIT log.
> 
>      Further, linux-api@vger.kernel.org can be put into the MAINTAINERS file
>      for the uapi/ directories so that patches changing them get sent to that
>      list by everyone using get_maintainer.pl.

Looks all good to me. For the entire series:

Acked-by: Arnd Bergmann <arnd@arndb.de>
