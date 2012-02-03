From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v1 07/18] arm/PCI: get rid of device resource fixups
Date: Fri, 3 Feb 2012 08:12:02 -0800
Message-ID: <CAErSpo6Ytx06f0yMW5q=YQBTcLxRdbBbB6EzSAFWNG82t=Qe4g@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com> <20120203160146.GM889@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57447 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2BCQMX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2012 11:12:23 -0500
Received: by wics10 with SMTP id s10so2727898wic.19
        for <linux-arch@vger.kernel.org>; Fri, 03 Feb 2012 08:12:22 -0800 (PST)
In-Reply-To: <20120203160146.GM889@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 3, 2012 at 8:01 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 30, 2012 at 09:57:45AM -0700, Bjorn Helgaas wrote:
>> Tell the PCI core about host bridge address translation so it can take
>> care of bus-to-resource conversion for us.
>
> Are the rest of these patches (in particular whereever is introduced
> the generic versions) available somewhere?

Oh, sorry, this doesn't mean much without the context.  Here's a
pointer to the overview, with a git tree and so on:

http://marc.info/?l=linux-arch&m=132794281821723&w=2

Bjorn
