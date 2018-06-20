From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v13 15/24] selftests/vm: powerpc implementation for
 generic abstraction
Date: Wed, 20 Jun 2018 08:06:25 -0700
Message-ID: <04cdd1a3-94d3-e99b-6e19-699c790383cd@intel.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-16-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1528937115-10132-16-git-send-email-linuxram@us.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

> +static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
> +{
> +#ifdef si_pkey
> +	return &si->si_pkey;
> +#else
> +	return (u32 *)(((u8 *)si) + si_pkey_offset);
> +#endif
>  }

FWIW, this isn't ppc-specific.


> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index f43a319..88dfa40 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -197,17 +197,18 @@ void dump_mem(void *dumpme, int len_bytes)
>  
>  int pkey_faults;
>  int last_si_pkey = -1;
> +void pkey_access_allow(int pkey);
>  void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  {
>  	ucontext_t *uctxt = vucontext;
>  	int trapno;
>  	unsigned long ip;
>  	char *fpregs;
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>  	pkey_reg_t *pkey_reg_ptr;
> -	u64 siginfo_pkey;
> +#endif /* defined(__i386__) || defined(__x86_64__) */
> +	u32 siginfo_pkey;
>  	u32 *si_pkey_ptr;
> -	int pkey_reg_offset;
> -	fpregset_t fpregset;
>  
>  	dprint_in_signal = 1;
>  	dprintf1(">>>>===============SIGSEGV============================\n");
> @@ -217,12 +218,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  
>  	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
>  	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
> -	fpregset = uctxt->uc_mcontext.fpregs;
> -	fpregs = (void *)fpregset;
> +	fpregs = (char *) uctxt->uc_mcontext.fpregs;
>  
>  	dprintf2("%s() trapno: %d ip: 0x%016lx info->si_code: %s/%d\n",
>  			__func__, trapno, ip, si_code_str(si->si_code),
>  			si->si_code);
> +
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +
>  #ifdef __i386__
>  	/*
>  	 * 32-bit has some extra padding so that userspace can tell whether
> @@ -230,20 +233,28 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  	 * state.  We just assume that it is here.
>  	 */
>  	fpregs += 0x70;
> -#endif
> -	pkey_reg_offset = pkey_reg_xstate_offset();
> -	pkey_reg_ptr = (void *)(&fpregs[pkey_reg_offset]);
> +#endif /* __i386__ */
>  
> -	dprintf1("siginfo: %p\n", si);
> -	dprintf1(" fpregs: %p\n", fpregs);
> +	pkey_reg_ptr = (void *)(&fpregs[pkey_reg_xstate_offset()]);
>  	/*
> -	 * If we got a PKEY fault, we *HAVE* to have at least one bit set in
> +	 * If we got a key fault, we *HAVE* to have at least one bit set in
>  	 * here.
>  	 */
>  	dprintf1("pkey_reg_xstate_offset: %d\n", pkey_reg_xstate_offset());
>  	if (DEBUG_LEVEL > 4)
>  		dump_mem(pkey_reg_ptr - 128, 256);
>  	pkey_assert(*pkey_reg_ptr);
> +#endif /* defined(__i386__) || defined(__x86_64__) */

The series up to this point has been looking pretty nice and broken out
and easy to read.  It goes off the rails a bit here.  Adding #ifdefs and..

> +	dprintf1("siginfo: %p\n", si);
> +	dprintf1(" fpregs: %p\n", fpregs);
> +
> +	si_pkey_ptr = siginfo_get_pkey_ptr(si);
> +	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
> +	dump_mem(si_pkey_ptr - 8, 24);
> +	siginfo_pkey = *si_pkey_ptr;
> +	pkey_assert(siginfo_pkey < NR_PKEYS);
> +	last_si_pkey = siginfo_pkey;
>  
>  	if ((si->si_code == SEGV_MAPERR) ||
>  	    (si->si_code == SEGV_ACCERR) ||
> @@ -252,22 +263,21 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  		exit(4);
>  	}
>  
> -	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
> -	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
> -	dump_mem((u8 *)si_pkey_ptr - 8, 24);
> -	siginfo_pkey = *si_pkey_ptr;
> -	pkey_assert(siginfo_pkey < NR_PKEYS);
> -	last_si_pkey = siginfo_pkey;

Moving random code around with no explanation.

> -	dprintf1("signal pkey_reg from xsave: "PKEY_REG_FMT"\n", *pkey_reg_ptr);
>  	/*
>  	 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
>  	 * checking
>  	 */
>  	dprintf1("signal pkey_reg from  pkey_reg: "PKEY_REG_FMT"\n",
>  			__read_pkey_reg());
> -	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
> -	*(u64 *)pkey_reg_ptr = 0x00000000;
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	dprintf1("signal pkey_reg from xsave: "PKEY_REG_FMT"\n", *pkey_reg_ptr);
> +	*(u64 *)pkey_reg_ptr &= clear_pkey_flags(siginfo_pkey,
> +			PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
> +#elif __powerpc64__
> +	pkey_access_allow(siginfo_pkey);
> +#endif
> +	shadow_pkey_reg &= clear_pkey_flags(siginfo_pkey,
> +			PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction "
>  			"to continue\n");
>  	pkey_faults++;
> @@ -1331,9 +1341,8 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
>  	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
>  	lots_o_noops_around_write(&scratch);
>  	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
> -	ptr_contents = read_ptr(p1);
> -	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
> -	expected_pkey_fault(pkey);
> +
> +	expect_fault_on_read_execonly_key(p1, pkey);
>  }

While none of this is a deal-breaker (as I said, I feel like the
selftests/ rules are a bit more lax) this does kinda break the illusion
of a nice, broken out series.

Could you address this a bit in the changelog at least, please?
