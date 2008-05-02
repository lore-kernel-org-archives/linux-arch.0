From: John Williams <john.williams@petalogix.com>
Subject: Re: microblaze syscall list
Date: Fri, 02 May 2008 15:38:20 +1000
Message-ID: <481AA8CC.10405@petalogix.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <48151726.9000204@itee.uq.edu.au> <200804281431.26570.arnd@arndb.de> <200805012117.12991.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gum.itee.uq.edu.au ([130.102.66.1]:60982 "EHLO
	gum.itee.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758528AbYEBHIc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 May 2008 03:08:32 -0400
In-Reply-To: <200805012117.12991.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Williams <jwilliams@itee.uq.edu.au>, monstr@seznam.cz, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>

Arnd Bergmann wrote:
> On Monday 28 April 2008, Arnd Bergmann wrote:
> 
>>How about this strategy then:
>>* Change all the data types and syscall numbers in the -for-2.6.27
>>branch to only include the minimal set, and a modern ABI
>>* Add the old interfaces as an out-of-tree patch that adds source
>>level compatibility with the old libc, but does not modify any
>>of the new interfaces, so that a patched kernel can run all binaries
>>built for the upstream version.
>>* phase out the old source interface gradually, as all users update
>>their libc source code.
> 
> 
> Any news on this from the microblaze people? Have you made up your mind
> on what route you want to go?

I think we're still digesting it.  I need to sync up with Michal and the 
Xilinx people.  The libc and kernel API changes have to happen in 
tandem, otherwise Michal can't properly test the kernel he's pushing.

I am the defacto MicroBlaze uClibc and toolchain "builder" but somewhat 
reluctantly - am trying to convince Xilnx to hand that over to someone 
who is expert at it.

Michal, John L, any thoughts?

John
