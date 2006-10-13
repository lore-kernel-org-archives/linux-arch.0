Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:49569 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750743AbWJMNzj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:55:39 -0400
Subject: Re: [RFC] crash_stop: crash_stop_i386_handler
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <27440.1160745940@ocs3.ocs.com.au>
References: <27440.1160745940@ocs3.ocs.com.au>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 08:55:35 -0500
Message-Id: <1160747735.3433.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-10-13 at 23:25 +1000, Keith Owens wrote:
> Note 2: This patch does not cover i386 voyager.  I do not understand
>         the voyager interrupt mechanism well enough to define its
>         interrupt handlers (hint, hint).

Voyager actually doesn't need a software based crash dump at all.

The system itself has a type of GSP that runs SUS (sort of a bios)
continuously.  SUS will dump a complete memory and state image to a
nominated dump slice (usually swap) if the OS becomes unresponsive or
requests it.  So all I really have to do is come up with a user space
tool that converts from this raw image format to your crash tool format.

James


