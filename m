From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/35] UAPI header file split
Date: Tue, 5 Jul 2011 13:46:21 -0700
Message-ID: <20110705134621.927b76e4.rdunlap@xenotime.net>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:34084 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751529Ab1GEUqX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2011 16:46:23 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org

On Sat, 02 Jul 2011 12:07:26 +0100 David Howells wrote:

> 
> Here's my first installment of patches to clean up the kernel header files and
> sort out the recursion problems.  The planned steps are:
> ==
> 
> The patches actually posted here are the manual preparation for the UAPI split
> in step (1) above.  I haven't posted the patches that do the actual splitting
> by email as the largest of them is in excess of 120,000 lines.  However, the
> patches are available through GIT:
> 
> 	http://git.infradead.org/users/dhowells/linux-headers.git


Hi,

I didn't see patch 02/35 nor patch 30/35.
Were they too large to be posted?

thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
