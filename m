From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC] status of execve() work - per-architecture patches
 solicited
Date: Mon, 17 Sep 2012 23:57:21 +0100
Message-ID: <20120917225721.GW13973@ZenIV.linux.org.uk>
References: <20120907182004.GE13973@ZenIV.linux.org.uk>
 <5056ED66.30203@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51724 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab2IQW5W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2012 18:57:22 -0400
Content-Disposition: inline
In-Reply-To: <5056ED66.30203@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 17, 2012 at 11:29:10AM +0200, Michal Simek wrote:
> Hi Al,
> 
> On 09/07/2012 08:20 PM, Al Viro wrote:
> >	To architecture maintainers: please, review the current
> >situation in git.kernel.org/pub/scm/linux/kernel/git/viro/signal #execve2
> >and consider sending the corresponding patches for missing architectures.
> 
> I have sent two patches. Please apply them to your tree.
> 
> Michal Simek (2):
>       microblaze: Move restart allowed out of block

applied.

>       microblaze: Remove compilation failure

folded into the offending commit.  Note that all this stuff is not in for-next
or any of execve-related branches...
