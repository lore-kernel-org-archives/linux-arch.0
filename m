Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261616AbUKOPEr@vger.kernel.org>
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:3588
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261606AbUKOPEr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Nov 2004 10:04:47 -0500
Message-Id: <200411151718.iAFHIG8P002768@ccure.user-mode-linux.org>
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error 
In-Reply-To: Your message of "Mon, 15 Nov 2004 12:40:44 +0100."
             <419895BC.6060109@fujitsu-siemens.com>
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org> <20041112163442.45fc966f.akpm@osdl.org> <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>  <419895BC.6060109@fujitsu-siemens.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Nov 2004 12:18:15 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

bstroesser@fujitsu-siemens.com said:
> I guess, you are notb using i386 2.6.9. On a 2.6.9-vanilla i386 the
> test doesn't fail!

Sorry, I should have mentioned that this host was running 2.4 (stock 2.4.26).

				Jeff
