From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v10 27/27] mm: display pkey in smaps if
 arch_pkeys_enabled() is true
Date: Tue, 30 Jan 2018 08:28:34 -0800
Message-ID: <20180130162834.GB5411@ram.oc3035372033.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
 <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
 <20180130121611.GC26445@dhcp22.suse.cz>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180130121611.GC26445@dhcp22.suse.cz>
Sender: linux-doc-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 30, 2018 at 01:16:11PM +0100, Michal Hocko wrote:
> On Thu 18-01-18 17:50:48, Ram Pai wrote:
> [...]
> > @@ -851,9 +848,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
> >  			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
> >  
> >  	if (!rollup_mode) {
> > -		arch_show_smap(m, vma);
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +		if (arch_pkeys_enabled())
> > +			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > +#endif
> >  		show_smap_vma_flags(m, vma);
> >  	}
> > +
> 
> Why do you need to add ifdef here? The previous patch should make
> arch_pkeys_enabled == F when CONFIG_ARCH_HAS_PKEYS=n.

You are right. it need not be wrapped in CONFIG_ARCH_HAS_PKEYS.  I had to do it
because vma_pkey(vma)  is not defined in some architectures.

I will provide a generic vma_pkey() definition for architectures that do 
not support PKEYS.



> Btw. could you
> merge those two patches into one. It is usually much easier to review a
> new helper function if it is added along with a user.


ok.

Thanks,
RP

