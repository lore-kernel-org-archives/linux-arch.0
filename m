Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59007 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYEDXCn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 19:02:43 -0400
Message-ID: <481E3E53.6050008@zytor.com>
Date: Sun, 04 May 2008 15:53:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: microblaze syscall list
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <481D7DF7.3000909@seznam.cz> <481E3433.2030408@zytor.com> <200805050054.20903.arnd@arndb.de>
In-Reply-To: <200805050054.20903.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>
Message-ID: <20080504225307.LbmuHW3TfAFQSZdhmXyFT6BThUS7YLjTj0JNqaxS6Do@z>

Arnd Bergmann wrote:
> 
> * POSIX pselect does not update the timeout argument, but linux pselect7
> does, so it's easy to implement both pselect and select based on it.
> * pselect also has a timespec arguement, not timeval as select, but that's
> trivial to convert.
> * pselect obviously takes an extra argument, but if that's NULL, it will
> behave like select (aside from the timeout handling).
> 

Fair enough.

	-hpa
