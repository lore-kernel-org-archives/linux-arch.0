Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46893 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756050Ab1EGUGU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 16:06:20 -0400
Subject: Re: [PATCH 7/7] ns: Wire up the setns system call
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1304735101-1824-7-git-send-email-ebiederm@xmission.com>
References: <m1tyd7p7tq.fsf@fess.ebiederm.org>
	 <1304735101-1824-1-git-send-email-ebiederm@xmission.com>
	 <1304735101-1824-7-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 May 2011 15:06:15 -0500
Message-ID: <1304798775.6123.18.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, jamal <hadi@cyberus.ca>, Daniel Lezcano <daniel.lezcano@free.fr>, Linux Containers <containers@lists.osdl.org>, Renato Westphal <renatowestphal@gmail.com>
Message-ID: <20110507200615.gSFz-NXC6DlPXOz5DhL8CJWVccHPTDOHipQvWKYGMKw@z>

On Fri, 2011-05-06 at 19:25 -0700, Eric W. Biederman wrote:
> v2: Most of the architecture support added by Daniel Lezcano <dlezcano@fr.ibm.com>
> v3: ported to v2.6.36-rc4 by: Eric W. Biederman <ebiederm@xmission.com>
> v4: Moved wiring up of the system call to another patch
> v5: ported to v2.6.39-rc6
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

We already have several syscalls queued up for parisc:

http://git.kernel.org/?p=linux/kernel/git/jejb/parisc-2.6.git;a=shortlog;h=refs/heads/misc

So if you could make this patch over them (or over linux-next), that
would help the merge process.

Thanks,

James


