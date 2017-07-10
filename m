From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 33/38] powerpc: Deliver SEGV signal on pkey violation
Date: Mon, 10 Jul 2017 08:38:53 +0530
Message-ID: <4cbcc16c-7597-7aa1-ddea-b6bef25df11b@linux.vnet.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-34-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

On 07/06/2017 02:52 AM, Ram Pai wrote:
> The value of the AMR register at the time of exception
> is made available in gp_regs[PT_AMR] of the siginfo.
> 
> The value of the pkey, whose protection got violated,
> is made available in si_pkey field of the siginfo structure.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/ptrace.h |    3 ++-
>  arch/powerpc/kernel/signal_32.c        |    5 +++++
>  arch/powerpc/kernel/signal_64.c        |    4 ++++
>  arch/powerpc/kernel/traps.c            |   14 ++++++++++++++
>  4 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 8036b38..7ec2428 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -108,8 +108,9 @@ struct pt_regs {
>  #define PT_DAR	41
>  #define PT_DSISR 42
>  #define PT_RESULT 43
> -#define PT_DSCR 44
>  #define PT_REGS_COUNT 44
> +#define PT_DSCR 44
> +#define PT_AMR	45

Why PT_DSCR was moved down ? This change is redundant here.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
