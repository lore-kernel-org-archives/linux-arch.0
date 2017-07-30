From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v6 21/62] powerpc: introduce execute-only pkey
Date: Sat, 29 Jul 2017 17:51:37 -0700
Message-ID: <20170730005137.GK5664@ram.oc3035372033.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-22-git-send-email-linuxram@us.ibm.com>
 <87shhgdx5i.fsf@linux.vnet.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87shhgdx5i.fsf@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 28, 2017 at 07:17:13PM -0300, Thiago Jung Bauermann wrote:
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -97,3 +97,60 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> >  	init_iamr(pkey, new_iamr_bits);
> >  	return 0;
> >  }
> > +
> > +static inline bool pkey_allows_readwrite(int pkey)
> > +{
> > +	int pkey_shift = pkeyshift(pkey);
> > +
> > +	if (!(read_uamor() & (0x3UL << pkey_shift)))
> > +		return true;
> > +
> > +	return !(read_amr() & ((AMR_RD_BIT|AMR_WR_BIT) << pkey_shift));
> > +}
> > +
> > +int __execute_only_pkey(struct mm_struct *mm)
> > +{
> > +	bool need_to_set_mm_pkey = false;
> > +	int execute_only_pkey = mm->context.execute_only_pkey;
> > +	int ret;
> > +
> > +	/* Do we need to assign a pkey for mm's execute-only maps? */
> > +	if (execute_only_pkey == -1) {
> > +		/* Go allocate one to use, which might fail */
> > +		execute_only_pkey = mm_pkey_alloc(mm);
> > +		if (execute_only_pkey < 0)
> > +			return -1;
> > +		need_to_set_mm_pkey = true;
> > +	}
> > +
> > +	/*
> > +	 * We do not want to go through the relatively costly
> > +	 * dance to set AMR if we do not need to.  Check it
> > +	 * first and assume that if the execute-only pkey is
> > +	 * readwrite-disabled than we do not have to set it
> > +	 * ourselves.
> > +	 */
> > +	if (!need_to_set_mm_pkey &&
> > +	    !pkey_allows_readwrite(execute_only_pkey))
		^^^^^
	Here uamor and amr is read once each.

> > +		return execute_only_pkey;
> > +
> > +	/*
> > +	 * Set up AMR so that it denies access for everything
> > +	 * other than execution.
> > +	 */
> > +	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
> > +			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
		^^^^^^^
		here amr and iamr are written once each if the
		the function returns successfully.
> > +	/*
> > +	 * If the AMR-set operation failed somehow, just return
> > +	 * 0 and effectively disable execute-only support.
> > +	 */
> > +	if (ret) {
> > +		mm_set_pkey_free(mm, execute_only_pkey);
		^^^
		here only if __arch_set_user_pkey_access() fails
		amr and iamr and uamor will be written once each.

> > +		return -1;
> > +	}
> > +
> > +	/* We got one, store it and use it from here on out */
> > +	if (need_to_set_mm_pkey)
> > +		mm->context.execute_only_pkey = execute_only_pkey;
> > +	return execute_only_pkey;
> > +}
> 
> If you follow the code flow in __execute_only_pkey, the AMR and UAMOR
> are read 3 times in total, and AMR is written twice. IAMR is read and
> written twice. Since they are SPRs and access to them is slow (or isn't
> it?), is it worth it to read them once in __execute_only_pkey and pass
> down their values to the callees, and then write them once at the end of
> the function?

If my calculations are right: 
	uamor may be read once and may be written once.
	amr may be read once and is written once.
	iamr is written once.
So not that bad, i think.

RP
