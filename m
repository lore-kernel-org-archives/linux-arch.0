From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 00/21] PCI: use busn_res to replace bus secondary/subordinate
Date: Fri, 18 May 2012 21:38:15 -0700
Message-ID: <CAE9FiQX-Ut3=WfjeKVBBO55NMQTXZdCC2NbsrX=p3MHVWLahtQ@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6OZYXz-M=C9r154MY7kwC7LRR3ZnQe3pnmVJY2uoWeRw@mail.gmail.com>
	<CAE9FiQXN5z0riswyECKw5OKe+nPUBN2yZ1d4=Asb3kqaj770NA@mail.gmail.com>
	<CAErSpo71805jTs1qVMx+9ghzUub77r47VqpXF0sVOFuDSq6pmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo71805jTs1qVMx+9ghzUub77r47VqpXF0sVOFuDSq6pmg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 18, 2012 at 4:32 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Thu, May 17, 2012 at 8:13 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> On Thu, May 17, 2012 at 3:19 PM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>>> Sigh. =A0You previously said we should do this order:
>>>
>>> =A0 =A0 =A0 =A0for-pci-hostbridge-cleanup
>>> =A0 =A0 =A0 =A0for-pci-busn-alloc
>>> =A0 =A0 =A0 =A0for-pci-res-alloc
>>> =A0 =A0 =A0 =A0for-pci-root-bus-hotplug
>>> =A0 =A0 =A0 =A0for-pci-for-each-res-addon
>>>
>>> I merged for-pci-hostbridge-cleanup already. =A0I was about to star=
t
>>> merging for-pci-busn-alloc.
>>>
>>> But now you added for-pci-hotplug-cleanup and made for-pci-busn-all=
oc
>>> depend on it. =A0I have some comments on for-pci-hotplug-cleanup, s=
o I'm
>>> not ready to merge it quite yet. =A0Can you please just go back to =
the
>>> original order and put the new hotplug cleanup stuff at the *end*?
>>
>> ok, update for-pci-busn_res branch, now it is based on your next bra=
nch.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.=
git
>> for-pci-busn_res
>
> OK. =A0You just incorporated the hotplug-cleanup stuff into that bran=
ch,
> which isn't what I had in mind. =A0But in the interest of making forw=
ard
> progress, I merged as much as I could. =A0The result is at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next=
-3.5
>
> After Linus pulls my current "next" branch during the merge window,
> I'll put the "next-3.5" stuff into the "next" branch.

Great! Thanks a lot.

looks one of commit author is messed up.

http://git.kernel.org/?p=3Dlinux/kernel/git/helgaas/pci.git;a=3Dcommitd=
iff;h=3Db20238f05059818de8edd76cb5523b6bf8e26527

author	Bjorn Helgaas <bhelgaas@google.com>=09
	Fri, 18 May 2012 17:35:50 +0000 (11:35 -0600)
committer	Bjorn Helgaas <bhelgaas@google.com>=09
	Fri, 18 May 2012 20:00:35 +0000 (14:00 -0600)
Will use them insert/update busn res in pci_bus struct.

[bhelgaas: print conflicting entry if insertion fails]
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

but if changing it would take you too much time, just leave it as is.

>
> Note that I stopped at your probe_resource() patch -- I already told
> you I won't merge that in its current form because I think the
> interface you propose is too complicated.

ok, let me check if i could simplify it more.

>
> Let me know what series you'd like me to work on next, and send the
> current patches to the list.

Maybe for-pci-res-alloc could be moved forwarded, then
for-pci-busn-alloc
for-pci-root-bus-hotplug
for-pci-for-each-res-addon

Yinghai
