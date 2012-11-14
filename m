From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 14/31] ARC: syscall support
Date: Wed, 14 Nov 2012 12:31:14 +0000
Message-ID: <50A38F12.8030501@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <CACM3HyFE-S2NM75qVS2Fhhm8YoP1jH4mS41aZ5B1gW2wo-Q99g@mail.gmail.com> <50A23906.6010900@imgtec.com> <201211141223.05063.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54475 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161219Ab2KNMcA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2012 07:32:00 -0500
In-Reply-To: <201211141223.05063.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas.bonn@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Markos <markos.chandras@imgtec.com>

On 14/11/12 12:23, Arnd Bergmann wrote:
> On Tuesday 13 November 2012, James Hogan wrote:
>> Hopefully with several architecture maintainers asking for this it might
>> get somewhere, but indeed we're aware of the feedback problem on that list.
>>
>> The points that I've considered for defaulting to old syscalls:
>> * doesn't change existing behaviour of other architectures, so is simply
>> less risk of breaking them.
>> * could possibly make uClibc slightly smaller if it doesn't have to add
>> extra arguments.
> 
> The second argument is not very good when you consider that it means adding
> the same wrapper into the kernel rather than into uClibc, where it can
> be stripped out when unused (e.g. for static compilation) and doesn't
> have to be present in memory since the library is in pageable user space
> memory, while the kernel side implementation would always have to
> present.

The context is existing architectures which already have to support the
deprecated syscalls pretty much forever (in addition to the new ones),
and therefore can't strip out the kernel side implementation anyway.

I don't see any of these arguments (either way) as holding too much
weight to be honest though.

Cheers
James
