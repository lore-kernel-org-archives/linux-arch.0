Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261368AbUKPJjU@vger.kernel.org>
Received: from plam.fujitsu-siemens.com ([217.115.66.9]:33338 "EHLO
	plam.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261333AbUKPJjU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Nov 2004 04:39:20 -0500
Message-ID: <4199CAC3.6070806@fujitsu-siemens.com>
Date: Tue, 16 Nov 2004 10:39:15 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org> <20041112163442.45fc966f.akpm@osdl.org> <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>  <419895BC.6060109@fujitsu-siemens.com> <200411151718.iAFHIG8P002768@ccure.user-mode-linux.org>
In-Reply-To: <200411151718.iAFHIG8P002768@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Jeff Dike wrote:
> bstroesser@fujitsu-siemens.com said:
> 
>>I guess, you are notb using i386 2.6.9. On a 2.6.9-vanilla i386 the
>>test doesn't fail!
> 
> 
> Sorry, I should have mentioned that this host was running 2.4 (stock 2.4.26).
> 
> 				Jeff
> 
Yes. That makes sense. There are substantial changes in syscall restarting
between 2.4 and 2.6 (e.g ERESTART_RESTARTBLOCK added). Please run the tests on
2.6.9-i386 to get the correct result: all tests are OK, but sigmasking.

Bodo
