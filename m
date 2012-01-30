From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 3/4 V10] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Mon, 30 Jan 2012 17:18:52 +0100
Message-ID: <4F26C2EC.5070303@siemens.com>
References: <1326825641-15765-1-git-send-email-emunson@mgebm.net> <1326825641-15765-4-git-send-email-emunson@mgebm.net> <4F26B220.9050101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4F26B220.9050101@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2012-01-30 16:07, Avi Kivity wrote:
> On 01/17/2012 08:40 PM, Eric B Munson wrote:
>> Now that we have a flag that will tell the guest it was suspended, create an
>> interface for that communication using a KVM ioctl.
>>
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index e1d94bf..1931e5c 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -1491,6 +1491,19 @@ following algorithm:
>>  Some guests configure the LINT1 NMI input to cause a panic, aiding in
>>  debugging.
>>  
>> +4.65 KVMCLOCK_GUEST_PAUSED
>> +
>> +Capability: KVM_CAP_GUEST_PAUSED
>> +Architechtures: Any that implement pvclocks (currently x86 only)
>> +Type: vcpu ioctl
> 
> vm ioctl.
> 
>> +Parameters: None
>> +Returns: 0 on success, -1 on error
>> +
>> +This signals to the host kernel that the specified guest is being paused by
>> +userspace.  The host will set a flag in the pvclock structure that is checked
>> +from the soft lockup watchdog.  This ioctl can be called during pause or
>> +unpause.
>> +
>>  5. The kvm_run structure
>>  
>>  
>> +/*
>> + * kvm_set_guest_paused() indicates to the guest kernel that it has been
>> + * stopped by the hypervisor.  This function will be called from the host only.
>> + */
>> +static int kvm_set_guest_paused(struct kvm *kvm)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	struct pvclock_vcpu_time_info *src;
>> +	int i;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		if (!vcpu->arch.time_page)
>> +			continue;
>> +		src = &vcpu->arch.hv_clock;
>> +		src->flags |= PVCLOCK_GUEST_STOPPED;
> 
> This looks racy.  The vcpu can remove its kvmclock concurrently with
> this access, and src will be NULL.

There is no race here (src is member of the vcpu), but arch.time might
have become invalid. KVM_REQ_CLOCK_UPDATE instead of mark_page_dirty
would indeed be the way to go. Trivial solution, I would say.

However, the concept of "guest stopped" has VM, not VCPU scope. That
makes the call more appropriate as a VM ioctl. If that thing should
really become per-vcpu, at least call it KVMCLOCK_VCPU_STOPPED.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
