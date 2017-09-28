From: Borislav Petkov <bp@suse.de>
Subject: Re: [Part1 PATCH v5 15/17] percpu: Introduce DEFINE_PER_CPU_DECRYPTED
Date: Thu, 28 Sep 2017 22:32:19 +0200
Message-ID: <20170928203219.7xzy3cnzgdraaic3@pd.tnic>
References: <20170927151329.70011-1-brijesh.singh@amd.com>
 <20170927151329.70011-16-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170927151329.70011-16-brijesh.singh@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 27, 2017 at 10:13:27AM -0500, Brijesh Singh wrote:
> KVM guest defines three per-CPU variables (steal-time, apf_reason, and
> avic_eio) which are shared between a guest and a hypervisor. When SEV
> is active, memory is encrypted with a guest-specific key, and if the
> guest OS wants to share the memory region with the hypervisor then it
> must clear the C-bit (i.e set decrypted) before sharing it.
> 
> DEFINE_PER_CPU_DECRYPTED can be used to define the per-CPU variables
> which will be shared between a guest and a hypervisor.
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
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 19 +++++++++++++++++++
>  include/linux/percpu-defs.h       | 15 +++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
