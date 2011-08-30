From: emunson@mgebm.net
Subject: Re: [PATCH 0/4] Avoid soft lockup message when KVM is stopped by host
Date: Tue, 30 Aug 2011 17:50:32 -0600
Message-ID: <7a46c2b8bc6602df7f3e48a92d826c2e@mgebm.net>
References: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
 <20110830122630.GA19450@amt.cnet>
 <CAKu_SN2rYCgjCAydf0B_78QgYnT4yHTLZ3G7-qAXOUSgxXYkQA@mail.gmail.com>
 <20110830183613.GB23897@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20110830183613.GB23897@amt.cnet>
Sender: kvm-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: avi@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm-ppc@vger.kernel.org, aliguori@us.ibm.com, raharper@us.ibm.com, kvm-ia64@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

 On Tue, 30 Aug 2011 15:36:13 -0300, Marcelo Tosatti wrote:
> On Tue, Aug 30, 2011 at 10:37:13AM -0600, Eric B Munson wrote:
>> On Tue, Aug 30, 2011 at 06:26, Marcelo Tosatti <mtosatti@redhat.com>=
=20
>> wrote:
>> > On Mon, Aug 29, 2011 at 05:27:11PM -0600, Eric B Munson wrote:
>> >> Currently, when qemu stops a guest kernel that guest will issue a=
=20
>> soft lockup
>> >> message when it resumes. =C2=A0This set provides the ability for =
qemu=20
>> to comminucate
>> >> to the guest that it has been stopped. =C2=A0When the guest hits =
the=20
>> watchdog on
>> >> resume it will check if it was suspended before issuing the=20
>> warning.
>> >>
>> >> Eric B Munson (4):
>> >> =C2=A0 Add flag to indicate that a vm was stopped by the host
>> >> =C2=A0 Add functions to check if the host has stopped the vm
>> >> =C2=A0 Add generic stubs for kvm stop check functions
>> >> =C2=A0 Add check for suspended vm in softlockup detector
>> >>
>> >> =C2=A0arch/x86/include/asm/pvclock-abi.h | =C2=A0 =C2=A01 +
>> >> =C2=A0arch/x86/include/asm/pvclock.h =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
2 ++
>> >> =C2=A0arch/x86/kernel/kvmclock.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 14 ++++++++++++++
>> >> =C2=A0include/asm-generic/pvclock.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
14 ++++++++++++++
>> >> =C2=A0kernel/watchdog.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 ++++++++++++
>> >> =C2=A05 files changed, 43 insertions(+), 0 deletions(-)
>> >> =C2=A0create mode 100644 include/asm-generic/pvclock.h
>> >>
>> >> --
>> >> 1.7.4.1
>> >
>> > How is the host supposed to set this flag?
>>
>> The hypervisor will set the flag (the second bit in the struct
>> pvclock_vcpu_time_info.flags field) when it stops the guest.  I=20
>> could
>> be reading pvclock-abi.h incorrectly, but the way I understand it is
>> that this structure is used to communicate between hypervisor and
>> guest.
>
> Yes, its awkward though (to have an interface to modify a bit in
> pvclock->flags from QEMU).
>
> Anyway, it appears that all elements to fix this in QEMU without the
> need for a paravirt interface are available... did you look into my
> suggestion?

 I have not yet, but will look into it.  I sent these out because I was
 under the impression that there was some discussion at LinuxCon about
 your suggestion and that it was agreed that the all user space solutio=
n
 was not feasible.

>
>> > As mentioned previously, if you save save/restore the offset added=
=20
>> to
>> > kvmclock on stop/cont (and the TSC MSR, forgot to mention that),=20
>> no
>> > paravirt infrastructure is required. Which means the issue is also=
=20
>> fixed
>> > for older guests.
>> >

