From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v1 07/18] arm/PCI: get rid of device resource fixups
Date: Fri, 3 Feb 2012 09:51:04 -0800
Message-ID: <CAErSpo6d82dKHffEZT9JUQw5fbGRadb5BRN7+sybqKqenQNnBg@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com>
 <20120203160146.GM889@n2100.arm.linux.org.uk> <CAErSpo6Ytx06f0yMW5q=YQBTcLxRdbBbB6EzSAFWNG82t=Qe4g@mail.gmail.com>
 <20120203165543.GP889@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46885 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab2BCRvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2012 12:51:25 -0500
Received: by wics10 with SMTP id s10so2803935wic.19
        for <linux-arch@vger.kernel.org>; Fri, 03 Feb 2012 09:51:24 -0800 (PST)
In-Reply-To: <20120203165543.GP889@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 3, 2012 at 8:55 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 03, 2012 at 08:12:02AM -0800, Bjorn Helgaas wrote:
>> On Fri, Feb 3, 2012 at 8:01 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jan 30, 2012 at 09:57:45AM -0700, Bjorn Helgaas wrote:
>> >> Tell the PCI core about host bridge address translation so it can=
 take
>> >> care of bus-to-resource conversion for us.
>> >
>> > Are the rest of these patches (in particular whereever is introduc=
ed
>> > the generic versions) available somewhere?
>>
>> Oh, sorry, this doesn't mean much without the context. =A0Here's a
>> pointer to the overview, with a git tree and so on:
>>
>> http://marc.info/?l=3Dlinux-arch&m=3D132794281821723&w=3D2
>
> Trying to read github in elinks isn't very nice. =A0But from what I c=
ould
> see it looks fine. =A0When I get around to pulling my private patchse=
ts
> forward, I'll try to remember to give this a test.

Thanks for taking a look.  Let me know if you find issues.

> The thing which was concerning me is that I have been carrying the
> following patches for the last 10 years or more in various forms to
> make PCMCIA work on a couple of platforms I have here. =A0It's more
> or less the same problem, and it uses the bus_to_resource stuff to
> fix it for Yenta.
>
> These patches address PCMCIA's idea of 'lowmem' windows always being
> at the low 640K of _CPU_ memory rather than the low 640K of _bus_
> memory. =A0When your bus starts at an offset of more than 640K in CPU
> memory, the resource handling doesn't work as well.

My patches only affect devices below a PCI host bridge, and from the
device's point of view, it should see no difference -- the values in
its BARs shouldn't change.

I know very little about PCMCIA.  The dependency on the CPU addresses
is interesting.   I would think such a dependency would mean we're
missing a bus/resource conversion somewhere, but it must be more
complicated than that.

But in any event, my *intent* is that neither CPU addresses nor bus
addresses should change.  If they do change, that's a bug in my
series.

> I've never pushed these upstream because I'm not entirely sure why
> PCMCIA deals with lowmem windows on a card-by-card basis, rather than
> a socket basis (surely its more to do with the capabilities of the
> socket interface than the card itself...)

Bjorn
