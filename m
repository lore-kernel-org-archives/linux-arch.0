From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC v6 20/62] powerpc: store and restore the pkey state across context switches
Date: Mon, 31 Jul 2017 23:00:53 +1000
Message-ID: <87wp6o4v7e.fsf@concordia.ellerman.id.au>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-21-git-send-email-linuxram@us.ibm.com> <878tj94wfo.fsf@linux.vnet.ibm.com> <20170729233113.GH5664@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170729233113.GH5664@ram.oc3035372033.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, arnd@arndb.de, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Ram Pai <linuxram@us.ibm.com> writes:
> On Thu, Jul 27, 2017 at 02:32:59PM -0300, Thiago Jung Bauermann wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> > index 2ad725e..9429361 100644
>> > --- a/arch/powerpc/kernel/process.c
>> > +++ b/arch/powerpc/kernel/process.c
>> > @@ -1096,6 +1096,11 @@ static inline void save_sprs(struct thread_struct *t)
>> >  		t->tar = mfspr(SPRN_TAR);
>> >  	}
>> >  #endif
>> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> > +	t->amr = mfspr(SPRN_AMR);
>> > +	t->iamr = mfspr(SPRN_IAMR);
>> > +	t->uamor = mfspr(SPRN_UAMOR);
>> > +#endif
>> >  }
>> >
>> >  static inline void restore_sprs(struct thread_struct *old_thread,
>> > @@ -1131,6 +1136,14 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>> >  			mtspr(SPRN_TAR, new_thread->tar);
>> >  	}
>> >  #endif
>> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> > +	if (old_thread->amr != new_thread->amr)
>> > +		mtspr(SPRN_AMR, new_thread->amr);
>> > +	if (old_thread->iamr != new_thread->iamr)
>> > +		mtspr(SPRN_IAMR, new_thread->iamr);
>> > +	if (old_thread->uamor != new_thread->uamor)
>> > +		mtspr(SPRN_UAMOR, new_thread->uamor);
>> > +#endif
>> >  }
>> 
>> Shouldn't the saving and restoring of the SPRs be guarded by a check for
>> whether memory protection keys are enabled? What happens when trying to
>> access these registers on a CPU which doesn't have them?
>
> Good point. need to guard it.  However; i think, these registers have been
> available since power6.

The kernel runs on CPUs much older than that.

IAMR was added on Power8.

And performance is also an issue, so we should only switch them when we
need to.

cheers
