From: Tejun Heo <tj@kernel.org>
Subject: Re: [Part1 PATCH v4 15/17] percpu: introduce
 DEFINE_PER_CPU_UNENCRYPTED
Date: Mon, 18 Sep 2017 20:13:44 -0700
Message-ID: <20170919031344.GL378890@devbig577.frc2.facebook.com>
References: <20170916123418.37807-1-brijesh.singh@amd.com>
 <20170916123418.37807-16-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36113 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdISDNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2017 23:13:48 -0400
Content-Disposition: inline
In-Reply-To: <20170916123418.37807-16-brijesh.singh@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org

On Sat, Sep 16, 2017 at 07:34:16AM -0500, Brijesh Singh wrote:
> When SEV is active, memory is encrypted with guest-specific key, and if
> guest OS wants to share the memory region with hypervisor then it must
> clear the C-bit (i.e set unencrypted) before sharing it.
> 
> DEFINE_PER_CPU_UNENCRYPTED can be used to define the per-cpu variables
> which will be shared between guest and hypervisor. Currently, KVM defines
> three variables (steal-time, apf_reason, and avic_eio) which are shared
> with hypervisor.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: linux-arch@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
