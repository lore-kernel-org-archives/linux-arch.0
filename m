From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/21] PCI: use busn_res to replace bus secondary/subordinate
Date: Fri, 18 May 2012 17:32:17 -0600
Message-ID: <CAErSpo71805jTs1qVMx+9ghzUub77r47VqpXF0sVOFuDSq6pmg@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
 <CAErSpo6OZYXz-M=C9r154MY7kwC7LRR3ZnQe3pnmVJY2uoWeRw@mail.gmail.com> <CAE9FiQXN5z0riswyECKw5OKe+nPUBN2yZ1d4=Asb3kqaj770NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQXN5z0riswyECKw5OKe+nPUBN2yZ1d4=Asb3kqaj770NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 17, 2012 at 8:13 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, May 17, 2012 at 3:19 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>> Sigh. =A0You previously said we should do this order:
>>
>> =A0 =A0 =A0 =A0for-pci-hostbridge-cleanup
>> =A0 =A0 =A0 =A0for-pci-busn-alloc
>> =A0 =A0 =A0 =A0for-pci-res-alloc
>> =A0 =A0 =A0 =A0for-pci-root-bus-hotplug
>> =A0 =A0 =A0 =A0for-pci-for-each-res-addon
>>
>> I merged for-pci-hostbridge-cleanup already. =A0I was about to start
>> merging for-pci-busn-alloc.
>>
>> But now you added for-pci-hotplug-cleanup and made for-pci-busn-allo=
c
>> depend on it. =A0I have some comments on for-pci-hotplug-cleanup, so=
 I'm
>> not ready to merge it quite yet. =A0Can you please just go back to t=
he
>> original order and put the new hotplug cleanup stuff at the *end*?
>
> ok, update for-pci-busn_res branch, now it is based on your next bran=
ch.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.g=
it
> for-pci-busn_res

OK.  You just incorporated the hotplug-cleanup stuff into that branch,
which isn't what I had in mind.  But in the interest of making forward
progress, I merged as much as I could.  The result is at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next-3.=
5

After Linus pulls my current "next" branch during the merge window,
I'll put the "next-3.5" stuff into the "next" branch.

Note that I stopped at your probe_resource() patch -- I already told
you I won't merge that in its current form because I think the
interface you propose is too complicated.

Let me know what series you'd like me to work on next, and send the
current patches to the list.

Bjorn
