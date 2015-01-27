From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Wed, 28 Jan 2015 00:13:12 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1501272334450.19520@nerf60.vanv.qr>
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz> <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr> <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de> <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
 <alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr> <CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com> <alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr> <CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ares61.inai.de ([5.9.23.85]:45443 "EHLO ares60.inai.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752403AbbA0XNP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jan 2015 18:13:15 -0500
In-Reply-To: <CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>


On Tuesday 2015-01-27 23:32, Linus Torvalds wrote:
>On Tue, Jan 27, 2015 at 2:14 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>>
>> Sometimes I wish `make modules_install` would run the compile stage as well..
>> just like `make install` does in autotooled projects.
>
>You should *never* compile things as root.

I certainly agree with you on that. So perhaps make throwing an error
instead would be helpful here - "hey there are uncompiled things
left, modules_install would give you nonmatching files".


>Sadly, I seem to be alone in my hatred of automake/configure/etc.

(Look no further than netdev if you need company.)

There are certainly points where it does not excel; however, in a 
distribution where we have to deal with not just one idiosyncratic build 
system, but 15+, it is the preferred choice to have especially if and 
when it comes down having to edit the build instructions for one reason 
or another.
