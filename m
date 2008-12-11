From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 13:56:25 +0100
Message-ID: <20081211125625.GA23800@uranus.ravnborg.org>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:32955 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbYLKMy7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 07:54:59 -0500
Content-Disposition: inline
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>, David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

Hi Kyle.

> 
> Unconverted architectures so far are m68k (because it doesn't use an explicit
> init_task.c), ia64 (because it faffs about with init_thread_union), and
> sparc{,64} (which appear to rely on some magic.)

sparc has harcoded the alignment requirments in init_task.c.
I will try to make it look like all others by moving
this to vmlinux.lds.

Speaking of that there seems to be another bit that could be
shared between the arch vmlinux.lds as all arch has init_task included.

	Sam
