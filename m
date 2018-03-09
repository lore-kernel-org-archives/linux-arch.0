From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Date: Fri, 9 Mar 2018 12:06:31 -0800
Message-ID: <20180309200631.GS1060@ram.oc3035372033.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <87lgf1v9di.fsf@concordia.ellerman.id.au>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lgf1v9di.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: mingo@redhat.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 09, 2018 at 09:19:53PM +1100, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> 
> Please explain this in much more detail. Is it an ABI change?

Not necessarily an ABI change. older binary applications  will continue
to work. It can be considered as a bug-fix.

> 
> And why did we just notice this?

Yes. this was noticed by an application vendor.

> 
> > The patch relaxes the restriction.
> >
> > Tested on powerpc and x86_64.
> 
> Thanks, but please split the patch, one for each arch.

Will do.
RP
