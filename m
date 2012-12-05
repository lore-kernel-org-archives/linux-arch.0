From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 00/44] Meta Linux Kernel Port
Date: Wed, 5 Dec 2012 17:11:32 +0000
Message-ID: <20121205171131.GV4939@ZenIV.linux.org.uk>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36356 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2LERLd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Dec 2012 12:11:33 -0500
Content-Disposition: inline
In-Reply-To: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Wed, Dec 05, 2012 at 04:08:18PM +0000, James Hogan wrote:

> other work not included:
> * switch to generic kernel_{thread,execve} (will be posted separately to
>   aid review)

> other changes:
...
> * switch to generic sys_execve

... which should've broken your kernel_execve().
