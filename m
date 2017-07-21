From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 27/62] powerpc: helper to validate key-access permissions of a pte
Date: Fri, 21 Jul 2017 12:21:50 +0530
Message-ID: <87k232p9ix.fsf@skywalker.in.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-28-git-send-email-linuxram@us.ibm.com> <87mv7zpq1k.fsf@skywalker.in.ibm.com> <20170720221504.GJ5487@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170720221504.GJ5487@ram.oc3035372033.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

Ram Pai <linuxram@us.ibm.com> writes:

> On Thu, Jul 20, 2017 at 12:12:47PM +0530, Aneesh Kumar K.V wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> 
>> > helper function that checks if the read/write/execute is allowed
>> > on the pte.
>> >
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> > ---
>> >  arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
>> >  arch/powerpc/include/asm/pkeys.h             |   12 +++++++++
>> >  arch/powerpc/mm/pkeys.c                      |   33 ++++++++++++++++++++++++++
>> >  3 files changed, 49 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > index 30d7f55..0056e58 100644
>> > --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> > @@ -472,6 +472,10 @@ static inline void write_uamor(u64 value)
>> >  	mtspr(SPRN_UAMOR, value);
>> >  }
>> >
>> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>> > +extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
>> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>> > +
>> >  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>> >  				       unsigned long addr, pte_t *ptep)
>> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
>> > index bbb5d85..7a9aade 100644
>> > --- a/arch/powerpc/include/asm/pkeys.h
>> > +++ b/arch/powerpc/include/asm/pkeys.h
>> > @@ -53,6 +53,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
>> >  		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
>> >  }
>> >
>> > +static inline u16 pte_to_pkey_bits(u64 pteflags)
>> > +{
>> > +	if (!pkey_inited)
>> > +		return 0x0UL;
>> 
>> Do we really need that above check ? We should always find it
>> peky_inited to be set. 
>
> Yes. there are cases where pkey_inited is not enabled. 
> a) if the MMU is radix.
That should be be a feature check

> b) if the PAGE size is 4k.

That is a kernel config change

> c) if the device tree says the feature is not available
> d) if the CPU is of a older generation. P6 and older.

Both feature check.

how about doing something like

static inline u16 pte_to_pkey_bits(u64 pteflags)
{
	if (!(pteflags & H_PAGE_KEY_MASK))
		return 0x0UL;

	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
}

We still have to look at the code generated to see it is really saving
something.

-aneesh

