From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12 12/22] selftests/vm: generic cleanup
Date: Fri, 16 Mar 2018 15:22:14 -0700
Message-ID: <920ff5c4-153a-488c-e502-82ea43adbd79@intel.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-13-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-13-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 02/21/2018 05:55 PM, Ram Pai wrote:
> cleanup the code to satisfy coding styles.
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |   81 ++++++++++++++------------
>  1 files changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 6054093..6fdd8f5 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -4,7 +4,7 @@
>   *
>   * There are examples in here of:
>   *  * how to set protection keys on memory
> - *  * how to set/clear bits in pkey registers (the rights register)
> + *  * how to set/clear bits in Protection Key registers (the rights register)

I don't think CodingStyle says to do this. :)

>   *  * how to handle SEGV_PKUERR signals and extract pkey-relevant
>   *    information from the siginfo
>   *
> @@ -13,13 +13,18 @@
>   *	prefault pages in at malloc, or not
>   *	protect MPX bounds tables with protection keys?
>   *	make sure VMA splitting/merging is working correctly
> - *	OOMs can destroy mm->mmap (see exit_mmap()), so make sure it is immune to pkeys
> - *	look for pkey "leaks" where it is still set on a VMA but "freed" back to the kernel
> - *	do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
> + *	OOMs can destroy mm->mmap (see exit_mmap()),
> + *			so make sure it is immune to pkeys
> + *	look for pkey "leaks" where it is still set on a VMA
> + *			 but "freed" back to the kernel
> + *	do a plain mprotect() to a mprotect_pkey() area and make
> + *			 sure the pkey sticks

Ram, I'm not sure where this came from, but this looks horrid.  Please
don't do this to the file

>   * Compile like this:
> - *	gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> - *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc      -o protection_keys    -O2 -g -std=gnu99
> + *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
> + *	gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99
> + *			 -pthread -Wall protection_keys.c -lrt -ldl -lm
>   */

Please just leave this, or remove it from the file.  It was a long line
so it could be copied and pasted, this ruins that.



>  #define _GNU_SOURCE
>  #include <errno.h>
> @@ -251,26 +256,11 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  	dprintf1("signal pkey_reg from  pkey_reg: %016lx\n", __rdpkey_reg());
>  	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
>  	*(u64 *)pkey_reg_ptr = 0x00000000;
> -	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
> +	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction "
> +			"to continue\n");
>  	pkey_faults++;
>  	dprintf1("<<<<==================================================\n");
>  	return;
> -	if (trapno == 14) {
> -		fprintf(stderr,
> -			"ERROR: In signal handler, page fault, trapno = %d, ip = %016lx\n",
> -			trapno, ip);
> -		fprintf(stderr, "si_addr %p\n", si->si_addr);
> -		fprintf(stderr, "REG_ERR: %lx\n",
> -				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
> -		exit(1);
> -	} else {
> -		fprintf(stderr, "unexpected trap %d! at 0x%lx\n", trapno, ip);
> -		fprintf(stderr, "si_addr %p\n", si->si_addr);
> -		fprintf(stderr, "REG_ERR: %lx\n",
> -				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
> -		exit(2);
> -	}
> -	dprint_in_signal = 0;
>  }

I think this is just randomly removing code now.

I think you should probably just drop this patch.  It's not really
brining anything useful.
