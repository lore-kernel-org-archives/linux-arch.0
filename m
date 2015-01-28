From: Andreas Schwab <schwab-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [opensuse-factory] Re: libsigsegv build fail with kernel 3.18.3
Date: Wed, 28 Jan 2015 09:48:14 +0100
Message-ID: <mvm7fw7l29d.fsf@hawking.suse.de>
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
	<CA+55aFzHyP1xFhLBUkYTvRTsTe-_PcpQ_Qx0f9e6WEj=0yFt2A@mail.gmail.com>
	<alpine.LSU.2.11.1501272309090.17818@nerf60.vanv.qr>
	<CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <opensuse-kernel+bounces-6421-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CA+55aFzguEFfG2REN1soMC+0UJ7GtANfEvMoCNPt0QqmP9LKoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Linus Torvalds's message of "Tue, 27 Jan 2015 14:32:11 -0800")
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jan Engelhardt <jengelh-9+2X+4sQBs8@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, opensuse-factory-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, OpenSUSE Kernel Team <opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>, "linux-arch@vger.kernel.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> writes:

> So in general, you should try to teach people that "make install"
> should never ever build anything. Because if it does, it's just a
> broken code-flow. It may work, it may be convenient, and with proper
> tools it _may_ even be secure, but it's still a really bad idea.

# make modules_install
Makefile:657: Cannot use CONFIG_CC_STACKPROTECTOR_REGULAR: -fstack-protector not supported by compiler
[...]

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab-l3A5Bk7waGM@public.gmane.org
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
