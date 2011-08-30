From: Eric B Munson <emunson@mgebm.net>
Subject: Re: [PATCH 0/4] Avoid soft lockup message when KVM is stopped by host
Date: Tue, 30 Aug 2011 10:37:13 -0600
Message-ID: <CAKu_SN2rYCgjCAydf0B_78QgYnT4yHTLZ3G7-qAXOUSgxXYkQA@mail.gmail.com>
References: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
	<20110830122630.GA19450@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20110830122630.GA19450@amt.cnet>
Sender: kvm-ppc-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: avi@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm-ppc@vger.kernel.org, aliguori@us.ibm.com, raharper@us.ibm.com, kvm-ia64@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 30, 2011 at 06:26, Marcelo Tosatti <mtosatti@redhat.com> wr=
ote:
> On Mon, Aug 29, 2011 at 05:27:11PM -0600, Eric B Munson wrote:
>> Currently, when qemu stops a guest kernel that guest will issue a so=
ft lockup
>> message when it resumes. =A0This set provides the ability for qemu t=
o comminucate
>> to the guest that it has been stopped. =A0When the guest hits the wa=
tchdog on
>> resume it will check if it was suspended before issuing the warning.
>>
>> Eric B Munson (4):
>> =A0 Add flag to indicate that a vm was stopped by the host
>> =A0 Add functions to check if the host has stopped the vm
>> =A0 Add generic stubs for kvm stop check functions
>> =A0 Add check for suspended vm in softlockup detector
>>
>> =A0arch/x86/include/asm/pvclock-abi.h | =A0 =A01 +
>> =A0arch/x86/include/asm/pvclock.h =A0 =A0 | =A0 =A02 ++
>> =A0arch/x86/kernel/kvmclock.c =A0 =A0 =A0 =A0 | =A0 14 +++++++++++++=
+
>> =A0include/asm-generic/pvclock.h =A0 =A0 =A0| =A0 14 ++++++++++++++
>> =A0kernel/watchdog.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12 +++=
+++++++++
>> =A05 files changed, 43 insertions(+), 0 deletions(-)
>> =A0create mode 100644 include/asm-generic/pvclock.h
>>
>> --
>> 1.7.4.1
>
> How is the host supposed to set this flag?

The hypervisor will set the flag (the second bit in the struct
pvclock_vcpu_time_info.flags field) when it stops the guest.  I could
be reading pvclock-abi.h incorrectly, but the way I understand it is
that this structure is used to communicate between hypervisor and
guest.

>
> As mentioned previously, if you save save/restore the offset added to
> kvmclock on stop/cont (and the TSC MSR, forgot to mention that), no
> paravirt infrastructure is required. Which means the issue is also fi=
xed
> for older guests.
>
