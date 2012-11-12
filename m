From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [arc-linux-dev] Re: UAPI for new arches (was Re: [GIT PULL] User
 API Disintegrate: Preparatory patches)
Date: Mon, 12 Nov 2012 16:27:56 +0530
Message-ID: <50A0D634.20005@synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA230750D9832@in01wembx1.internal.synopsys.com> <509251CA.8050008@synopsys.com> <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>,<8419.1352387261@warthog.procyon.org.uk> <14356.1352416788@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:35561 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2KLK6O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 05:58:14 -0500
In-Reply-To: <14356.1352416788@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arc-linux-dev@synopsys.com
Cc: David Howells <dhowells@redhat.com>, James Hogan <james@albanarts.com>, "torvalds@osdl.org" <torvalds@osdl.org>, "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "fengguang.wu@intel.com" <fengguang.wu@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday 09 November 2012 04:49 AM, David Howells wrote:
> Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
>> While I'd done some of the prep work in my code such as splitting __KERNEL__
>> && __ASSEMBLY__ into two separate lines, majority of orig headers didn't
>> have #ifdef __KERNEL__ guard despite the code not being meant for user-space
>> ABI. Is that fundamental to UAPI split scripting
> Yes.  My scripts work purely along __KERNEL__ lines.  If there are no
> __KERNEL__ markers and the header is marked for export, it is simply moved.

Understood.

>
>> because it seems to be causing setup.h to be in uapi despite seemingly being
>> kernel internal only.
> Check also include/uapi/asm-generic/Kbuild.asm.  That exports setup.h, whether
> you think it should be exported or not.

Correct. And if there's nothing to export in there the script will not
generate the empty uapi sibling.

>> Per you email from last week, When I ran the disintergrate-one.pl script
>> myself I saw a whole bunch of empty UAPI files being generated with
>> references in orig header.  I'm not sure what I'm doing wrong.
> Can you give an example of such a header?

tlb.h - despite having __KERNEL__ guard in orig file. Here's how I did it.

1. In my orig tree, I created arch/arc/include/uapi/asm/Kbuild, with
following 2 lines

# UAPI Header export list
include include/uapi/asm-generic/Kbuild.asm

2.  ./disintegrate-one.pl arch/arc/include/asm/tlb.h
arch/arc/include/uapi/asm/tlb.h

This generates a empty uapi/asm/tlb.h, a reference to it in asm/tlb.h
and is also exported from Kbuild.asm - all 3 of which are wrong.

But now that I think about it - I was wrong to call this script for
all/any arch headers. It should be done only for the ones in
include/uapi/asm-generic/Kbuild.asm or any specific ones that arch wants
to export (cachectl.h for our case).

>
>> For any ABI changes to headers per review of the new port on list
>> (e.g. don't export pt_regs) would mean moving the code manually from uapi to
>> orig header - right. And if the file becomes empty just nuke it completely.
> You can't necessarily remove a UAPI header completely.  Userspace may depend
> on its existence, even if it gets no content from there.
>
>> How do you reckon we go about fixing these. I don't want to bother you
>> multiple times hence it would be best if I could reproduce this at my end.
> The best advice I can give you without more specific examples is to compare
> what's in your arch's headers to those of, say, hexagon or arm64.  Those are
> recent additions and should be pretty clean as to what they contain.
>
> David
