Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:47404 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750841AbWJMN7t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:59:49 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Re: [RFC] crash_stop: crash_stop_i386_handler 
In-reply-to: Your message of "Fri, 13 Oct 2006 08:55:35 EST."
             <1160747735.3433.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Oct 2006 00:00:10 +1000
Message-ID: <11126.1160748010@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

James Bottomley (on Fri, 13 Oct 2006 08:55:35 -0500) wrote:
>On Fri, 2006-10-13 at 23:25 +1000, Keith Owens wrote:
>> Note 2: This patch does not cover i386 voyager.  I do not understand
>>         the voyager interrupt mechanism well enough to define its
>>         interrupt handlers (hint, hint).
>
>Voyager actually doesn't need a software based crash dump at all.

This API is designed for any kernel debug tool, not just crash dump.
This includes run time debuggers such as kdb, kgdb and nlkd.

>The system itself has a type of GSP that runs SUS (sort of a bios)
>continuously.  SUS will dump a complete memory and state image to a
>nominated dump slice (usually swap) if the OS becomes unresponsive or
>requests it.  So all I really have to do is come up with a user space
>tool that converts from this raw image format to your crash tool format.

Not my crash format, other people maintain the crash dump tools.

