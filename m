From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 00/21] KVM: Cleanup and unify kvm_mmu_memory_cache
 usage
Date: Tue, 23 Jun 2020 10:26:58 -0700
Message-ID: <20200623172658.GF23842@linux.intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17255 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732961AbgFWR1C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 13:27:02 -0400
Content-Disposition: inline
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>, Peter Feiner <pfeiner@google.com>, Peter Shier <pshier@google.com>, Junaid Shahid <junaids@google.com>, Christoffer Dall <christoffer.dall@arm.com>

On Mon, Jun 22, 2020 at 01:08:01PM -0700, Sean Christopherson wrote:
> Note, patch 18 will conflict with the p4d rework in 5.8.  I originally
> stated I would send v2 only after that got pulled into Paolo's tree, but
> I got my timing wrong, i.e. I was thinking that would have already
> happened.  I'll send v3 if necessary.  I wanted to get v2 out there now
> that I actually compile tested other architectures.

Gah, too impatient by one day :-)  I'll spin v3 later in the week.
