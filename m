Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47068 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2AXAna (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2012 19:43:30 -0500
Received: by ggnb1 with SMTP id b1so1710582ggn.19
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2012 16:43:29 -0800 (PST)
Date: Mon, 23 Jan 2012 16:43:22 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] kconfig: untangle EXPERT and EMBEDDED
In-Reply-To: <20120123134632.GA8235@turtle.usersys.redhat.com>
Message-ID: <alpine.DEB.2.00.1201231641380.19019@chino.kir.corp.google.com>
References: <1326295008-29795-1-git-send-email-drjones@redhat.com> <b6315f9b-0ead-4de4-a8f5-ed619f852c6c@zmail13.collab.prod.int.phx2.redhat.com> <20120118122830.037f1e29.akpm@linux-foundation.org> <20120123134632.GA8235@turtle.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu, david.woodhouse@intel.com, linux-kernel@vger.kernel.org, gregkh@suse.de, davem@davemloft.net, axboe@kernel.dk, arnd@arndb.de, holt@sgi.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, hskinnemoen@gmail.com, egtvedt@samfundet.no, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper nilsson <jesper.nilsson@axis.com>, dhowells@redhat.com, takata@linux-m32r.org, geert@linux-m68k.org, yasutake koichi <yasutake.koichi@jp.panasonic.com>, jonas@southpole.se, kyle@mcmartin.ca, deller@gmx.de, jejb@parisc-linux.org, chris@zankel.net, greg@kroah.com, davej@redhat.com, airlied@linux.ie, jkosina@suse.cz, mchehab@infradead.org, johannes@sipsolutions.net, linville@tuxdriver.com
Message-ID: <20120124004322.A6oDMz7Y2RCvgD5w4rO_S8Sn8u3AHB0yj4_mqcAe2ag@z>

On Mon, 23 Jan 2012, Andrew Jones wrote:

> I thought EXPERT was the best way to manage the visibility of expert
> options, but probably not, since it's prone to silent default changing.

Why not propose patches to subsystem maintainers to erradicate "default 
EXPERT" or "default !EXPERT"?
