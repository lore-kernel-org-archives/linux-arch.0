From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Early crash (was: Re: module: show version information for built-in modules in sysfs)
Date: Thu, 03 Feb 2011 01:10:04 +0100
Message-ID: <m2bp2udllv.fsf@igel.home>
References: <AANLkTin4gOnEMruLDM=TkNYsNf5S370WqbcDVJzT7_Z4@mail.gmail.com>
	<20110201210944.GA12348@dtor-ws.eng.vmware.com>
	<AANLkTimv=KqtuR36dMNa+=OMi0mgd8JK4qsb_SpmKmhs@mail.gmail.com>
	<20110201222637.GA17521@dtor-ws.eng.vmware.com>
	<AANLkTikWVt8NEyHN+=yD4EWSXUQt0gt5nLJtKQDw397M@mail.gmail.com>
	<20110202194227.GA13794@dtor-ws.eng.vmware.com>
	<m2ipx2dp7v.fsf@igel.home>
	<20110202235948.GA8676@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110202235948.GA8676@dtor-ws.eng.vmware.com> (Dmitry Torokhov's
	message of "Wed, 2 Feb 2011 15:59:49 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Dmitry Torokhov <dtor@vmware.com> writes:

> Even pointers? I'd expect pointers to be aligned on 4-bytes boundaries?

Pointers are not special in any way.  Why should they?  On the machine
level pointers are just numbers.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
