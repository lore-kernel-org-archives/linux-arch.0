From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Tue, 13 Nov 2012 09:43:59 +0000
Message-ID: <50A2165F.4010202@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <509D2D4F.20304@imgtec.com> <50A12AE3.4090404@imgtec.com> <201211121910.09395.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55636 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab2KMJoH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Nov 2012 04:44:07 -0500
In-Reply-To: <201211121910.09395.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On 12/11/12 19:10, Arnd Bergmann wrote:
> On Monday 12 November 2012, James Hogan wrote:
>> Note that Meta doesn't support unaligned accesses anyway so use of
>> __packed on MMIO is likely broken from the outset.
> 
> The problem is actually the opposite: Some people incorrectly annotate
> structures that are always aligned to be __packed. This has no effect
> on architectures that support unaligned accesses, but causes the
> access to be split into byte sized loads and stores on architectures
> like Meta that cannot.
> 
> Note also that gcc is free to split any accesses for whatever reason
> it deems necessary.

Hmm, I found the thread "ARM unaligned MMIO access with
attribute((packed))" which appears to be one of the problems you're
referring to. With some experimentation I can't reproduce this kind of
problem with our current compiler, but it's certainly cause for concern.

Thanks
James
