Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:41014 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab1EJXCM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 19:02:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/7] Network namespace manipulation with file descriptors
References: <m1tyd7p7tq.fsf@fess.ebiederm.org>
Date: Tue, 10 May 2011 16:02:05 -0700
In-Reply-To: <m1tyd7p7tq.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Fri, 06 May 2011 19:23:29 -0700")
Message-ID: <m162pip3bm.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, jamal <hadi@cyberus.ca>, Daniel Lezcano <daniel.lezcano@free.fr>, Linux Containers <containers@lists.osdl.org>, Renato Westphal <renatowestphal@gmail.com>
Message-ID: <20110510230205.RYNjLvQ32nXTJ0iO8bSGrfUD6VvPO3bKBkZiYz7rzBU@z>

ebiederm@xmission.com (Eric W. Biederman) writes:


> These changes are also available at:
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/linux-2.6-nsfd.git

I have noted the acknowledgments, fixed the bugs and resolved the syscall
conflicts.

Eric

