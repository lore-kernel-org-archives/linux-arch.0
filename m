From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Tue, 27 Jan 2015 23:14:29 +0100 (CET)
Message-ID: <alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr>
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz> <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr> <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de> <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
 <alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr> <CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ares61.inai.de ([5.9.23.85]:45213 "EHLO ares60.inai.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759543AbbA0WOb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jan 2015 17:14:31 -0500
In-Reply-To: <CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>


On Tuesday 2015-01-27 22:32, Linus Torvalds wrote:
>On Tue, Jan 27, 2015 at 1:12 PM, Jan Engelhardt <jengelh@inai.de> wrote:
>>
>> The 2nd patch (from 12:57:20 -0800) plus the one-liner for mm/memory.c
>> at the callsite for check_stack_guard_page makes the test still
>> not succeed.
>
>Really? What platform? I get "all 5 tests passed"
>with the patch I sent out, combined with this:
>   diff --git a/mm/memory.c b/mm/memory.c
>   index 54f3a9b00956..2c3536cc6c63 100644

Turns out I missed a make call in the procedure  *blush*.
Sometimes I wish `make modules_install` would run the compile stage as well..
just like `make install` does in autotooled projects.
