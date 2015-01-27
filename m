From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Tue, 27 Jan 2015 14:32:11 -0800
Message-ID: <CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	<54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org>
	<s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
	<CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
	<alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:63922 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbbA0WcM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jan 2015 17:32:12 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so7255763iga.5
        for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2015 14:32:11 -0800 (PST)
In-Reply-To: <alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, Jan 27, 2015 at 2:14 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>
> Sometimes I wish `make modules_install` would run the compile stage as well..
> just like `make install` does in autotooled projects.

This is just one more reason to hate autotools. It's shit.

You should *never* compile things as root. It's not just a bad idea in
that it leaves possible root-owned files in your project (which in
turn can make cleanup harder etc), but it is historically also an
actual security issue with the whole temporary file mess in /tmp and
various racy symlink-attacks.

So in general, you should try to teach people that "make install"
should never ever build anything. Because if it does, it's just a
broken code-flow. It may work, it may be convenient, and with proper
tools it _may_ even be secure, but it's still a really bad idea.

Sadly, I seem to be alone in my hatred of automake/configure/etc.

                          Linus
