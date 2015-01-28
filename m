Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43457 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbbA2BYF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Jan 2015 20:24:05 -0500
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail with kernel 3.18.3
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
	<CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
	<alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr>
	<CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
Date: Wed, 28 Jan 2015 09:48:14 +0100
In-Reply-To: <CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 27 Jan 2015 14:32:11 -0800")
Message-ID: <mvm7fw7l29d.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Engelhardt <jengelh@inai.de>, Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150128084814.IXmj69E4ihm21s0TmnECqyr4M1ATWoO0WwhDM0xEWVM@z>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So in general, you should try to teach people that "make install"
> should never ever build anything. Because if it does, it's just a
> broken code-flow. It may work, it may be convenient, and with proper
> tools it _may_ even be secure, but it's still a really bad idea.

# make modules_install
Makefile:657: Cannot use CONFIG_CC_STACKPROTECTOR_REGULAR: -fstack-protector not supported by compiler
[...]

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
