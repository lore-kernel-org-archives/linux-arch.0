From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v11 04/30] PCI: Add busn_res into struct pci_bus.
Date: Tue, 1 May 2012 09:40:05 -0600
Message-ID: <CAErSpo5EdBY-8M5FnQaGHOAvhaGO7qLHdDkmYGyDRN9de4umNw@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
 <1332135781-13695-5-git-send-email-yinghai@kernel.org> <CAErSpo6Wbjh_pzDOkGRoog2WeJQET9UT0fiaanV0r15pq7hT6Q@mail.gmail.com>
 <CAE9FiQV0XTd_1Ujz=tb6BSuwJvJ9nbT_GbE2PREtgMGv=yG0+g@mail.gmail.com>
 <CAErSpo57pH81KtUbYZ3j6y4kC+ka33Lzr4rfcywVWf8OTmH_5Q@mail.gmail.com> <CAE9FiQUOsMOQgZXCuPHpc6ZSEGnY3nv+uy1o0xvrW8-LKwNZrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQUOsMOQgZXCuPHpc6ZSEGnY3nv+uy1o0xvrW8-LKwNZrg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 1, 2012 at 12:27 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Apr 30, 2012 at 9:02 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>> On Mon, Apr 30, 2012 at 6:32 PM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>>> On Mon, Apr 30, 2012 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com=
> wrote:
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -419,6 +419,7 @@ struct pci_bus {
>>>>> =A0 =A0 =A0 =A0struct list_head slots; =A0 =A0 =A0 =A0 /* list of=
 slots on this bus */
>>>>> =A0 =A0 =A0 =A0struct resource *resource[PCI_BRIDGE_RESOURCE_NUM]=
;
>>>>> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* address spa=
ce routed to this bus */
>>>>> + =A0 =A0 =A0 struct resource busn_res; =A0 =A0 =A0 /* track regi=
stered bus num range */
>>>>>
>>>>> =A0 =A0 =A0 =A0struct pci_ops =A0*ops; =A0 =A0 =A0 =A0 =A0 /* con=
figuration access functions */
>>>>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*sysdata; =A0 =A0 =A0 =
/* hook for sys-specific extension */
>>>>
>>>> struct pci_bus already includes "secondary" and "subordinate". =A0=
 =A0This
>>>> new "busn_res" looks like it will contain the same information. =A0=
Why
>>>> do we need both?
>>>
>>> In some case the could be different.
>>> for root bus from _CRS, busn_res could bigger than subordinate,
>>> because scan_childbus will update subordinate.
>>
>> For a bus below a P2P bridge, I think it's always the case that the
>> bridge's Subordinate Bus Number in config space =3D=3D bus->subordin=
ate =3D=3D
>> bus->busn_res.end (correct me if I'm wrong). =A0I don't like the
>> redundancy in this case.
>
> there are about 70 bus->subordinate reference and 40 bus->secondary r=
eference.
>
> could try to update them in following patch set.

If you're proposing this:
  1. add bus->busn_res
  2. remove bus->subordinate and bus->secondary
I fully support that, and I'd like to merge both pieces at the same
time (different patches is fine; I just want to make sure both pieces
actually happen).

>> For a root bus where you set bus->busn_res from _CRS and
>> bus->subordinate =3D pci_scan_child_bus(), bus->busn_res.end will
>> generally be different from bus->subordinate, but there's no point i=
n
>> keeping track of bus->subordinate.
>>
>> The reason we care about secondary and subordinate is so we can
>> allocate bus numbers when enumerating devices behind a bridge. =A0Th=
e
>> only thing we need for that is the aperture of the upstream bridge a=
nd
>> the apertures of any peer bridges on the same bus. =A0Let's say we h=
ave
>> this:
>>
>> =A0 =A0 =A0 =A0pci 00:00.0 bridge to [bus a-b]
>> =A0 =A0 =A0 =A0pci a:01.0 bridge to [bus c-d] =A0(already enumerated=
)
>> =A0 =A0 =A0 =A0pci a:02.0 bridge to [bus e-f] =A0(already enumerated=
)
>> =A0 =A0 =A0 =A0pci a:03.0 bridge to [bus x-y] =A0(enumerating now)
>>
>> We know [c-d] is contained in [a-b]; [e-f] is contained in [a-b]; a =
<
>> c; and a < e. =A0To enumerate behind a:03.0, we need to assign x & y
>> such that a < x; [x-y] is contained in [a-b]; and [x-y] does not
>> overlap [c-d] or [e-f]. =A0The value from pci_scan_child_bus() is
>> probably useful for setting y, but we don't have to save it in the
>> struct pci_bus for that.
>
> busn alloc will try to solve x-y may need big range than [a,b], it
> will extend top of b and parents of bus a.
> instead of just b+1 blindly.
>
> and will have more strict checking to avoid overlapping.

Obviously the completely general problem of allocating bus numbers may
require traversing up the tree.  My point is that I don't think it's
necessary to keep both busn_res.end and subordinate to do that.

>>> and also we have one resource to insert it into the resource tree, =
so
>>> later could probe/allocate bus num range.
>>
>> Sorry, I didn't understand this.
>
> Using busn_res to track and allocate busn range, by put them in the
> resource tree could reuse resource allocating code.

Yes, I agree that replacing secondary & subordinate with a struct
resource is a good idea.  That will allow a resource tree of bus
numbers, as well as other useful things like the ability to "%pR".

I just don't want *both* busn_resource and secondary & subordinate.

Bjorn
