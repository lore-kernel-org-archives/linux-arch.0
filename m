From: Michal Simek <monstr@seznam.cz>
Subject: Re: Microblaze init port v4
Date: Thu, 26 Jun 2008 20:59:22 +0200
Message-ID: <4863E70A.2060108@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <200806261709.37045.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:35240 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513AbYFZS6L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 14:58:11 -0400
In-Reply-To: <200806261709.37045.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com, john.williams@petalogix.com

Hi Arnd,

> On Thursday 26 June 2008, monstr@seznam.cz wrote:
>> We have there still problem with syscalls and we don't have chance to 
>> fix it to stable version, this is not part which I can do yourself. 
>> Microblaze will be n + 1 platform which use some old syscalls. 
>> I hope you understand.
> 
> That still leaves the problem that a lot of your syscalls have bugs
> copied from other platforms. If you need to maintain backwards compatibility
> with your existing binaries, that's fine, but please fix the code you are
> adding.

This is for now. I'll remove when I will have new toolchain.

I saw an email from you about.

M
