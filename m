From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 3/3] xtensa: switch to generic sys_execve()
Date: Wed, 24 Oct 2012 15:01:24 +0100
Message-ID: <20121024140124.GE2616@ZenIV.linux.org.uk>
References: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
 <1351043317-21631-4-git-send-email-jcmvbkbc@gmail.com>
 <20121024024123.GD2616@ZenIV.linux.org.uk>
 <CAMo8Bf+fkUTDPHh-sbVJj=8SOjMDfpywa=g1sMRFXWfpBhsDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37126 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934814Ab2JXOC1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Oct 2012 10:02:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+fkUTDPHh-sbVJj=8SOjMDfpywa=g1sMRFXWfpBhsDYA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>

On Wed, Oct 24, 2012 at 01:16:39PM +0400, Max Filippov wrote:
> On Wed, Oct 24, 2012 at 6:41 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Wed, Oct 24, 2012 at 05:48:37AM +0400, Max Filippov wrote:
> >> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> >> ---
> >>  arch/xtensa/include/asm/syscall.h     |    2 +-
> >>  arch/xtensa/include/asm/unistd.h      |    1 +
> >>  arch/xtensa/include/uapi/asm/unistd.h |    2 +-
> >>  arch/xtensa/kernel/process.c          |   25 -------------------------
> >>  4 files changed, 3 insertions(+), 27 deletions(-)
> >
> > All three applied, but there's a couple of things I'd like to have on top
> > of that.  Are you OK with the following incremental?
> 
> Yes. Looks like I need to send v2 to address Chris' comments,
> I can put these changes there as well.

Please, do.
