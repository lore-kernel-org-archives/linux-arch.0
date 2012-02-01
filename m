From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v3 0/14] PCI: allocate pci bus num range for unassigned
 bridge busn
Date: Tue, 31 Jan 2012 16:27:06 -0800
Message-ID: <CAE9FiQX7vrXJ_RFYdKFeK2v10BAzVOFNn08a4=pG7vbqjyifTA@mail.gmail.com>
References: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
	<CAErSpo54k=pL1P1z7OetC1qJbsH9LH0GY4QFy-=PPKR0vF14SA@mail.gmail.com>
	<CAE9FiQUYYsfUAi-jy1uQ0V8W0mHF1eTRnHQPK46cajLvPgmR5A@mail.gmail.com>
	<CAErSpo4r-4JH+3cqnsgR1fgNsGQL7wH_JozPSgaHKTweKtoM7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39285 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab2BAA1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2012 19:27:07 -0500
In-Reply-To: <CAErSpo4r-4JH+3cqnsgR1fgNsGQL7wH_JozPSgaHKTweKtoM7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jan 31, 2012 at 3:30 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> Thanks. =A0I tried this, and it blew up as soon as I did a rescan. =A0=
More
> complete console log attached.
>
> # echo 1 > /sys/bus/pci/rescan
> [ =A0140.237870] pci_bus 0000:00: scanning bus pass 0
> [ =A0140.242551] pci 0000:00:01.0: scanning [bus 01-01] behind bridge=
, pass 0
> [ =A0140.249249] pci 0000:00:01.0: check if busn 01-01 is in busn_res=
: [bus 00-7e]
> [ =A0140.256377] pci 0000:00:01.0: bus configuration invalid, reconfi=
guring
> [ =A0140.262912] pci 0000:00:01.1: scanning [bus 02-02] behind bridge=
, pass 0
> [ =A0140.269593] pci 0000:00:01.1: check if busn 02-02 is in busn_res=
: [bus 00-7e]
> [ =A0140.276721] pci 0000:00:01.1: bus configuration invalid, reconfi=
guring

did not try this test case.

will check that .

Thanks

Yinghai
