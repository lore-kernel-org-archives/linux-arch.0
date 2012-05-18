From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 00/21] PCI: use busn_res to replace bus secondary/subordinate
Date: Thu, 17 May 2012 19:13:03 -0700
Message-ID: <CAE9FiQXN5z0riswyECKw5OKe+nPUBN2yZ1d4=Asb3kqaj770NA@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6OZYXz-M=C9r154MY7kwC7LRR3ZnQe3pnmVJY2uoWeRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57925 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966624Ab2ERCNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 22:13:05 -0400
In-Reply-To: <CAErSpo6OZYXz-M=C9r154MY7kwC7LRR3ZnQe3pnmVJY2uoWeRw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, May 17, 2012 at 3:19 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> Sigh. =A0You previously said we should do this order:
>
> =A0 =A0 =A0 =A0for-pci-hostbridge-cleanup
> =A0 =A0 =A0 =A0for-pci-busn-alloc
> =A0 =A0 =A0 =A0for-pci-res-alloc
> =A0 =A0 =A0 =A0for-pci-root-bus-hotplug
> =A0 =A0 =A0 =A0for-pci-for-each-res-addon
>
> I merged for-pci-hostbridge-cleanup already. =A0I was about to start
> merging for-pci-busn-alloc.
>
> But now you added for-pci-hotplug-cleanup and made for-pci-busn-alloc
> depend on it. =A0I have some comments on for-pci-hotplug-cleanup, so =
I'm
> not ready to merge it quite yet. =A0Can you please just go back to th=
e
> original order and put the new hotplug cleanup stuff at the *end*?

ok, update for-pci-busn_res branch, now it is based on your next branch=
=2E

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn_res

later will push out

       for-pci-hotplug
       for-pci-busn-alloc
       for-pci-root-bus-hotplug
       for-pci-for-each-res-addon
       for-pci-res-alloc

Yinghai
