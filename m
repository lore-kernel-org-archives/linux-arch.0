From: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v9 44/51] selftest/vm: powerpc implementation for generic
 abstraction
Date: Thu, 9 Nov 2017 16:47:15 -0200
Message-ID: <20171109184714.xs523k4cvmqghew3@gmail.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-45-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509958663-18737-45-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Hi Ram,

On Mon, Nov 06, 2017 at 12:57:36AM -0800, Ram Pai wrote:
> @@ -206,12 +209,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  
>  	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
>  	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
> -	fpregset = uctxt->uc_mcontext.fpregs;
> -	fpregs = (void *)fpregset;

Since you removed all references for fpregset now, you probably want to
remove the declaration of the variable above.

> @@ -219,20 +224,21 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
>  	 * state.  We just assume that it is here.
>  	 */
>  	fpregs += 0x70;
> -#endif
> -	pkey_reg_offset = pkey_reg_xstate_offset();

With this code, you removed all the reference for variable
pkey_reg_offset, thus, its declaration could be removed also.

> -	*(u64 *)pkey_reg_ptr = 0x00000000;
> +	dprintf1("si_pkey from siginfo: %lx\n", si_pkey);
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	dprintf1("signal pkey_reg from xsave: %016lx\n", *pkey_reg_ptr);
> +	*(u64 *)pkey_reg_ptr &= reset_bits(si_pkey, PKEY_DISABLE_ACCESS);
> +#elif __powerpc64__

Since the variable pkey_reg_ptr is only used for Intel code (inside
#ifdefs), you probably want to #ifdef the variable declaration also,
avoid triggering "unused variable" warning on non-Intel machines.
