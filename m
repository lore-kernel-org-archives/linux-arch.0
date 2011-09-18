Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51872 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab1IRJDu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2011 05:03:50 -0400
Received: by wwf22 with SMTP id 22so6724644wwf.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Sep 2011 02:03:49 -0700 (PDT)
Subject: Re: [PATCH 1/3] sys_poll: Fix negative timeout values for x86
 userland on x86_64 kernels v2
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1316333042.5814.23.camel@localhost.localdomain>
References: <1316333042.5814.23.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Sep 2011 10:58:26 +0200
Message-ID: <1316336306.31335.8.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20110918085826.yYkzlAw2spmHnzCOMbgWbxFxcbgGjRepFrNXWmE5zBU@z>

Le dimanche 18 septembre 2011 à 10:04 +0200, Thomas Meyer a écrit :
> size of int and long differs on x86 and x86_64. the ia32 emulation calls
> directly into the sys_poll function. when the timeout is set to -1
> the test for sign will fail in sys_poll as the 64bit register is tested.
> the timeout timer will be set to 0xffffffff milliseconds, but the timer
> shouldn't get set at all in this situation.
> 

As I said, you should CC stable@kernel.org team on this patch.
All previous linux versions had this bug : A program might misbehave
because of a spurious poll(..., timeout < 0) wakeup.

Could you please refine this Changelog again ?

On 32bit user program, all negative timeout values should not set a
timout at all, not only 0xffffffff (-1)

man poll states :

The timeout argument specifies an upper limit on the time for which
poll() will block, in milliseconds.  Specifying a negative value in
timeout means an infinite timeout.



