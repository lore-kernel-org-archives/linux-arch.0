Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33084 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab1EGGSg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 02:18:36 -0400
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 May 2011 07:25:45 +0200
Message-ID: <1304745945.2821.601.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Changli Gao <xiaosuo@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110507052545.mQFqLeYhu2UOLhz8XmBsYNbWqazU4H6snMJTLfuzfME@z>

Le samedi 07 mai 2011 à 12:49 +0800, Changli Gao a écrit :
> If FD_CLOFORK is 1, when a fork occurs, the corresponding file descriptor
> will be closed for the child process. IOW, the file descriptor isn't
> inheritable.
> 
> FD_CLOFORK is used as IBM does.

Is it part of a standard, and what could be the use for such thing ?
Why had we wait 2011 to add it in linux ?

> 
> O_CLOFORK is also added to avoid the additional fcntl(2) after open(2).
> 
> Signed-off-by: Changli Gao <xiaosuo@gmail.com>


Your implementation has some peformance implication.

close_on_exec and close_on_fork bit for a given fd would be on separate
cache lines. So you add a cost on threaded programs for open()/close()

[ Yes, we apparently clear close_on_exec bit in close()... we could let
it untouched and make flush_old_files() aware of that ]



