From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3] x86: treat pkey-0 special
Date: Thu, 15 Mar 2018 10:39:59 -0700
Message-ID: <20180315173959.GE1060@ram.oc3035372033.ibm.com>
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
 <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
 <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
 <20180315172129.GD1060@ram.oc3035372033.ibm.com>
 <2bf8e659-5a8d-a2d5-ea52-e4d395ea2201@intel.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2bf8e659-5a8d-a2d5-ea52-e4d395ea2201@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 10:31:51AM -0700, Dave Hansen wrote:
> On 03/15/2018 10:21 AM, Ram Pai wrote:
> > On Thu, Mar 15, 2018 at 08:55:31AM -0700, Dave Hansen wrote:
> >> On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
> >>>> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
> >>> Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
> >>> ever. If it does, then this wants to be fixed.
> >> I was thinking that we _do_ actually want it to seem allocated.  It just
> >> get "allocated" implicitly when an mm is created.  I think that will
> >> simplify the code if we avoid treating it specially in as many places as
> >> possible.
> > I think, the logic that makes pkey-0 special must to go
> > in arch-neutral code.   How about checking for pkey-0 in sys_pkey_free()
> > itself?
> 
> This is for protection against shooting yourself in the foot?  Yes, that
> can go in sys_pkey_free().
> 
> Does this need manpage and/or selftests updates?

Yes. it needs selftest, manpage and documentation updates too.

Unfortunately I am not getting enough reviewed-by for my selftests
and documentation changes. :-(  Need help!


-- 
Ram Pai
