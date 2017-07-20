From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v6 01/62] powerpc: Free up four 64K PTE bits in 4K backed
 HPTE pages
Date: Thu, 20 Jul 2017 15:03:58 -0700
Message-ID: <20170720220358.GH5487@ram.oc3035372033.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-2-git-send-email-linuxram@us.ibm.com>
 <87d18vr6yw.fsf@skywalker.in.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d18vr6yw.fsf@skywalker.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 20, 2017 at 11:21:51AM +0530, Aneesh Kumar K.V wrote:
> 
> .....
> 
> >  	/*
> > @@ -116,8 +104,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> >  		 * On hash insert failure we use old pte value and we don't
> >  		 * want slot information there if we have a insert failure.
> >  		 */
> > -		old_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > -		new_pte &= ~(H_PAGE_HASHPTE | H_PAGE_F_GIX | H_PAGE_F_SECOND);
> > +		old_pte &= ~(H_PAGE_HASHPTE);
> > +		new_pte &= ~(H_PAGE_HASHPTE);
> >  		goto htab_insert_hpte;
> >  	}
> 
> With the current path order and above hunk we will breaks the bisect I guess. With the above, when
> we convert a 64k hpte to 4khpte, since this is the first patch, we
> should clear that H_PAGE_F_GIX and H_PAGE_F_SECOND. We still use them
> for 64k. I guess you should move this hunk to second patch.

true. it should move to the next patch. Will fix it.
RP
